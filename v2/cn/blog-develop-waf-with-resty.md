<!---
    @title         使用OpenResty搭建WAF应用
    @creator       qinguanri
    @created       2016-07-30 16:00 GMT
    @modifier      qinguanri
    @modifier_link 
    @modified      
    @changes       1
--->


> 时间：2016-07-13 作者：周俊 编辑：覃冠日 校验：李张勇 [原文链接](http://mp.weixin.qq.com/s?__biz=MzIwODA4NjMwNA==&mid=2652897814&idx=1&sn=317b98c2b3044f80b4f0da82928496ee&scene=0#wechat_redirect)

## OpenResty简介

OpenResty是将Nginx与 Lua粘合的高性能 Web 平台，其内部集成了大量精良的 Lua 库、第三方模块等。用于方便地搭建高并发、扩展性极高的动态Web 应用、Web 服务和动态网关。从听说到使用了OpenResty之后，感觉这是瑞士军刀，应用实在太广泛。

我们公司目前没有专门的安全工程师，安全的一些工作就落到我们运维工程师头上，遇到安全问题就找到我们身上了，因此我想做一个web应用防火墙，让开发人员不用考虑安全问题只关心业务开发；因此就考虑开发WAF来解决现在遇到的问题。

## WAF简介

WAF就是web应用防火墙，是对网站进行安全防护的。一个http/https的请求，包含数据： url、get参数、post参数、协议版本/method/host/agent/cookie等http请求头。 如下图所示：

<html>
<img src="/images/blog/develop-waf-with-resty-web.png" width="700">
</html>

而WAF就可以对请求中的参数、访问频率进行安全检查（正则匹配为主），触发危险操作的请求，就进行拦截、记录操作。 当然WAF解决是还是web安全1.0和2.0的问题。对应业务逻辑本身WAF目前是不能通用的进行防护的。

### WEB安全1.0

在1.0时代下，攻击是通过服务器漏洞（IIS6溢出等）、WEB应用漏洞（SQL注入、文件上传、命令执行、文件包含等）属于服务器类的攻击，该类型漏洞虽然经历了这么多年，很遗憾，此类漏洞还是存在，并且重复在犯相同的错误。

### WEB安全2.0

随着社交网络的兴起，原来不被重视的XSS、CSRF等漏洞逐渐进入人们的视野，那么在2.0时代，漏洞利用的思想将更重要，发挥你的想象，可以有太多可能。

### WEB安全3.0

同开发设计模式类似（界面、业务逻辑、数据），3.0将关注应用本身的业务逻辑和数据安全，如密码修改绕过、二级密码绕过、支付类漏洞、刷钱等类型的漏洞，故注重的是产品本身的业务安全、数据安全。

## WAF设计、编码

我设计的WAF过滤流程，只是根据我的理解来设计他的处理流程，不一定是最合理的，但是解决了我们现在遇到的问题。整个设计是在Nginx执行的相应阶段完成一些相应的动作，如在init阶段完成数据初始化、rewrite阶段暂时没用，预计未来跳转使用（如验证码、set cookie等）、access阶段实施拦截防护（大多数过滤在这完成）、body_filter阶段进行响应内容的替换（如非法关键词替换）。

### init 阶段
在nginx初始化阶段，我们可以初始化如ip黑白名单；初始化ip计数器；此处我们用到了几个共享字典来存储这些数据（如1MB大约存ip数量1000个）。

```
lua_shared_dicttoken_list 20m;    # token 存放
lua_shared_dictcount_dict 5m;     # 用于拦截计数数据的保存
lua_shared_dictconfig_dict 5m;    # 保存config中部分配置
lua_shared_dictip_dict 30m;       # 用于记录黑、白名单ip
lua_shared_dictlimit_ip_dict 100m;   # 用于 IP 访问计数统计
```

在初始化阶段，会读取全局配置文件config.json和规则配置文件xxx_Mod.json，存放到config_dict中；其次，读取配置的ip黑白名单存放到ip_dict；然后定义一些公共函数如sayHtml,sayFile,sayLua等等。

### access 阶段

我们主要的拦截就在该阶段操作的，整体的防护分为13个步骤进行分层防护的，如下图所示。

<html>
<img src="/images/blog/develop-waf-with-resty-access.png" width="700developwithby">
</html>

0. realIpFrom_Mod==>获取用户真实IP：获取用户真实ip 在一些网络场景下，用户真实ip在http头中，所以我们先要把真实ip取出来；

1. ip_Mod==>ip黑白名单的过滤（黑白名单）：ip白名单后续的规则都跳过了，请求继续走；ip黑名单，就是在应用层进行拦截，请求到这里就停了，不会到后端了；

2. host_method_Mod==>host&method过滤（白名单）：这里就是域名准入，和method的准入了，可以配置允许的host，允许的method；

3. app_Mod==>自定义过滤动作：这里提供的几个动作是：返回字符串、返回文件内容、动态执行lua脚本、记录log、匹配白名单（ip,args参数）；基本匹配的是：host、url在后续的场景中我在举一些例子；

4. referer_Mod==>referer规则过滤（白名单）：一些图片资源的防盗链，站外的CSRF就是通过referer来过滤的；

5. url_Mod==>url过滤（黑、白名单）：
~~~
“\.(svn|git|htaccess|bash_history)” — 敏感文件、目录、备份文件黑名单拦截；
“\.(css|js|flv|swf|woff|txt)$” – 静态资源文件白名单，这样后续的过滤规则都会跳过，减少总的匹配次数，提高效率；以及访问频率统计时，去掉这些静态文件的统计；
~~~
6. header_Mod==>header过滤（黑名单）：一些扫描器，爆破工具，黑客工具有时在http头中会有一些标记，这里我们就可以过掉；

```
{
        "state": "on",
        "url":["*",""],
        "hostname":["*",""],
        "header":["Acunetix_Aspect","*",""]        
    },
    -- 扫描器 wvs 的标记
    {
        "state": "on",
        "url":["*",""],
        "hostname":["*",""],
        "header": ["X_Scan_Memo","*",""]        
    }
    -- 扫描器 Scan 的标记
```

7. useragent_Mod==>user-agent过滤（黑名单）：这里是过滤一些常见黑客工具，压测工具等；
havij|sqlmap|nmap|HTTrack...
8. cookie_Mod==>cookie过滤（黑名单）：这里是对cookie进行SQL注入、XSS、遍历、敏感文件读取等一些规则的过滤；
9. args_Mod==>GET参数过滤（黑名单）：这里是对args参数进行SQL注入、XSS、遍历、敏感文件读取等一些规则的过滤；

```lua
if config_is_on("args_Mod") then
    local args_mod =getDict_Config("args_Mod")
    local args =ngx.unescape_uri(ngx.var.query_string)
    if args ~= "" then
        for i,v in ipairs(args_mod) do
            if v.state == "on" then
                if remath(host,v.hostname[1],v.hostname[2])then    
                    if remath(args,v.args[1],v.args[2]) then
                       Set_count_dict("args_deny count")
                        action_deny()
                        break
                    end
                end
            end
        end
    end
end
```

看一下代码，对于参数污染这种绕WAF的方式，还有url编码绕过方式也是无法绕过的，代码中首先进行了转码、在取整个args，而不是一个一个取在拼接上；

11. post_Mod==>post参数过滤（黑名单）：这里是对post参数进行SQL注入、XSS、遍历、敏感文件读取等一些规则的过滤；

```lua
localfunction get_postargs()   
    ngx.req.read_body()
    local data = ngx.req.get_body_data() --ngx.req.get_post_args()
    if not data then
        local datafile =ngx.req.get_body_file()
        if datafile then
            local fh, err = io.open(datafile,"r")
            if fh then
                fh:seek("set")
                data = fh:read("*a")
                fh:close()
            end
        end
    end
    return ngx.unescape_uri(data)
end
if config_is_on("post_Mod") and method == "POST" then
    --debug("post_Mod is on")
    local post_mod =getDict_Config("post_Mod")
    local postargs = get_postargs()
    if postargs ~= "" then
        for i,v in ipairs(post_mod) do
            if v.state == "on" then
                --debug(i.." post_modstate is on")
                if remath(host,v.hostname[1],v.hostname[2]) then                
                    if remath(postargs,v.post[1],v.post[2]) then
                       Set_count_dict("post_deny count")
                        debug("post_Mod :"..postargs.."No : "..i,"post_deny",ip)
                        action_deny()
                        break
                    end
                end
            end
        end
    end
end
```

代码中是取整个body的，而不是通过ngx.req.get_post_args()，且最后也转码了，所以通过参数污染、url转码是不能绕过的；

12. network_Mod==>访问频率过滤（频率黑名单）：先看一个配置：
-- 单个URL的频率限制
-- 因为一个网站一般情况下容易被CC的点就那么几个

```
{
    "state": "on",
   "network":{"maxReqs":10,"pTime":10,"blackTime":600},
    "hostname":[["101.200.122.200","127.0.0.1"],"table"],
    "url":["/api/time",""]
}
-- 限制整个网站的（范围大的一定要放下面）
{
    "state": "on",
   "network":{"maxReqs":30,"pTime":10,"blackTime":600},
    "hostname":[["101.200.122.200","127.0.0.1"],"table"],
    "url":["*",""]
}
-- 限制ip的不区分host和url
{
    "state": "on",
   "network":{"maxReqs":100,"pTime":10,"blackTime":600},
    "hostname":["*",""],
    "url":["*",""]
}
```

相对来说比较灵活，可以配置某个url的ip访问频率，以及在前面提到过，一些静态文件css/js/img文件是可以不计数的。

## body_filter 阶段

1. replace_Mod==>应答内容的替换：这里就是对返回内容的动态替换的功能，比如替换一些非法关键词等。

### 场景应用

1. 简单的正则添加：如我们需要过滤以.sql结尾的请求URL，那么就在url_Mod中设置

```
{
        "state": "on",
        "hostname": [
            "*",
            ""
        ],
        "url": [
           "\\.(bak|inc|old|mdb|sql|backup|java|class)$",
            "jio"
        ],
        "action": "deny"
}
```

2. 我们需要设置管理后台仅允许部分ip可以访问，那么就在app_Mod中设置

```
{
        "state": "on",
        "action":["allow"],
       "allow":["ip",["106.37.236.170","1.1.1.1"],"table"],
        "hostname":[["101.200.122.200","127.0.0.1"],"table"],
        "url":["/api/.*","jio"]
}
```

看着配置也比较容易理解，host是101.200.122.200或者127.0.0.1的，访问的目录是/api/.*的，仅允许allow中的2个IP。

3. CC攻击防护

### 攻击类型

1）、行为（GET、POST等）：目前主要还是这两种method攻击为主，其他的基本没有，因为比较互联网上的web应用也都是这两种居多；

2）、被攻击的点（前端的纬度） a： 用户可直接访问的URL（搜索、重CPU、IO、数据库的点）；b：嵌入的URL（验证码、ajax接口等）；c：面向非浏览器的接口（一些API、WEBservice等）；d：基于特定web服务、语言等的特定攻击（慢速攻击、PHP-dos等）。

### 防护方法

1）网络层：通过访问ip的频率、统计等使用阀值的方式进行频率和次数的限制，黑名单方式；

2）网络层+应用层：在后来的互联网网络下，有了CDN的加入，现在增加的网络层的防护需要扩展，那么统计的IP将是在HTTP头中的IP，仍然使用频率、次数、黑名单的方式操作。

3）应用层：TAG验证、SET COOKIE、URL跳转、JS跳转、验证码、页面嵌套、强制静态缓存等；防护是需要根据攻击点进行分别防护的，如攻击的是嵌入的url，我们就不能使用JS跳转、302验证码等这样的方法；在多次的CC防护实战中，如使用url跳转、setcookie；在新型的CC攻击下，这些防护都已经失效了。浏览器是可以执行JS和flash的，这里我分享一些基于JS的防护算法，flash需要自己去写（比js复杂一些），可以实现flash应用层的安全防护和防页面抓取（开动你的大脑吧）；

4）客户端防护：使用JS进行前端的防护（浏览器识别、鼠标轨迹判断、url有规则添加尾巴（args参数）、随机延迟、鼠标键盘事件获取等）其实这里非常复杂，如浏览器的识别 ie 支持 !-[1,]这个特殊JS，一些浏览器有自定义标签等等；

5）服务端防护：url添加的尾巴（args参数）是服务器动态生成的token，而不是使用静态的正则去匹配其合法性；

6）特定攻击：该类特定攻击，可以通过特征快速匹配出来（慢速攻击、PHP5.3的http头攻击）。

目前已经有了一些应用层的防护都是基于js的（还得自己写js），后续有时间会把验证码等加上，这个很实用。
误报肯定是有的，使用时需要根据自己的业务进行调整。

### 动态配置规则

提供了相应的http接口来增删相应的规则；方便规则的维护。

更多案例和配置示例请参考https://github.com/starjun/openstar。

由于本应用时为了解决当前公司的存在的问题，代码质量、代码实现可能存在不到位的地方，多多探讨。感谢春哥、OpenResty社区、loveshell。
