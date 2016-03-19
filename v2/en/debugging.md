<!---
    @title         Debugging
    @creator       Yichun Zhang
    @created       2013-10-06 18:12 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2013-10-06 18:24 GMT
    @changes       10
--->

You should always check out [Nginx](nginx.html)'s error log file (specified
by the `error_log` directive in `nginx.conf`) for any errors or warnings.

If you prefer redirecting common Lua errors to the HTTP response body during
Lua development, you can put a Lua [pcall](http://www.lua.org/manual/5.1/manual.html#pdf-pcall) call
on the top level of your Lua code to catch and redirect any Lua exceptions.
But keep in mind, not all errors can be captured this way because you could
have errors when sending out the response, then it is impossible to put such
errors into the response body.

During Lua code development, you can disable the [Lua code cache](http://wiki.nginx.org/HttpLuaModule#lua_code_cache) temporarily
so that you do not have to reload the [Nginx](nginx.html) server for your (external)
Lua code changes to take effect.

Also, it is strongly recommended to follow the test-driven development workflow.
For example, [Lua Resty Redis Library](lua-resty-redis-library.html) uses the
[Test::Nginx](http://search.cpan.org/perldoc?Test%3A%3ANginx) test scaffold
to drive its (declarative) [test suite](https://github.com/agentzh/lua-resty-redis/tree/master/t/).

If you are on Linux, there are quite many real-time analysing tools based on
[systemtap](http://sourceware.org/systemtap/), which can be used to inspect
a running [Nginx](nginx.html) worker process in various ways:

    https://github.com/agentzh/nginx-systemtap-toolkit
You can find additional tools in the stap++ project:

    https://github.com/agentzh/stapxx
These tools can not only debug functional problems, but also profile online
servers to find performance bottlenecks.
