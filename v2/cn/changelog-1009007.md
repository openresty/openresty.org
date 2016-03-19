<!---
    @title         ChangeLog 1.9.7
    @creator       Yichun Zhang
    @created       2015-12-25 05:28 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2016-03-17 00:34 GMT
    @changes       4
--->


#  Version 1.9.7.4 - 16 March 2016
* bugfix: `./configure`: use of relative paths like "./nginx" in `--prefix=PATH` led
to compilation errors. thanks Tao Huang for the report.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.10.2.
    * feature: the C implementation for set SSL private keys now  supports non-RSA private keys as well. thanks Alessandro Ghedini for the patch.
    * feature: [ngx.log()](https://github.com/openresty/lua-nginx-module#ngxlog) and [print()](https://github.com/openresty/lua-nginx-module#print) now accept Lua tables with the `__tostring` metamethod.
    * feature: added new API, [ngx.config.subsystem](https://github.com/openresty/lua-nginx-module#ngxconfigsubsystem), which always takes the Lua string value "http" in this module.
    * feature: added new API function [ngx.socket.stream()](https://github.com/openresty/lua-nginx-module#ngxsocketstream) which is an alias to [ngx.socket.tcp()](https://github.com/openresty/lua-nginx-module#ngxsockettcp).
    * feature: added HTTP 2.0 support to [ngx.req.http_version()](https://github.com/openresty/lua-nginx-module#ngxreqhttp_version).
    * feature: this module can now be built as a "dynamic module" with NGINX 1.9.11+ via the `--add-dynamic-module=PATH` option of `./configure`.
    * bugfix: [balancer_by_lua*](https://github.com/openresty/lua-nginx-module#balancer_by_lua_block) did not respect "lua_code_cache off". thanks XI WANG for the report and Dejiang Zhu for the patch.
    * bugfix: hot loop might happen when [balancer_by_lua*](https://github.com/openresty/lua-nginx-module#balancer_by_lua_block) was used with the [keepalive](http://nginx.org/en/docs/http/ngx_http_upstream_module.html#keepalive) directive. thanks GhostZch for the report.
    * bugfix: [balancer_by_lua*](https://github.com/openresty/lua-nginx-module#balancer_by_lua_block) might crash the nginx worker when SSL (https) is used for upstream connections. thanks Alistair Wooldrige for the report.
    * bugfix: [stream-typed cosockets](https://github.com/openresty/lua-nginx-module#ngxsockettcp): we did not set the "error" field of the `ngx_connection_t` object which MIGHT lead to socket leaks.
    * bugfix: avoided a potential memory issue when the request handler is aborted prematurely (via [ngx.exit](https://github.com/openresty/lua-nginx-module#ngxexit), for example) while a light thread is still waiting on [ngx.flush(true)](https://github.com/openresty/lua-nginx-module#ngxflush).
    * bugfix: we might not respond to client abort events when [lua_check_client_abort](https://github.com/openresty/lua-nginx-module#lua_check_client_abort) is on.
    * bugfix: fixed the compiler warning "unused variable" when compiling with nginx cores older than 1.7.5 (exclusive). thanks Marc Neudert for the patch.
    * bugfix: fixed compilation errors with LibreSSL by disabling [ssl_certificiate_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_certificate_by_lua_block) and some [ngx.ssl](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md) API functions that are not supported by LibreSSL. thanks George Liu and Bret for the reports.
    * bugfix: fixed compilation errors with nginx 1.9.11+. thanks Charles R. Portwood II and Tomas Kvasnicka for the reports.
    * bugfix: fixed compatibility issues with other nginx modules loaded as "dynamic modules" in NGINX 1.9.11+.
    * bugfix: SSL: set error message on `i2d_X509()` failure as well. thanks Alessandro Ghedini for the patch.
    * bugfix: SSL: remove leading white space from error messages. thanks Alessandro Ghedini for the patch.
    * optimize: use `lua_pushliteral()` for string literals. thanks Tatsuhiko Kubo for the patch.
    * change: unmatched submatch captures are now set to `false` instead of `nil` in the captures table (named captures are not affected). thanks Julien Desgats for the patch.
    * change: [ngx.req.get_post_args](https://github.com/openresty/lua-nginx-module#ngxreqget_post_args): returns error message instead of raising an exception when request body is in temp file. thanks yejingx for the patch.
    * change: [ngx.shared.DICT](https://github.com/openresty/lua-nginx-module#ngxshareddict): throws a Lua error when the `exptime` argument is invalid.
    * doc: documented that [ngx.req.get_body_data()](https://github.com/openresty/lua-nginx-module#ngxreqget_body_data) is available in the context of [log_by_lua*](https://github.com/openresty/lua-nginx-module#log_by_lua). thanks YuanSheng Wang for the patch.
    * doc: added [balancer_by_lua*](https://github.com/openresty/lua-nginx-module#balancer_by_lua_block) and [ssl_certificate_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_certificate_by_lua_block) to the context of some Lua API functions. thanks Dejiang Zhu for the patch.
    * doc: fixed the documentation of [log_by_lua*](https://github.com/openresty/lua-nginx-module#log_by_lua) which actually runs after nginx's access log handler.
    * doc: updated the documentation for [ngx.req.discard_body()](https://github.com/openresty/lua-nginx-module#ngxreqdiscard_body) to reflect recent changes. now ignoring request bodies indeed trigger discarding the body upon request finalization.
    * doc: updated the docs of [ngx.get_phase()](https://github.com/openresty/lua-nginx-module#ngxget_phase) for new Lua execution contexts. thanks Thibault Charbonnier for the patches.
    * doc: typo fix in sample configurations from othree.
    * doc: typo fix in sample configurations from Adam Malone.
    * doc: typo fix from Prayag Verma.
    * doc: typo fix from leemingtian.
* upgraded [Lua Resty Core Library](lua-resty-core-library.html) to 0.1.5.
    * optimize: [ngx.ssl](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md): removed unnecessary request checks from the [priv_key_pem_to_der](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#priv_key_pem_to_der) and [cert_pem_to_der](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#cert_pem_to_der) functions to allow them to be used in more contexts. thanks Tom Thorogood for the patch.
    * bugfix: [resty.core.regex](https://github.com/openresty/lua-resty-core#restycoreregex): non-string values passed as string arguments might throw out Lua errors. thanks Robert Paprocki for the patch.
    * change: [resty.core.shdict](https://github.com/openresty/lua-resty-core#restycoreshdict): throws out a Lua error when the exptime arg is invalid.
    * change: [resty.core.regex](https://github.com/openresty/lua-resty-core#restycoreregex): unmatched submatch captures are set to `false` instead of `nil` in captures table. thanks Julien Desgats for the patch.
    * doc: typo fix from thefosk.
    * doc: typo fix from Anton Ovchinnikov.
* upgraded [Lua Upstream Nginx Module](lua-upstream-nginx-module.html) to 0.05.
    * feature: expose peer connection count as the "conns" Lua table field. thanks Justin Li for the patch.
    * feature: this module can now be built as a "dynamic module" with NGINX 1.9.11+ via the `--add-dynamic-module=PATH` option of `./configure`. thanks Hiroaki Nakamura for the original patch.
    * doc: fixes from Justin Li.
* upgraded [Lua Resty Upstream Healthcheck Library](lua-resty-upstream-healthcheck-library.html) to 0.04.
    * feature: added IPv6 address support in upstream peer names. thanks szelcsanyi for the patch.
    * feature: [status_page()](https://github.com/openresty/lua-resty-upstream-healthcheck#status_page): now we mark those upstream blocks without any (live) health checkers so as to avoid potential confusions when the checker light threads were aborted due to some fatal errors.
    * refactor: various coding refactoring to improve code readability. thanks Thijs Schreijer and Dejiang Zhu for the patches.
    * optimize: minor Lua code improvements from Aapo Talvensaari.
    * doc: link fixes from Thijs Schreijer.
    * doc: fixed escaping issues in the configuration samples in the Synopsis section by migrating to the "*_by_lua_block {}" directives. thanks whatacold for the report.
* upgraded [Lua Resty DNS Library](lua-resty-dns-library.html) to 0.15.
    * feature: added reverse DNS utilities: [reverse_query](https://github.com/openresty/lua-resty-dns#reverse_query), [arpa_str](https://github.com/openresty/lua-resty-dns#arpa_str), and [expand_ipv6_addr](https://github.com/openresty/lua-resty-dns#expand_ipv6_addr). thanks bjoe2k4 for the patch.
* upgraded [Resty CLI](resty-cli.html) to 0.06.
    * feature: resty: added new options `--http-include=PATH` and `--main-include=PATH` to include user files in the auto-generated `nginx.conf` file. thanks Nils Nordman for the patch.
* upgraded [Set Misc Nginx Module](set-misc-nginx-module.html) to 0.30.
    * feature: this module can now be compiled as a dynamic module with NGINX 1.9.11+ via the `--with-dynamic-module=PATH` option of `./configure`.
    * bugfix: fixed errors and warnings with C compilers without variadic macro support.
* upgraded [Array Var Nginx Module](array-var-nginx-module.html) to 0.05.
    * feature: this module can now be compiled as a dynamic module with NGINX 1.9.11+ via the `--with-dynamic-module=PATH` option of `./configure`.
    * bugfix: fixed errors and warnings with C compilers without variadic macro support.

#  Version 1.9.7.3 - 28 January 2016
* bugfix: backported the security fixes in NGINX core's DNS resolver for CVE-2016-0742,
CVE-2016-0746, and CVE-2016-0747. See  http://mailman.nginx.org/pipermail/nginx/2016-January/049700.html
for more details.
* change: renamed the source distribution name from `ngx_openresty` to just
`openresty`.

#  Version 1.9.7.2 - 21 January 2016
* feature: applied the [ssl_cert_cb_yield patch](http://mailman.nginx.org/pipermail/nginx-devel/2016-January/007748.html) to the bundled version of the NGINX core to allow yielding in OpenSSL's [SSL_CTX_set_cert_cb()](https://www.openssl.org/docs/manmaster/ssl/SSL_set_cert_cb.html) callbacks (needed by [Lua Nginx Module](lua-nginx-module.html)'s [ssl_certificate_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_certificate_by_lua_block)
directives, for example).
* bugfix: the `./configure` options `--with-dtrace-probes` and `--with-stream` did
not work together and led to compilation failures.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.10.0.
    * feature: better SSL/TLS handshake control.
        * implemented the [ssl_certificate_by_lua_block](https://github.com/openresty/lua-nginx-module#ssl_certificate_by_lua_block) and [ssl_certifcate_by_lua_file](https://github.com/openresty/lua-nginx-module#ssl_certificate_by_lua_file) directives for controlling the NGINX downstream SSL handshake dynamically with Lua. thanks Piotr Sikora, Zi Lin, yejingx, and others for the help.
        * added an optional `send_status_req` argument to stream-typed cosockets' [sslhandshake()](https://github.com/openresty/lua-nginx-module#tcpsocksslhandshake) method to send OCSP status request.
    * feature: implemented the [balancer_by_lua_block](https://github.com/openresty/lua-nginx-module#balancer_by_lua_block) and [balancer_by_lua_file](https://github.com/openresty/lua-nginx-module#balancer_by_lua_file) directives to allow NGINX load balancers written in Lua. thanks Shuxin Yang, Dejiang Zhu, Brandon Beveridge, and others for the help.
    * feature: added pure C API for the ngx.semaphore Lua module implemented in [lua-resty-core](https://github.com/openresty/lua-resty-core#readme). this [ngx.semaphore](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/semaphore.md) API provides efficient synchronization among "light threads" across request/context boundaries. thanks Weixie Cui and Dejiang Zhu from Kugou Inc. for contributing this feature. also thanks Kugou Inc. for supporting this work.
    * doc: made clear the [ngx.ctx](https://github.com/openresty/lua-nginx-module#ngxctx) scoping issues. thanks Robert Paprocki for asking.
    * doc: typo fix for the contexts of [ngx.worker.id](https://github.com/openresty/lua-nginx-module#ngxworkerid). thanks RocFang for the patch.
* upgraded [Lua Resty Core Library](lua-resty-core-library.html) to 0.1.4.
    * feature: added new Lua modules [ngx.ssl](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#readme) and [ngx.ocsp](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ocsp.md#readme). these two modules provide Lua API mostly useful in the context of [Lua Nginx Module](lua-nginx-module.html)'s [ssl_certificiate_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_certificate_by_lua_block). thanks Piotr Sikora, Zi Lin, yejingx, Aapo Talvensaari, and others for the help.
    * feature: implemented the [ngx.balancer](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/balancer.md#readme) Lua module to support dynamic nginx upstream balancers written in Lua. the [ngx.balancer](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/balancer.md#readme) module is expected to be used in [Lua Nginx Module](lua-nginx-module.html)'s [balancer_by_lua*](https://github.com/openresty/lua-nginx-module#balancer_by_lua_block) context. thanks Shuxin Yang, Aapo Talvensaari, and Guanlan Dai for the help.
    * feature: feature: added new Lua module, [ngx.semaphore](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/semaphore.md#readme). this [ngx.semaphore](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/semaphore.md#readme) API provides efficient synchronization among "light threads" across request/context boundaries. thanks Weixie Cui and Dejiang Zhu from Kugou Inc. for contributing this feature. Also thanks Kugou Inc. for supporting this work.
* upgraded [LuaJIT](luajit.html) to v2.1-20160108: https://github.com/openresty/luajit2/tags
    * imported Mike Pall's latest changes:
        * FFI: properly unsink non-standard cdata allocations.
        * ARM: added external frame unwinding. thanks to Nick Zavaritsky.
        * MIPS soft-float support. contributed by Djordje Kovacevic and Stefan Pejic from RT-RK.com. sponsored by Cisco Systems, Inc.
            * added soft-float support to interpreter.
            * added soft-float FFI support.

#  Version 1.9.7.1 - 25 December 2015
* upgraded the [Nginx](nginx.html) core to 1.9.7.
    * see the changes here: http://nginx.org/en/CHANGES
* `./configure`: now we automatically set the environment `MACOSX_DEPLOYMENT_TARGET` to
the current Mac OS X version (unless the environment is already set) to ensure
the [LuaJIT](luajit.html) build uses the current versions of the system libraries.
thanks bsyk for the report.
* win32: use Windows line breaks in the `resty` script file of the binary distribution.
* win32: upgraded pcre to 8.38 and openssl to 1.0.2e.
* win32: enabled ngx_http_realip_module, ngx_http_addition_module ngx_http_sub_module, and ngx_http_stub_status_module
in the win32 binary package by default.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.9.20.
    * feature: added new API functions [ngx.worker.count()](https://github.com/openresty/lua-nginx-module#ngxworkercount) and [ngx.worker.id()](https://github.com/openresty/lua-nginx-module#ngxworkerid) for returning the total count of nginx worker processes and the ordinal number (0, 1, 2, and etc) of the current worker. thanks YuanSheng Wang for the patch. also added pure C API for them.
    * feature: added new API functions [ngx.timer.pending_count()](https://github.com/openresty/lua-nginx-module#ngxtimerpending_count) and [ngx.timer.running_count()](https://github.com/openresty/lua-nginx-module#ngxtimerrunning_count). thanks Simon Eskildsen for the patch.
    * feature: added new config directive [access_by_lua_no_postpone](https://github.com/openresty/lua-nginx-module#access_by_lua_no_postpone). thanks Delta Yeh for the patch.
    * feature: added new constant `ngx.HTTP_TEMPORARY_REDIRECT` (307) and support for 307 in [ngx.redirect()](https://github.com/openresty/lua-nginx-module#ngxredirect). thanks RocFang for the patch.
    * feature: added new API function [ngx.req.is_internal()](https://github.com/openresty/lua-nginx-module#ngxreqis_internal) for testing if the current request is an internal request. thanks Ruoshan Huang for the patch.
    * feature: added many more HTTP status constants as `ngx.HTTP_XXX`. thanks Vadim A. Misbakh-Soloviov for the patch.
    * bugfix: bogus `nginx.conf` parse failure "Lua code block missing the "}" character" might happen when there are many Lua code blocks inlined. thanks Andreas Lubbe for the report.
    * bugfix: bogus "subrequests cycle" errors might occur with nginx 1.9.5+ due to the recent changes in the nginx core.
    * bugfix: [ngx.req.get_uri_args](https://github.com/openresty/lua-nginx-module#ngxreqget_uri_args)/[ngx.req.get_post_args](https://github.com/openresty/lua-nginx-module#ngxreqget_post_args): avoided allocating a zero-size buffer in the nginx memory pool since it might cause problems. thanks Chuanwen Chen for the report and patch.
    * bugfix: modifying the built-in header `X-Forwarded-For` via [ngx.req.set_header()](https://github.com/openresty/lua-nginx-module#ngxreqset_header) or [ngx.req.clear_header()](https://github.com/openresty/lua-nginx-module#ngxreqclear_header) might not take effect in some parts of the nginx core (like `$proxy_add_x_forwarded_for`). thanks aviramc for the patch.
    * bugfix: we lacked detailed context info in error messages due to use of disabled Lua API in [body_filter_by_lua*](https://github.com/openresty/lua-nginx-module#body_filter_by_lua). thanks Dejiang Zhu for the patch.
    * bugfix: fixed a potential data alignment issue in the [ngx.var](https://github.com/openresty/lua-nginx-module#ngxvarvariable) setter API.
    * bugfix: we had data alignment issues in the [subrequest API](https://github.com/openresty/lua-nginx-module#ngxlocationcapture) which can explode on systems like ARM. thanks Stefan Parvu for providing the test environment.
    * bugfix: there was a data alignment issue in the [tcpsock:setkeepalive()](https://github.com/openresty/lua-nginx-module#tcpsocksetkeepalive) implementation which might lead to crashes on ARM systems. thanks Stefan Parvu for the report.
    * bugfix: fixed C compiler warnings "comparison between signed and unsigned integer expressions" on Windows.
    * optimize: avoided allocating in the nginx request memory pool in stream-typed cosockets' [receive*()](https://github.com/openresty/lua-nginx-module#tcpsockreceive) methods. thanks Lourival Vieira Neto for the patch.
    * optimize: reduced memory allocations in stream-typed cosockets. thanks Dejiang Zhu for the patch.
        * avoided allocating the host name buffer when getting peers from the connection pool.
        * recycled the stream cosockets' request cleanup records.
    * doc: documented the minimum size threshold in [lua_shared_dict](https://github.com/openresty/lua-nginx-module#lua_shared_dict). thanks mlr3000 for the original patch.
* upgraded [Lua Resty Core Library](lua-resty-core-library.html) to 0.1.3.
    * Makefile: added support for relative paths in `LUA_LIB_DIR`.
    * minor code adjustments from Aapo Talvensaari.
* upgraded [Headers More Nginx Module](headers-more-nginx-module.html) to 0.29.
    * bugfix: changing the built-in header `X-Forwarded-For` via [more_set_input_headers](https://github.com/openresty/headers-more-nginx-module#more_set_input_headers) or [more_clear_input_headers](https://github.com/openresty/headers-more-nginx-module#more_clear_input_headers) might not take effect in some parts of the nginx core (like `$proxy_add_x_forwarded_for`).
* upgraded [Lua Resty Redis Library](lua-resty-redis-library.html) to 0.22.
    * tweaked Makefile to allow relative paths in `LUA_LIB_DIR` when `DESTDIR` is not specified.
    * optimize: moved string concatenation for the Redis request construction onto the C land (taking advantage of the feature that cosockets' [send](https://github.com/openresty/lua-nginx-module#tcpsocksend) method accepts a table of strings). thanks Dejiang Zhu for the patch.
    * optimize: minor optimizations from Aapo Talvensaari.
* upgraded [Resty CLI](resty-cli.html) to 0.05.
    * bugfix: resty: nginx might report the error "The system cannot find the file specified" in `CreateFile()` on Windows XP. thanks cover_eye for the report.
* upgraded [LuaJIT](luajit.html) to v2.1-20151219: https://github.com/openresty/luajit2/tags
    * Makefile: ensure we always install the symbolic link for the "luajit" file.
    * imported Mike Pall's latest changes:
        * FFI: Fix SPLIT pass for CONV i64.u64.
        * x64/LJ_GC64: Fix stack growth in vararg function setup.
        * DynASM/x86: Add rdpmc instruction.
        * OSX: Switch to Clang as the default compiler.
        * iOS: Disable os.execute() when building for iOS >= 8.0.
        * x86/x64: Disassemble AVX/AVX2 instructions.
        * DynASM/x86: Add AVX and AVX2 opcodes.
        * DynASM/x86: Add AES-NI opcodes.
        * DynASM/x86: Restrict shld/shrd to operands with same width.
        * DynASM/x86: Fix some SSE instruction templates.
        * Fix pairs() recording.
        * FFI: Fix ipairs() recording.
        * Drop marks from replayed instructions when sinking.
See [ChangeLog 1.9.3](changelog-1009003.html) for change log for [OpenResty](openresty.html) 1.9.3.x.
