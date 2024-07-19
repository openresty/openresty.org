<!---
    @title         ChangeLog for 1.19.9.x
    @creator       Johnny Wang
    @created       2021-08-06 06:49 GMT
--->

# Version 1.19.9.2 - 19 Jul 2024

* upgraded [LuaJIT](https://github.com/openresty/luajit2) to 2.1-20210510.1.
    * bugfix: disable hash computation optimization because of the possibility of severe degradation (CVE-2024-39702). _Thanks lijunlong for the patch._

# Version 1.19.9.1 - 6 Aug 2021

- upgraded the nginx core to 1.19.9.
    - see the changes here: https://nginx.org/en/CHANGES

* upgraded [ngx_lua](https://github.com/openresty/lua-nginx-module) to 0.10.20.
    * bugfix: changed from graceful shutdown to abort when `lua_resume` return `LUA_ERRMEM`. _Thanks lijunlong for the patch._
    * bugfix: correct the way to handle invalid quote in `ngx.escape_uri`/`ngx.req.get_{uri,post}_args`. _Thanks Suika for the patch._
    * bugfix: fix possible null pointer dereference found by Coverity. _Thanks Ilya Shipitsin for the patch._
    * bugfix: fixed memory leak in debug log. _Thanks Hawker for the patch._
    * bugfix: we closed listener's fd which was closed. _Thanks spacewander for the patch._

* upgraded [ngx_stream_lua](https://github.com/openresty/stream-lua-nginx-module) to 0.0.10.
    * bugfix: changed from graceful shutdown to abort when `lua_resume` return `LUA_ERRMEM`. _Thanks lijunlong for the patch._
    * bugfix: wrong source address for the replying packet when received udp packet via req.socket on secondary address. _Thanks lijunlong for the patch._
    * bugfix: fix possible null pointer dereference found by Coverity. _Thanks Ilya Shipitsin for the patch._
    * bugfix: fixed memory leak in debug log. _Thanks Hawker for the patch._
    * bugfix: ignore the `raw` argument when acquiring UDP request socket. _Thanks Datong Sun for the patch._

* upgraded [lua-resty-core](https://github.com/openresty/lua-resty-core) to v0.1.22.
    * feature: expose the `get_ctx_table` API to get the ctx table, and support using ctx table from caller when the ctx table does not exists. _Thanks doujiang24 for the patch._
    * feature: implemented ngx.process API for stream subsystem. _Thanks WANG HUI for the patch._
    * bugfix: should compare to nil to check if a cdata is NULL. _Thanks lijunlong for the patch._
    * change: it is harmful to set ngx.ctx to a non-table value. _Thanks spacewander for the patch._

* upgraded [lua-tablepool](https://github.com/openresty/lua-tablepool) to v0.02
    * bugfix: should also clear the metatable when clearing key values of a table. _Thanks doujiang24 for the patch._
    * change: discard the object simply when the pool size is large than `max_pool_size`, so that we can get better performance. _Thanks doujiang24 for the patch._

* upgraded [lua-resty-memcached](https://github.com/openresty/lua-resty-memcached) to v0.16.
    * change: use preferred settimeouts instead of settimout. _Thanks Elvin Efendi for the patch._

* upgraded [lua-resty-dns](https://github.com/openresty/lua-resty-dns) to v0.22.
    * feature: add `no_random` option. _Thanks Thijs Schreijer for the patch._

* upgraded [lua-resty-mysql](https://github.com/openresty/lua-resty-mysql) to v0.24.
    * bugfix: 64-bit integer values in the MySQL packets (like last `insert_id`) could not be properly parsed due to LuaJIT's BitOp functions return results in the range of signed 32 bit numbers. _Thanks doujiang24 for the patch._

* upgraded [opm](https://github.com/openresty/opm) to v0.0.6.
    * bugfix: update the RegExp to suit the new GitHub access tokens format. _Thanks pintsized for the patch._
    * feature: web: support displaying and searching package docs. _Thanks xlibor for the patch._
    * change: print usage if no command specified. _Thanks tison for the patch._
    * feature: web: improvements for the website UI. _Thanks xlibor for the patch._

* upgraded [resty-cli](https://github.com/openresty/resty-cli) to v0.28.
    * bugfix: share dict name can be upper letter & numbers. _Thanks Zhenzhen Zhao for the patch._
    * bugfix: resty: win32: we should search for `*.ljbc` files first too.

* upgraded [lua-resty-lrucache](https://github.com/openresty/lua-resty-lrucache) to v0.11.
    * bugfix: set `num_items` to zero when `flushall`. _Thanks hnlq715 for the patch._

* upgraded [lua-resty-string](https://github.com/openresty/lua-resty-string) to v0.14.
    * change: added parameter check for `aes.lua`. _Thanks lijunlong for the patch._
    * feature: added aes gcm encryption/decryption algorithm. _Thanks lijunlong for the patch._
    * bugfix: segmentation fault while decoding because the wrong output size buffer.  _Thanks Miroslav Nový for the patch._

* upgraded [lua-resty-signal](https://github.com/openresty/lua-resty-signal) 0.03.
    * change: the signum method return correct value on different system now, not only for linux. _Thanks xiaobiaozhao for the patch._

* upgraded [LuaJIT](https://github.com/openresty/luajit2) to 2.1-20210510.
    * change: Introduce a new macro `LUAJIT_TEST_FIXED_ORDER` for testing so that lua table would have predictable key iteration order.
    * bugfix: Fix trace exit register dump for some archs.
    * bugfix: FFI: Fix recording of union initialization.
    * bugfix: x64: Fix `__call` metamethod return dispatch.
    * bugfix: Fix binary number literal parsing.
    * feature: enable debuginfo in our luajit build by default.
