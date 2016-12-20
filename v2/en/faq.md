<!---
    @title         Frequently Asked Questions
    @creator       Yichun Zhang
    @created       Sat Jun 13 16:59:32 2015 +0800
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      Fri Jul 31 11:36:02 2015 +0800
    @changes       6
--->

Questions and Answers
======================

Does OpenResty follow NGINX's mainline releases?
------------------------------------------------

Yes, sure. OpenResty is currently employing a "tick-tock" release model. Each "tock" release (usually) upgrades the bundled NGINX core to the latest
mainline release from the official NGINX team, followed by one ore more "tick" releases focusing on OpenResty's own features and enhancements without
upgrading the NGINX core.

The first part of the OpenResty release version numbers is the version of the bundled NGINX core. For instance, OpenResty 1.7.10.2 bundles
NGINX 1.7.10 while OpenResty 1.9.1.1 bundles NGINX 1.9.1.

How often does OpenResty make a new release?
--------------------------------------------

We are trying to make a new release of OpenResty every one or two months. It may sometimes take longer because this project is mainly based on volunteers.

How should I report a problem?
------------------------------

Whenever you run into a problem, you are encouraged to report to the openresty-en (English) mailing list or the openresty (Chinese)
mailing list (depending on your language). See the [Community](community.html) page
for more details. But please don't cross-post.

You are highly recommended to provide as much details as possible while reporting a problem, for example,

* anything interesting in your Nginx's error log file (`logs/error.log`), if any,
* the exact versions of the related software you're using, including but not limited to the type/version of your
operating system, the version of your OpenResty (or the versions of your Nginx, ngx\_lua,
Lua/LuaJIT and other modules used if you are not using the OpenResty bundle),
* a minimal and standalone example that can reliably reproduce the issue on our side, and
* enable the Nginx/OpenResty's [debugging logs](http://nginx.org/en/docs/debugging_log.html) and
provide the *complete* logs for the guilty request you performed (the same `./configure --with-debug` command line also applies perfectly well to the OpenResty bundle).

The more details you provide, the more likely and faster we can help you out. Most of the time,
you will find your own mistakes while minimizing your problematic example or looking at your
Nginx error log files.

If you are absolutely certain that you have run into a real bug, then you are encouraged to
file a ticket in the corresponding project's GitHub Issues page. For example, the GitHub Issues page for
the ngx\_lua component is
https://github.com/openresty/lua-nginx-module/issues. The GitHub issues pages for OpenResty's components
are all considered English-only. Never use other languages like Chinese there. It is still fine, however, to just send a mail to one of the mailing lists mentioned above; but again, please do not cross-post.

Why can't I use Lua 5.2 or later?
---------------------------------

Lua 5.2+ are incompatible with Lua 5.1 on both the C API land and
the Lua land (including various language semantics). If as you said there are quite
a few people already using ngx\_lua + Lua 5.1, then linking against Lua 5.2+ will
probably break these people's existing Lua code. Lua 5.2+ are essentially incompatible different languages.

Supporting Lua 5.2+ requires nontrivial architectural changes in ngx\_lua's basic infrastructure.
The most troublesome thing is the quite different "environments" model in Lua 5.2+.
At this point, we would hold back adding support for Lua 5.2+ to ngx\_lua. Also, we do not want to
create confusions and incompatibilities on the Lua land for applications running atop ngx\_lua, as well
as all the existing lua-resty-\* libraries written in the Lua 5.1 language.

We believe it is better to stick with one Lua language in ngx\_lua. Chasing the Lua language's version
number has not many practical technical merits (if there were some political ones).

Can I use LuaJIT 2.0.x?
-----------------------

Yes sure. LuaJIT 2.0.x is always supported in OpenResty though LuaJIT 2.1+ is highly recommended.

Why does OpenResty use LuaJIT 2.1 by default?
---------------------------------------------

As of this writing, LuaJIT 2.1 is still officially "beta" but OpenResty is using LuaJIT 2.1 by default
and encourages use of it in production because

