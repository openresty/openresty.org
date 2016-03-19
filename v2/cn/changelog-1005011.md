<!---
    @title         ChangeLog 1.5.11
    @creator       Yichun Zhang
    @created       2014-03-31 05:12 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      
    @changes       1
--->


#  Version 1.5.11.1 - 30 March 2014
* upgraded [LuaJIT](luajit.html) to v2.1-20140330.
    * feature: included Mike Pall's new "trace stitching" feature that can compile around most of the [NYI items](http://wiki.luajit.org/NYI). thanks [CloudFlare Inc.](http://www.cloudflare.com/) for sponsoring the development. This helps compiling more Lua code. For example, it gives 10% ~ 40% speedup in simple test cases of [Lua Resty MySQL Library](lua-resty-mysql-library.html) out of the box.
    * bugfix: included all the new bug fixes from Mike Pall, most of which are very obscure bugs in the JIT compiler hidden for years.
    * relaxed the hard-coded heuristic limit further to 100 for loopunroll.
    * feature: applied John Marino's patch for compiling [LuaJIT](luajit.html) on DragonFlyBSD. thanks lhmwzy for proposing the patch.
* upgraded the [Nginx](nginx.html) core to 1.5.11.
    * see the changes here: http://nginx.org/en/CHANGES
* bugfix: applied the patch to the NGINX core for the latest SPDY security vulnerability
(CVE-2014-0133).
* feature: added support for DragonFlyBSD to `./configure`. thanks lhmwzy for
the patch.
* bugfix: disabled the -Werror option for clang because it caused build failures
at least in recent Mac OS X systems. thanks Hamish Forbes for the report.
* feature: bundled new component [Lua Resty Upstream Healthcheck Library](lua-resty-upstream-healthcheck-library.html) 0.01.
    * see the documentation for details: https://github.com/agentzh/lua-resty-upstream-healthcheck#readme
