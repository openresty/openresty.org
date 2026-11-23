<!---
    @title         ChangeLog for 1.31.9.x
    @description   Change log for the OpenResty 1.31.9.x series, covering Nginx 1.31.9 security fixes, LuaJIT, TLS and shared dictionary APIs, and bundled component updates.
    @creator       Junlong Li
    @created       2026-11-23 13:38 GMT
--->

# Version 1.31.9.1 - 23 November 2026

* Nginx core
    * Upgraded from Nginx 1.31.8 to 1.31.9, incorporating **10 upstream security fixes**.
        * **HTTP/2 and HTTP/3.** Fixed HTTP/2 flow-control memory corruption (CVE-2026-123007)
          and stream creation use-after-free issues in HTTP/2 (CVE-2026-123633) and HTTP/3 (CVE-2026-121810).
        * **Resolver and mail proxy.** Fixed use-after-free issues in DNS response processing
          (CVE-2026-123634) and the mail proxy (CVE-2026-113425).
        * **HTTP routing and request bodies.** Fixed a buffer overflow involving `try_files` and `alias`
          (CVE-2026-125283) and a worker loop when reading a request body over TLS (CVE-2026-118899).
        * **Stream TLS.** Fixed client-certificate verification against the wrong virtual server
          (CVE-2026-120967), a null pointer dereference with PROXY protocol v2 and dynamic certificates
          (CVE-2026-120993), and insufficient validation of ClientHello messages in `ssl_preread`
          (CVE-2026-123640). [Nginx security advisories](https://nginx.org/en/security_advisories.html)
    * Rejects HTTP header lines without a colon and chunked request bodies with excessive framing overhead.
      Upstream fixes also cover HTTP/3 QPACK decoding, proxy requests that could hang while discarding the
      request body, and invalid GeoIP coordinates in MMDB files. [Nginx 1.31.9 changes](https://nginx.org/en/CHANGES)
    * Fixed upstream notification handling so successful responses no longer consume Lua balancer retries.
      [OpenResty #1154](https://github.com/openresty/openresty/issues/1154)

* Upgraded [encrypted-session-nginx-module](https://github.com/openresty/encrypted-session-nginx-module) from v0.10 to v0.11.
    * Encrypts new session tokens with a fresh random IV and authenticates them with HMAC-SHA256.
    * **Upgrade note.** Existing tokens are rejected and users need new sessions. Upgrade all instances
      that exchange tokens before issuing new sessions. [Token format compatibility](https://github.com/openresty/encrypted-session-nginx-module/blob/v0.11/README.md#token-format-compatibility)

* Upgraded [lua-nginx-module](https://github.com/openresty/lua-nginx-module) from v0.10.32rc7 to v0.10.32rc8.
    * Added FFI support for selecting TLS ciphers and TLS 1.3 cipher suites during ClientHello processing
      and for accessing the request's `SSL_CTX`. Invalid cipher settings leave the previous settings intact.
    * Added atomic shared dictionary operations for updating expiration and deleting an entry only when its
      value still matches.
    * Added per-pool limits for idle balancer keepalive connections. Fixed upstream scheme selection when
      toggling TLS and a worker crash on invalid local bind addresses.
      _Thanks Jun Ouyang, Weixie Cui, and gresham for the patches._
    * Improved cosocket queue handling. Queued connections resume in constant time, including when multiple
      pool slots become available in one cycle. Pool slots remain reserved across queued connection attempts.
      _Thanks perfgao and AxisNow-Dev for the fixes._
    * Cleaned up pending operations in ordinary Lua coroutines during request cleanup.
    * Fixed `lua_ssl_key_log` with BoringSSL and enabled `ngx.ssl.export_keying_material()` on BoringSSL builds.
      _Thanks 耗子 for the patches._

* Upgraded [stream-lua-nginx-module](https://github.com/openresty/stream-lua-nginx-module) from v0.0.20rc3 to v0.0.20rc4.
    * Added the corresponding TLS and shared dictionary FFI operations, including the ability to clear
      server cipher preference.
    * Fixed cosocket queue and pool-slot handling to resume waiting connections as capacity becomes available.
      _Thanks perfgao and AxisNow-Dev for the fixes._
    * Detached `receiveuntil()` patterns after each read and preserved pending delimiter bytes when switching
      readers. Cleaned up pending operations in ordinary Lua coroutines during session cleanup.

* Upgraded [lua-resty-core](https://github.com/openresty/lua-resty-core) from v0.1.35rc2 to v0.1.35rc3.
    * Added `ngx.ssl.get_req_ssl_ctx()` and the `set_ciphers()` and `set_ciphersuites()` methods in
      `ngx.ssl.clienthello`. The cipher setters work in `ssl_client_hello_by_lua*` with OpenSSL 1.1.1 or later.
    * Exposed atomic compare-and-update and compare-and-delete operations through `ngx.shared.DICT:compare_expire()`.
    * Added the optional `pool_size` argument to `ngx.balancer.enable_keepalive()`.
      _Thanks Jun Ouyang for the patch._

* Upgraded [lua-resty-lock](https://github.com/openresty/lua-resty-lock) from v0.09 to v0.10.
    * Prevents an expired lock owner from releasing or extending a lock acquired by another caller. The check
      covers explicit release, expiration changes, and garbage collection.
    * Uses the matching `lua-resty-core` and HTTP or stream Lua module for atomic ownership checks.

* Upgraded [luajit2](https://github.com/openresty/luajit2) from v2.1-20261023 to v2.1-20261117.
    * Fixed FFI array initializer bounds checks, failed bit-operation conversion errors, and sign extension
      when negative integers are cast to 64-bit pointers. Avoided unnecessary widening in other pointer casts.
    * Fixed JIT recording for `select()` beyond the available varargs and constant folding of `ldexp()` with
      non-integer exponents. Added a nesting limit check for the ternary operator.
    * Fixed x86 and x64 JIT conversion and store code generation and avoided a store-to-load forwarding stall
      after stack restoration on x64 with GC64.
    * Fixed escaping of paths in DynASM line directives and an ARM64 DynASM sanitizer warning.
      _Thanks Mike Pall for the LuaJIT patches._

* Upgraded [lua-resty-openssl](https://github.com/fffonion/lua-resty-openssl) from 1.9.0 to 1.10.0.
    * Updated TLS integration for recent OpenResty releases. The library prefers `lua-resty-core` SSL accessors
      and can use the bundled auxiliary module.
    * Fixed support for SM2 keys. [Upstream change log](https://github.com/fffonion/lua-resty-openssl/blob/1.10.0/CHANGELOG.md#1100---2026-11-17)

* Added [lua-resty-openssl-aux-module](https://github.com/fffonion/lua-resty-openssl-aux-module) 0.3.0.
    * Provides native helpers for TLS operations. OpenResty builds the module by default when
      `lua-resty-openssl` is enabled.

* Upgraded [headers-more-nginx-module](https://github.com/openresty/headers-more-nginx-module) from v0.40 to v0.42.
    * Fixed case-insensitive media type matching and ignored parameters when matching request content types.
    * Fixed charset handling when successive directives replace or clear `Content-Type`.
    * Fixed replace-only mode for absent multi-value request headers such as `Cookie`.

* Upgraded [drizzle-nginx-module](https://github.com/openresty/drizzle-nginx-module) from v0.1.14 to v0.1.15.
    * Pauses database reads while output to the client is backed up and resumes with the remaining receive
      timeout. Reuses streaming buffers while preserving RDS framing.
    * Retries failed connections only before SQL is submitted, preventing replay of queries that may have run.
    * Removed password logging and fixed keepalive configuration validation and IPv6 address handling.

* Upgraded [echo-nginx-module](https://github.com/openresty/echo-nginx-module) from v0.65 to v0.66.
    * Rejects overflowing counts and output sizes in `echo_duplicate` and empty delimiters in `echo_foreach_split`.
    * Fixed request cleanup ordering so a failed allocation cannot leave an armed sleep timer behind.

* Upgraded [array-var-nginx-module](https://github.com/openresty/array-var-nginx-module) from v0.06 to v0.07.
    * Validates array references before map or join operations and rejects overflowing initial capacities.
      Valid array references continue to work across internal redirects and subrequests.

* Upgraded [ngx_postgres](https://github.com/openresty/ngx_postgres) from 1.1 to v1.2.
    * Fixed support for complex configuration values on Nginx 1.31.3 and later. _Thanks Appla for the patch._

* Windows builds
    * Updated the zlib download to use the upstream archive over HTTPS.
    * The Windows CI jobs now upload the built `nginx.exe` and `lua51.dll` when present.
      _Thanks Adam Delarosa and sunaer for the patches._
