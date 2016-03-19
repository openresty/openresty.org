<!---
    @title         Using LuaRocks
    @creator       Yichun Zhang
    @created       2011-08-07 02:32 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-11-08 04:31 GMT
    @changes       44
--->

使用 LuaRocks

这个示例中展示了在 [OpenResty](openresty.html) 中使用 [LuaRocks](http://www.luarocks.org/) 。这个示例已经在
Linux 和 Mac OS X 下，通过 Lua 解释器与 [LuaJIT](luajit.html) 的测试。

LuaRocks 是一个部署和管理 Lua 模块的系统。

 LuaRocks 允许通过 "rocks" 安装独立的 Lua 模块,并且包含附加的版本信息。我们假设您已经在默认的路径里面安装了[OpenResty](openresty.html).即, `/usr/local/openresty`. 您可以根据实际安装[OpenResty](openresty.html)的路径来调整本示例中的路径。如果您还没有安装 OpenResty, 请查看[下载](download.html) 与[安装](installation.html)页.


#  安装 LuaRocks
首先让我们来安装 LuaRocks:

请您从 http://www.luarocks.org/en/Download 下载最新版本的 LuaRocks
. 当写这篇文章的时候,最新版本为 `2.0.4.1`（译注：目前最新版本已经更新到了2.0.5）,
在这个示例中我们将使用这个版本。（译注:如果您在安装了2.0.6版本的
LuaRocks，请记得填写正确的Lua解释器的地址,无论您使用 Lua
官方的解释器还是选择 [LuaJIT](luajit.html)，请确保安装时 LuaRocks
能找到它,否则 LuaRocks 可能报错）

```
wget http://luarocks.org/releases/luarocks-2.0.4.1.tar.gz
tar -xzvf luarocks-2.0.4.1.tar.gz
cd luarocks-2.0.4.1/
./configure
make
sudo make install
```


#  通过 LuaRocks安装 Lua MD5 库
在本示例中, 我们将使用 Lua MD5 library 作为服务器上的一个例子,
所以我们需要通过 LuaRocks 来安装它:

```
sudo luarocks install md5
```


#  配置我们的 OpenResty 应用
Let's change the current directory to `/usr/local/openresty/nginx/`:

```
cd /usr/local/openresty/nginx/
```

然后, 使用您喜欢的编辑器（例如 vim 或 emacs ）根据下面的内容，编辑
`conf/nginx.conf`  文件:

```
worker_processes  1;   # we could enlarge this setting on a multi-core machine
error_log  logs/error.log warn;

events {
    worker_connections  1024;
}

http {
    lua_package_path 'conf/?.lua;;';

    server {
        listen       80;
        server_name  localhost;

        location = /luarocks {
            content_by_lua '
                local foo = require("foo")
                foo.say("hello, luarocks!")
            ';
        }
    }
}
```

最后,我们创建下面两个 Lua 模块文件 `conf/foo.lua`

```
-- conf/foo.lua

module("foo", package.seeall)

local bar = require "bar"

ngx.say("bar loaded")

function say (var)
    bar.say(var)
end
```

和 `conf/bar.lua` 文件

```
-- conf/bar.lua

module("bar", package.seeall)

local rocks = require "luarocks.loader"
local md5 = require "md5"

ngx.say("rocks and md5 loaded")

function say (a)
    ngx.say(md5.sumhexa(a))
end
```


#  开启 [Nginx](nginx.html) 服务
现在我们通过 [Nginx](nginx.html) 开启我们的应用:

```
ulimit -n1024   # increase the maximal fd count limit per process
./sbin/nginx
```

如果您已经开启了 [Nginx](nginx.html) 服务,请先关闭后在重新开启:

```
./sbin/nginx -s stop  #（译注:我们也可以使用平滑重启命令完成此操作 ./sbin/nginx -s reload）
```


#  测试我们的应用
现在我们通过`curl` 工具或者任意兼容HTTP协议的浏览器测试我们的应用:

```
curl http://localhost/luarocks
```

我们在第一次运行的时候得到以下的内容:

```
rocks and md5 loaded
bar loaded
85e73df5c41378f830c031b81e4453d2
```

第二次运行的时候得到以下内容:

```
85e73df5c41378f830c031b81e4453d2
```

之所以会出现这样的输出数据是因为 [Lua Nginx Module](lua-nginx-module.html) 默认缓存了已经加载过的Lua模块
并且这些输出数据的代码是在 Lua 加载时运行的因此他们将不会在执行.

现在，让我们来做一些基准测试吧:

```
ab -c10 -n50000 http://127.0.0.1/luarocks
```

测试在是我的 Thinkpad T400 笔记本上进行的(Core2Duo T9600 CPU),
下面是测试中产生的数据


```
Server Software:        ngx_openresty/1.0.4.2rc10
Server Hostname:        localhost
Server Port:            80

Document Path:          /luarocks
Document Length:        33 bytes

Concurrency Level:      10
Time taken for tests:   3.052 seconds
Complete requests:      50000
Failed requests:        0
Write errors:           0
Total transferred:      9400188 bytes
HTML transferred:       1650033 bytes
Requests per second:    16380.48 [#/sec] (mean)
Time per request:       0.610 [ms] (mean)
Time per request:       0.061 [ms] (mean, across all concurrent requests)
Transfer rate:          3007.41 [Kbytes/sec] received
```

注意哦上面测试的吞吐量是由单个 nginx 进程达到的。当您自己做这样的基准测试时，请注意在
`nginx.conf` 中设定的错误日志级别以及不要超过您本地机器运行的动态端口范围，否则的话测试的数据会显著变慢。


# 已知问题
[OpenResty](openresty.html) 1.0.4.2rc10之前的版本, 将导致`lua_code_cache`  运行时在LuaRocks
中的[Lua Nginx Module](lua-nginx-module.html) 模块抛出以下异常`error.log`:

```
lua handler aborted: runtime error: stack overflow
```

如果您正在使用的 [OpenResty](openresty.html) 版本是 1.0.4.2rc10 之前的版本,
请您考虑升级.