* feature: bundled new component [Lua Upstream Nginx Module](lua-upstream-nginx-module.html) 0.01.
    * see the documentation for details: https://github.com/agentzh/lua-upstream-nginx-module#readme
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.9.6.
    * feature: added new configuration directives, [init_worker_by_lua](https://github.com/chaoslawful/lua-nginx-module/#init_worker_by_lua) and [init_worker_by_lua_file](https://github.com/chaoslawful/lua-nginx-module/#init_worker_by_lua_file), to run Lua code upon every nginx worker process's startup.
    * feature: added new API function [ngx.config.nginx_configure()](https://github.com/chaoslawful/lua-nginx-module/#ngxconfignginx_configure) to return the NGINX `./configure` arguments string to the Lua land. thanks Tatsuhiko Kubo for the patch.
    * feature: added new API function [ngx.resp.get_headers()](https://github.com/chaoslawful/lua-nginx-module/#ngxrespget_headers) for fetching all the response headers. thanks Tatsuhiko Kubo for the patch.
    * feature: added new API function [ngx.worker.pid()](https://github.com/chaoslawful/lua-nginx-module/#ngxworkerpid) for retrieving the current nginx worker process's pid.
    * feature: explicitly check Lua langauge version mismatch; we only accept the Lua 5.1 language (for now).
    * bugfix: accessing a cosocket object from a request which does not create it could lead to segmentation faults. now we throw out a Lua error "bad request" properly in this case.
    * change: it is now the user's responsibility to clear the captures table for [ngx.re.match()](https://github.com/chaoslawful/lua-nginx-module/#ngxrematch).
    * bugfix: we should prefix our chunk names for from-string lua source (which also leads to nicer error messages). thanks Mike Pall for the catch.
    * bugfix: subrequests initiated by [ngx.location.capture*](https://github.com/chaoslawful/lua-nginx-module/#ngxlocationcapture) with the HEAD method did not result in responses without response bodies. thanks Daniel for the report.
    *  bugfix: segfault might happen in the FFI API for destroying compiled PCRE regexes, which affects libraries like [Lua Resty Core Library](lua-resty-core-library.html). thanks Dane Kneche.
    * bugfix: fixes for small string buffer arguments in the C API for FFI-based implementations of [shdict:get()](https://github.com/chaoslawful/lua-nginx-module/#ngxshareddictget).
    * bugfix: fixed the error message buffer overwrite in the C API for FFI-based [ngx.re](https://github.com/chaoslawful/lua-nginx-module/#ngxrematch) implementations.
    * bugfix: use of the public C API in other nginx C modules (extending [Lua Nginx Module](lua-nginx-module.html)) lead to compilation errors and warnings when the Microsoft C compiler is used. thanks Edwin Cleton for the report.
    * bugfix: segmentation faults might happen when multiple "light threads" in the same request manipuate a stream cosocket object in turn. thanks Aviram Cohen for the report.
    * bugfix: timers created by ngx.timer.at() might not be aborted prematurely upon nginx worker exit. thanks Hamish Forbes for the report.
    * bugfix: the return value sizes of the C functions `ngx_http_lua_init_by_inline` and `ngx_http_lua_init_by_file` were wrong.
    * optimize: coroutine status string look-up is now a bit more efficient by specifying the string lengths explicitly. thanks Tatsuhiko Kubo for the patch.
    * various code refactoring.
* upgraded [Lua Resty Core Library](lua-resty-core-library.html) to 0.0.5.
    * change: now it is the user's responsibility to clear the input result table.
    * feature: [resty.core.regex](https://github.com/agentzh/lua-resty-core#restycoreregex): added new function `set_buf_grow_ratio` to control the buffer grow ratio (default 2.0).
    * bugfix: segmentation fault might happen due to assignments to [ngx.header.HEADER](https://github.com/chaoslawful/lua-nginx-module/#ngxheaderheader) because we did not anchor the memory buffer properly which might get collected prematurely.
    * bugfix: [ngx.req.get_headers](https://github.com/chaoslawful/lua-nginx-module/#ngxreqget_headers): we need to anchor the string buffer being casted otherwise it might be accidentally garbage collected when we still hold a C pointer to it. this bug might lead to segmentation faults.
    * optimize: cache the match captures table for [ngx.re.gsub()](https://github.com/chaoslawful/lua-nginx-module/#ngxregsub) when a function-typed "replace" argument is specified. this gives a remarkable speedup.
    * optimize: [resty.core.regex](https://github.com/agentzh/lua-resty-core#restycoreregex): forked the original shared code paths to multiple specialized versions, which helps the JIT compiler.
    * optimize: [resty.core.regex](https://github.com/agentzh/lua-resty-core#restycoreregex): cache the parsing results for the regex option strings. thanks Mike Pall for the suggestion.
* upgraded [Lua Resty Redis Library](lua-resty-redis-library.html) to 0.20.
    * feature: added new redis 2.8.0 commands: `scan`, `sscan`, `hscan`, and `zscan`. thanks Dragonoid for the patch.
    * feature: [the read_reply()](https://github.com/agentzh/lua-resty-redis#read_reply) method can now be re-tried immediately after a "timeout" error is returned.
    * bugfix: the `unsubscribe`/`subscribe` commands could not be called after [read_reply()](https://github.com/agentzh/lua-resty-redis#read_reply) returned "timeout". thanks doujiang for the patch.
    * bugfix: we incorrectly allowed reusing redis connections in the "subscribed" state. thanks doujiang for the patch.
* upgraded [Lua Cjson Library](lua-cjson-library.html) to 2.1.0.1.
    * rebased on lua-cjson 2.1.0: http://www.kyne.com.au/~mark/software/NEWS-lua-cjson.txt the most notable new feature is the `cjson.safe` module.
    * feature: applied Jiale Zhi's patch to add the new config function `encode_empty_table_as_object` so that we can encode empty Lua tables into empty JSON arrays.
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to 0.26.
    * bugfix: HEAD requests might result in response bodies.
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.52.
    * bugfix: HEAD subrequests could still result in non-empty response bodies.
See [ChangeLog 1.5.8](changelog-1005008.html) for change log for [OpenResty](openresty.html) 1.5.8.x.
