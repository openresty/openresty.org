<!---
    @title         UPYUN的ngx_lua最佳技术实践
    @creator       覃冠日,李张勇
    @created       2016-07-30 17:24 GMT
    @modifier      覃冠日,李张勇
    @modifier_link 覃冠日,李张勇
    @modified      2016-07-30 17:24 GMT
    @changes       1
--->

> 作者：又拍云 &nbsp; 时间:&nbsp;2015-04-16 &nbsp;[原文链接](http://blog.sina.com.cn/s/blog_94c587f40102vm7k.html)

ngx_lua 是一个 NGINX 的第三方扩展模块，它能够将 Lua 代码嵌入到 NGINX 中来执行。

<html>
<img src="/images/blog/ngx-lua-at-upyun-icon.png" width="500">
</html>

UPYUN 的 CDN 大量使用了 NGINX 作为反向代理服务器，其中绝大部分的业务逻辑已经由 Lua 来驱动了。

关于这个主题，之前在 OSC 源创会 2014 北京站 和 SegmentFault D-Day 2015 南京站 有做过简单分享，Slide 在【阅读原文】中可以看到。不过两次分享都由于个人时间安排上的不足，对 Keynote 后半部分偏实践的内容并没有做过多地展开，未免有些遗憾，因此，本文作为一个补充将尝试以文字的形式来谈谈这块内容。

## ngx_lua 和 Openresty

Openresty 是一套基于 NGINX 核心的相对完整的 Web 应用开发框架，包含了 ngx_lua 在内的众多第三方优秀的 NGINX C 模块，同时也集成了一系列常用的 lua-resty-* 类库，例如 redis, mysql 等，特别地，Openresty 依赖的 NGINX 核心和 LuaJIT 版本都是经过非常充分的测试的，也打了不少必要的补丁。

UPYUN CDN 并没有直接基于 Openresty 来开发，而是借鉴了 Openresty 的组织方式，把 ngx_lua 以及我们需要用到的 lua-resty-* 类库直接集成进来自己维护。这样做的原因是因为我们自身也有不少 C 模块存在，同时对 NGINX 核心偶尔也会有一些二次开发的需求，反而直接用 Openresty 会觉得有点不方便。除此之外，需要 ngx_lua 的地方，还是强烈推荐直接用 Openresty。

## Lua 的性能

相比 C 模块，Lua 模块在开发效率上有着天然的优势，语言表达能力也更强些，我们目前除了一些业务无关的基础模块首选用 C 来实现外，其它能用 Lua 的基本上都用 Lua 了。这里大家可能比较关心的是脚本语言性能问题，关于这一点，从我们的实践来看，其实不必过于担心的，我们几个比较大的业务模块例如防盗链等用 Lua 重写后，在线下压测和线上运行过程中，均没有发现任何明显的性能衰退迹象。当然，这里很大一部分功劳要归于 LuaJIT，相比 Lua 官方的 VM，LuaJIT 在性能上有着非常大的提升，另外，还可以利用 LuaJIT FFI 直接调用 C 级别的函数来优化 Lua 代码中可能存在的性能热点。

我们目前线上用的就是 LuaJIT 最新的 2.1 开发版，性能相比稳定版又有不少提升，具体可参考 LuaJIT 这个 NYI 列表。特别地，这里推荐用 Openresty 维护的 Fork 版本，兼容性更加有保障。

<html>
<img src="/images/blog/ngx-lua-at-upyun-luajit.png" width="700">
</html>

如上图所示，LuaJIT 在运行时会将热的 Lua 字节码直接翻译成机器码缓存起来执行。

另外，通过techempower 网站对 Openresty 的性能评测来看，相比 node.js, cowboy, beego 等，NGINX ngx_lua LuaJIT 这个组合的性能表现还是非常强劲的。

## 元数据同步与缓存

UPYUN CDN 线上通过 Redis 主从复制的方式由中心节点向外围节点同步用户配置，另外，由于 Redis 本身不支持加密传输，我们还在此基础上利用 stunnel 对传输通道进行了加密，保障数据传输的安全性。

### 1）缓存是万金油！

当然，不是说节点上有了 Redis 就能直接把它当做主要的缓存层来用了，要知道从 NGINX 到 Redis 获取数据是要消耗一次网络请求的，而这个毫秒级别的网络请求对于外围节点巨大的访问量来说是不可接受的。所以，在这里 Redis 更多地承担着数据存储的角色，而主要的缓存层则是在 NGINX 的共享内存上。

根据业务特点，我们的缓存内容与数据源是不需要严格保持一致的，既能够容忍一定程度的延迟，因此这里简单采用被动更新缓存的策略即可。ngx_lua 提供了一系列共享内存相关的 API (ngx.shared.DICT)，可以很方便地通过设置过期时间来使得缓存被动过期，值得一提的是，当缓存的容量超过预先申请的内存池大小的时候，ngx.shared.DICT.set 方法则会尝试以 LRU 的形式淘汰一部分内容。

以下代码片段给出了一个简陋的实现，当然我们下面会提到这个实现其实存在不少问题，但基本结构大致上是一样的，可以看到下面区分了 4 种状态，分别是：HIT 和 MISS, HIT_NEGATIVE 和 NO_DATA，前两者是对于有数据的情况而言的，后两者则是对于数据不存在的情况而言的，一般来说，对于 NO_DATA 我们会给一个相对更短的过期时间，因为数据不存在这种情况是没有一个固定的边界的，容易把容量撑满。

```lua
local metadata = ngx.shared.metadata
-- local key, bucket = ...
local value = metadata:get(key)
if value ~= nil then
   if value == "404" then
       return   -- HIT_NEGATIVE
   else
       return value -- HIT
   end
end
local rds = redis:new()
local ok, err = rds:connect("127.0.0.1", 6379)
if not ok then
   metadata:set(key, "404", 120) -- expires 2 minutes
   return -- NO_DATA
end
res, err = rds:hget("upyun:" .. bucket, ":something")
if not res or res == ngx.null then
   metadata:set(key, "404", 120)
   return -- NO_DATA
end
metadata:set(key, res, 300) -- expires 5 minutes
rds:set_keepalive()
return res -- MISS
```

### 2）什么是 Dog-Pile 效应？

在缓存系统中，当缓存过期失效的时候，如果此时正好有大量并发请求进来，那么这些请求将会同时落到后端数据库上，可能造成服务器卡顿甚至宕机。

很明显上面的代码也存在这个问题，当大量请求进来查询同一个 key 的缓存返回 nil 的时候，所有请求就会去连接 Redis，直到其中有一个请求再次将这个 key 的值缓存起来为止，而这两个操作之间是存在时间窗口的，无法确保原子性：

```lua
local value = metadata:get(key)
if value ~= nil then
   -- HIT or HIT_NEGATIVE
end
-- Fetch from Redis
```

避免 Dog-Pile 效应一种常用的方法是采用主动更新缓存的策略，用一个定时任务主动去更新需要变更的缓存值，这样就不会出现某个缓存过期的情况了，数据会永远存在，不过，这个不适合我们这里的场景；另一种常用的方法就是加锁了，每次只允许一个请求去更新缓存，其它请求在更新完之前都会等待在锁上，这样一来就确保了查询和更新缓存这两个操作的原子性，没有时间窗口也就不会产生该效应了。

## lua-resty-lock - 基于共享内存的非阻塞锁实现

首先，我们先来消除下大家对锁的抗拒，事实上这把共享内存锁非常轻量。第一，它是非阻塞的，也就是说锁的等待并不会导致 NGINX Worker 进程阻塞；第二，由于锁的实现是基于共享内存的，且创建时总会设置一个过期时间，因此这里不用担心会发生死锁，哪怕是持有这把锁的 NGINX Worker Crash 了。
那么，接下来我们只要利用这把锁按如下步骤来更新缓存即可：

1、检查某个 Key 的缓存是否命中，如果 MISS，则进入步骤 2。

2、初始化 resty.lock 对象，调用 lock 方法将对应的 Key 锁住，检查第一个返回值（即等待锁的时间），如果返回 nil，按相应错误处理；反之则进入步骤 3。

3、再次检查这个 Key 的缓存是否命中，如果依然 MISS，则进入步骤 4；反之，则通过调用 unlock方法释放掉这把锁。

4、通过数据源（这里特是 Redis）查询数据，把查询到的结果缓存起来，最后通过调用 unlock 方法释放当前 Hold 住的这把锁。

具体代码实现请参考：https://github.com/openresty/lua-resty-lock#for-cache-locks

## 当数据源故障的时候怎么办？NO_DATA？

同样，我们以上面的代码片段为例，当 Redis 返回出现 err 的时候，此时的状态即不是 MISS 也不是 NO_DATA，而这里统一把它归类到 NO_DATA 了，这就可能会引发一个严重的问题，假设线上这么一台 Redis 挂了，此时，所有更新缓存的操作都会被标记为 NO_DATA 状态，原本旧的拷贝可能还能用的，只是可能不是最新的罢了，而现在却都变成空数据缓存起来了。

那么如果我们能在这种情况下让缓存不过期是不是就能解决问题了？答案是 yes。

lua-resty-shcache - 基于 ngx.shared.DICT 实现了一个完整的缓存状态机，并提供了适配接口
恩，这个库几乎解决了我们上面提到的所有问题：1. 内置缓存锁实现 2. 故障时使用陈旧的拷贝 - STALE
所以，不想折腾的话，直接用它就是的。另外，它还提供了序列化、反序列化的接口，以 UPYUN 为例，我们的元数据原始格式是 JSON，为了减少内存大小，我们又引入了 MessagePack，所以最终缓存在 NGINX 共享内存上是被 MessagePack 进一步压缩过的二进制字节流。

当然，我们在这基础上还增加了一些东西，例如 shcache 无法区分数据源中数据不存在和数据源连接不上两种状态，因此我们额外新增了一个 NET_ERR 状态来标记连接不上这种情况。

## 序列化、反序列化太耗时？！

由于 ngx.shared.DICT 只能存放字符串形式的值（Lua 里面字符串和字节流是一回事），所以即使缓存命中，那么在使用前，还是需要将其反序列化为 Lua Table 才行。而无论是 JSON 还是 MessagePack，序列化、反序列操作都是需要消耗一些 CPU 的。

如果你的业务场景无法忍受这种程度的消耗，那么不妨可以尝试下这个库：https://github.com/openresty/lua-resty-lrucache 。它直接基于 LuaJIT FFI 实现，能直接将 Lua Table 缓存起来，这样就不需要额外的序列化反序列化过程了。当然，我们目前还没尝试这么做，如果要做的话，建议在 shcache 共享内存缓存层之上再加一层 lrucache，也就是多一级缓存层出来，且这层缓存层是 Worker 独立的，当然缓存过期时间也应该设置得更短些。

## 节点健康检查

### 被动健康检查与主动健康检查

我们先来看下 NGINX 基本的被动健康检查机制：

```
upstream api.com {
   server 127.0.0.1:12354 max_fails=15 fail_timeout=30s;
   server 127.0.0.1:12355 max_fails=15 fail_timeout=30s;
   server 127.0.0.1:12356 max_fails=15 fail_timeout=30s;
   proxy_next_upstream error timeout http_500;
   proxy_next_upstream_tries 2;
}
```

主要由 max_failes 和 fail_timeout 两个配置项来控制，表示在 fail_timeout 时间内如果该 server 异常次数累计达到 max_failes 次，那么在下一个 fail_timeout 时间内，我们就认为这台 server 宕机了，即在这段时间内不会再将请求转发给它。

其中判断某次转发到后端的请求是否异常是由 proxy_next_upstream 这个指令决定的，默认只有 error 和 timeout，这里新增了 http_500 这种情况，即当后端响应 500 的时候我们也认为异常。

proxy_next_upstream_tries 是 NGINX 1.7.5 版本后才引入的指令，可以允许自定义重试次数，原本默认重试次数等于 upstream 内配置的 server 个数（当然标记为 down 的除外）。

但只有被动健康检查的话，我们始终无法回避一个问题，即我们始终要将真实的线上请求转发到可能已经宕机的后端去，否则我们就无法及时感知到这台宕机的机器当前是不是已经恢复了。当然，NGINX PLUS 商业版是有主动监控检查功能的，它通过 health_check 这个指令来实现，当然我们这里就不展开说了，说多了都是泪。另外 Taobao 开源的 Tengine 也支持这个特性，建议大家也可以尝试下。

### lua-resty-checkups - 纯 Lua 实现的节点健康检查模块

这个模块目前是根据我们自身业务特点高度定制化的，因此暂时就没有开源出来了。agentzh 维护的 lua-resty-upstream-healthcheck模块跟我们这个很像但很多地方使用习惯都不太一样，当然，如果当初就有这样一个模块的话，说不定就不会重造轮子了 :-)