1. We always run the latest LuaJIT v2.1 in various large-scale server-side business software infrastructures.
2. All the recent performance improvements Cloudflare Inc. has
sponsored only land in v2.1.
3. For one of our typical Lua apps at the level of 10K+ LOC, LuaJIT
v2.1 gives over 100% over-all speedup as compared to LuaJIT 2.0.x
(when lua-resty-core is used).
4. Many important bug fixes in the v2.1 branch have been back ported
to 2.0.x series because these bugs were also in 2.0.x (just hidden for
long). The 2.0.3 release is such a proof.

We highly recommend LuaJIT 2.1 because we really need speed in OpenResty though you always have the freedom
to use LuaJIT 2.0.x or even the standard Lua 5.1 interpreter in OpenResty instead.

Why can't I use duplicate configuration directives?
---------------------------------------------------

Most of the ngx\_lua module's configuration directives do not allow duplication in the same context.
For example, the following `nginx.conf` snippet

```nginx
    location / {
        content_by_lua_file conf/a.lua;
        content_by_lua_file conf/b.lua;
    }
```

will yield the following error while starting nginx:

```
nginx: [emerg] "content_by_lua_file" directive is duplicate in
```

People may want to use duplicate directives to split complicated Lua code base into multiple
separate `.lua` files. This is not allowed and it must be inefficient even if it were to be implemented in ngx\_lua.

The recommended way to organize your Lua code base is to use Lua's own module mechanism:

http://www.lua.org/manual/5.1/manual.html#5.3

You can put your unrelated Lua code into separate Lua module files, for example,

```lua
-- foo.lua
local _M = {}
function _M.go() ... end
return _M
```

```lua
-- bar.lua
local _M = {}
function _M.go() ... end
return _M
```

And finally, just `require` them in the entry point like this:

```lua
location / {
    content_by_lua '
        require("foo").go()
        require("bar").go()
    ';
}
```

You will need to add the path of your Lua modules to Lua's module search paths, for instance,

```nginx
lua_package_path "$prefix/conf/?.lua;;";
```

in the `http {}` block in your `nginx.conf`.

You can take a look at OpenResty's standard Lua libraries for real-world examples, like openresty/lua-resty-redis.

Use of Lua's native module mechanism is also very efficient. Thanks to the built-in caching mechanism
in Lua's built-in function `require()` (via the global `package.loaded` table anchored in the Lua registry, thus being shared
by the whole Lua VM).

Can I use custom loggers in Lua?
--------------------------------

Yes, sure. You have multiple options:

1. Write a custom Lua logger library manipulating files with [LuaJIT FFI](http://luajit.org/ext_ffi.html) directly. You need to access the low level file I/O
syscalls like `open`, `write`, and `close` without going through libc's buffered I/O layer. This is important because
this can ensure atomicity when multiple (worker) processes are appending data to the same file (in the appending mode).
You can share the resulting file descriptors (fd) returned from the `open` syscall on the NGINX worker process level
by the [this technique](https://github.com/openresty/lua-nginx-module#data-sharing-within-an-nginx-worker).
Maybe someday OpenResty will ship with a standard `lua-resty-logger-file` library; you are welcome to contribute
such a library :)
2. Avoid file I/O in the nginx server altogether by employing the [lua-resty-logger-socket](https://github.com/cloudflare/lua-resty-logger-socket) library.
This library can send your log data to the remote endpoint (like a `syslog-ng` server) via sockets and 100% nonblocking
I/O. Cloudflare, for example, has been using this library heavily across its global network.
Unlike NGINX core's native syslog loggers, this one tries very hard to avoid data loss in erroneous conditions.

Socket-based logging is generally recommended for performance reasons because file I/O may almost always block
the NGINX event loop (or some OS threads if enabling the new NGINX thread pool support for file I/O, still adding extra overhead).

Why am I seeing the "lua tcp socket connect timed out" error?
-------------------------------------------------------------

The error happens when the connect operation to the backend times out. The backend can be Redis, Memcached, MySQL, or any other thing you are
currently using. This error log message is generated by the
[ngx_lua](https://github.com/openresty/lua-nginx-module#readme) module's automatic error logger
for cosockets. If you already handle all the cosocket errors properly in your own Lua code,
then you can suppress the automatic logger by turning off the [lua_socket_log_errors](https://github.com/openresty/lua-nginx-module#lua_socket_log_errors) in your `ngnx.conf`:

```nginx
lua_socket_log_errors off;
```

The cause of the connect timeout errors can be complicated but generally falls into the following categories:

1. your redis server is too busy to accept new connections and the redis server's TCP stack
is dropping packets when the `accept()` queue is full, or
2. your nginx server is too busy to respond to new I/O events (like doing CPU intensive
computations or blocking on system calls),
3. your timeout threshold on the client side is too small to account for the latency over the wire and the network stack.

You can try the following to address the issue:

1. Scale your backend to multiple nodes so as to utilize more (CPU) resources (for example, the redis server is single-threaded
and can easily exhaust a single CPU core).
2. Increase the backlog setting in your backend server (for example, there is a `tcp-backlog`
parameter to tune in the `redis.conf` configuration file); the backlog setting determins the length limit
of your `accept()` queue on your backend server.
3. Check whether your nginx server is too busy doing CPU intensive work or blocking syscalls
(like disk I/O syscalls) by using the [flame graph tools](profiling.html),
4. Increase the timeout threshold in your Lua code if it makes sense,
5. Automatically retry `connect()` in your Lua code for one or two more time with an optional delay
when your `connect()` call fails.

Why am I always getting 0 from `getreusedtimes()` or `get_reused_times()` calls?
--------------------------------------------------------------------------------

This usually means that you fail to put your backend connections into the connection pool
in the first place and the connection pool is always empty so that `connect()` calls always
establish new connections instead of reusing existing ones.

The solution is to always check the return values of the `setkeepalive()` or `set_keepalive()`
calls and handle errors properly if any. When you get errors from `setkeepalive()` or `set_keepalive()` calls, then
we can work on solving the problem (like avoid calling `setkeepalive()` or `set_keepalive()` at the wrong times).

Can I set timeout threshold on subrequests?
-------------------------------------------

Yes, you can, but not directy via an option or parameter on the subrequest calls like
[ngx.location.capture](https://github.com/openresty/lua-nginx-module#ngxlocationcapture) and
[echo_subrequest](https://github.com/openresty/echo-nginx-module#echo_subrequest).
Rather, you should specify the timeout configurations in the location *targeted* by your subrequest. For example,

```nginx
location = /api {
    content_by_lua '
        local res = ngx.locatin.capture("/sub")
    ';
}

location = /sub {
    internal;
    proxy_connect_timeout 100ms;
    proxy_read_timeout 100ms;
    proxy_send_timeout 100ms;
    proxy_pass http://backend;
}
```

Here you specify all the timeout thresholds provided by the [ngx_proxy](http://nginx.org/en/docs/http/ngx_http_proxy_module.html)
module in the (internal) location (`= /sub`) accessed by your subrequest.

Can I access remote URLs via ngx.location.capture or alike?
-----------------------------------------------------------

Yes, but not directly. The subrequest API targets nginx's "locations". So you need a dedicated
location (be it "internal" or not) and configure the standard
[ngx_proxy](http://nginx.org/en/docs/http/ngx_http_proxy_module.html) module there.

Alternatively, you may consider using one of the `lua-resty-http*` libraries contributed
by the community. To name a few:

* Brian Akins' [lua-resty-http-simple](https://github.com/bakins/lua-resty-http-simple)
* James Hurst's [lua-resty-http](https://github.com/pintsized/lua-resty-http)

Contributing to this FAQ
=========================

This FAQ document is hosted on GitHub and periodically updated to the openresty.org site:

https://github.com/openresty/openresty.org

You can edit the `faq.md` file in the repository above and create pull requests so that I can incorporate your patches.