```
-- app/etc/config.lua
_M.global = {
   checkup_timer_interval = 5,
   checkup_timer_overtime = 60,
}
_M.api = {
   timeout = 2,
   typ = "general", -- http, redis, mysql etc.
   cluster = {
       {   -- level 1
           try = 2,
           servers = {
               { host = "127.0.0.1", port = 12354 },
               { host = "127.0.0.1", port = 12355 },
               { host = "127.0.0.1", port = 12356 },
           }
       },
       {   -- level 2
           servers = {
               { host = "127.0.0.1", port = 12360 },
               { host = "127.0.0.1", port = 12361 },
           }
       },
   },
}
```

上面简单给出了这个模块的一个配置示例，checkups 同时包括了主动和被动健康检查两种机制，我们看到上面 checkup_timer_interval 的配置项，就是用来设置主动健康检查间隔时间的。

特别地，我们会在 NGINX Worker 初始阶段创建一个全局唯一的 timer 定时器，它会根据设置的间隔时间进行轮询，对所监控的后端节点进行心跳检查，如果发现异常就会主动将此节点暂时从可用列表中剔除掉；反之，就会重新加入进来。checkup_timer_overtime 配置项，跟我们使用了共享内存锁有关，它用来确保即使 timer 所在的 Worker 由于某种异常 Crash 了，其它 Worker 也能在这个时间过期后新起一个新的 timer，当然存活的 timer 会始终去更新这个共享内存锁的状态。

其它被动健康检查方面，跟 NGINX 核心提供的机制差不多，我们也是仿照他们设计的，唯一区别比较大的是，我们提供了多级 server 的配置策略，例如上面就配置了两个 server 层级，默认始终使用 level 1，当且仅当 level 1 的节点全部宕机的时候，此时才会切换使用 level 2，特别地，每层 level 多个节点默认都是轮询的，当然我们也提供配置项可以特殊设置为一致性哈希的均衡策略。这样一来，同时满足了负载均衡和主备切换两种模式。

另外，基于 lua-upstream-nginx-module 模块，checkups 还能直接访问 nginx.conf 中的 upstream 配置，也可以修改某个 server 的状态，这样主动健康检查就能使用在 NGINX 核心的 upstream 模块上了。

## 其它

当然，ngx_lua 在 UPYUN 还有很多方面的应用，例如流式上传、跨多个 NGINX 实例的访问速率控制等，这里就不一一展开了，这次 Keynote 中也没有提到，以后有机会我们再谈谈。
