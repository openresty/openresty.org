<!---
    @title         ChangeLog for 1.31.0.x
    @creator       Junlong Li
    @created       2026-05-13 14:33 GMT
--->

# 版本 1.31.0.1 - 2026年5月13日

* Nginx 核心
    * 从 nginx 1.29.2 升级至 1.31.0。

* OpenSSL
    * 从 3.5.5 版本升级至 3.5.6 版本。

* 升级 [lua-nginx-module](https://github.com/openresty/lua-nginx-module) 至 v0.10.31
    * 新功能：新增 FFI 函数 `ngx_http_lua_ffi_socket_tcp_get_ssl_pointer()` 和 `ngx_http_lua_ffi_socket_tcp_get_ssl_ctx()`。_感谢 lijunlong 提供补丁。_
    * 新功能：新增 API `tcpsock:getsslsession`。_感谢 lijunlong 提供补丁。_
    * 新功能：新增 `ngx_http_lua_ffi_get_upstream_ssl_pointer`。_感谢 lijunlong 提供补丁。_
    * 新功能：新增 `precontent_by_lua` 指令。_感谢 Hanada 提供补丁。_
    * 新功能：新增获取服务器随机数和主密钥的 API。_感谢 xiangwei 提供补丁。_
    * 新功能：为 TCP 套接字新增 `keepintvl` 和 `keepcnt` 选项。_感谢 lijunlong 提供补丁。_
    * 新功能：新增 `proxy_ssl_verify_by_lua*` 指令。_感谢 willmafh 提供补丁。_
    * 新功能：支持 cosocket TLS 握手时使用自定义的可信 CA 存储。(#2495) _感谢 Walker Zhao 提供补丁。_
    * 缺陷修复：在 `nginx -T` 中新增配置转储支持。_感谢 Y.Horie 提供补丁。_
    * 缺陷修复：在 `ngx_http_lua_pipe_proc_wait_cleanup` 中清除等待定时器，以防止 QUIC 连接关闭时的 SIGSEGV 错误。_感谢 Jun Ouyang 提供补丁。_
    * 缺陷修复：修复 freenginx 的兼容性问题。_感谢 Y.Horie 提供补丁。_
    * 缺陷修复：修复 config 中的拼写错误。_感谢 xuruidong 提供补丁。_
    * 缺陷修复：通过确保设置 `old_cycle` 来防止 SSL 缓存中的空指针解引用。_感谢 Jun Ouyang 提供补丁。_
    * 缺陷修复：防止 worker 关闭期间事件定时器红黑树中的 SIGSEGV 错误。_感谢 Gabriel Clima 提供补丁。_
    * 缺陷修复：在 QUIC 连接关闭路径中，确保连接在连接池销毁之前关闭，以防止 `ngx_http_lua_pipe` 中的 use-after-free 崩溃。_感谢 Jun Ouyang 提供补丁。_
    * 缺陷修复：在删除协程引用之前进行检查，以防止 uthread 崩溃。_感谢 Jun Ouyang 提供补丁。_
    * 变更：允许 `ngx.header['WWW-Authenticate']` 使用 table 设置多个值。_感谢 BotoX 提供补丁。_
    * 优化：新增对 freenginx 的兼容性支持。_感谢 Sergey A. Osokin 提供补丁。_
    * 优化：在 cosocket 的错误日志中添加上游服务器信息。_感谢 lijunlong 提供补丁。_
    * 测试：修复 BoringSSL 环境下的不稳定测试。_感谢 Jun Ouyang 提供补丁。_
    * 测试：在 CI 中新增 dnsmasq 以避免不稳定测试。_感谢 Y.Horie 提供补丁。_
    * 文档：修复 `ngx.escape_uri` 中未编码字符的问题。_感谢 Y.Horie 提供补丁。_
    * 文档：修复拼写错误。_感谢 leslie 提供补丁。_
    * 文档：修复拼写错误并删除不正确的陈述。_感谢 willmafh 提供补丁。_
    * 文档：更新版权声明。_感谢 lijunlong 提供补丁。_
    * 文档：更新 `ngx.req.http_version` 与 `ngx.req.raw_header` 的上下文说明，以包含 `log_by_lua`。_感谢 kurt 提供补丁。_

* 升级 [stream-lua-nginx-module](https://github.com/openresty/stream-lua-nginx-module) 至 v0.0.19
    * 新功能：新增 FFI API `ngx_stream_lua_ffi_socket_tcp_getfd`。_感谢 lijunlong 提供补丁。_
    * 新功能：新增 FFI 函数 `ngx_stream_lua_ffi_socket_tcp_get_ssl_pointer()` 和 `ngx_stream_lua_ffi_socket_tcp_get_ssl_ctx()`。_感谢 lijunlong 提供补丁。_
    * 新功能：新增 API `tcpsock:get_ssl_session`。_感谢 lijunlong 提供补丁。_
    * 新功能：新增 `ngx_stream_lua_ffi_get_upstream_ssl_pointer`。_感谢 lijunlong 提供补丁。_
    * 新功能：为 UDP cosocket 绑定本地端口新增 reuseport 支持。_感谢 lijunlong 提供补丁。_
    * 新功能：为 TCP 套接字新增 `keepintvl` 和 `keepcnt` 选项。_感谢 lijunlong 提供补丁。_
    * 新功能：在下游套接字上实现 `serversslhandshake` 方法 (#392)。_感谢 Rob Mueller 提供补丁。_
    * 新功能：新增 `proxy_ssl_certificate_by_lua` 指令。_感谢 willmafh 提供补丁。_
    * 新功能：支持 cosocket TLS 握手时使用自定义的可信 CA 存储。(#401) _感谢 Walker Zhao 提供补丁。_
    * 优化：新增对 freenginx 的兼容性支持。_感谢 Sergey A. Osokin 提供补丁。_
    * 优化：在 cosocket 的错误日志中添加上游服务器信息。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：修复当 nginx 关闭定时器触发时未关闭 cosocket 的问题。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：在删除协程引用之前进行检查，以防止 uthread 崩溃。_感谢 Jun Ouyang 提供补丁。_
    * 缺陷修复：消除 clang 警告。_感谢 lijunlong 提供补丁。_

* 升级 [lua-resty-core](https://github.com/openresty/lua-resty-core) 至 v0.1.34rc2
    * 新功能：新增获取服务器随机数和主密钥的 Lua API。_感谢 mengxiangwei 提供补丁。_
    * 新功能：新增 API `tcpsock:getsslsession`。_感谢 lijunlong 提供补丁。_
    * 新功能：新增 `precontent_by_lua` 指令。_感谢 Hanada 提供补丁。_
    * 新功能：为 TCP 套接字新增 `keepintvl` 和 `keepcnt` 选项。_感谢 lijunlong 提供补丁。_
    * 新功能：新增 `sock:getsslpointer()` 和 `sock:getsslctx()`。_感谢 lijunlong 提供补丁。_
    * 新功能：新增 `ssl.get_upstream_ssl_pointer`。_感谢 lijunlong 提供补丁。_
    * 新功能：为 stream 子系统新增 `tcpsock.getfd()`。_感谢 lijunlong 提供补丁。_
    * 新功能：新增 `tcpsock:settrustedstore()`，支持为每次握手设置可信 CA。_感谢 Walker Zhao 提供补丁。_
    * 新功能：新增 `proxy_ssl_certificate_by_lua` 指令。_感谢 willmafh 提供补丁。_
    * 新功能：为 stream 子系统支持 `tcpsock:settrustedstore()`。_感谢 Walker Zhao 提供补丁。_
    * 新功能：更新 ngx-lua 和 stream-ngx-lua 的版本。_感谢 lijunlong 提供补丁。_
    * 优化：加载错误的 lua-nginx-module 时提供更详细的错误信息。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：修复无 SSL 构建时无法加载 socket.lua 的问题。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：修复拼写错误。_感谢 lijunlong 提供补丁。_
    * 文档：更新版权声明。_感谢 lijunlong 提供补丁。_
    * 代码风格：修复拼写错误。_感谢 Chrono 提供补丁。_

* 升级 [luajit2](https://github.com/openresty/luajit2) 至 v2.1-20260415
    * 新增 `ffi.abi("dualnum")`。_感谢 Mike Pall 提供补丁。_
    * 允许在跳转范围之外分配 mcode 以支持代码。_感谢 Mike Pall 提供补丁。_
    * ARM64：如果工具链指示，启用非对齐访问。_感谢 Mike Pall 提供补丁。_
    * ARM64：修复大于 2GB 分支目标的反汇编。_感谢 Mike Pall 提供补丁。_
    * ARM64：修复某些子字长加载/存储的反汇编。_感谢 Mike Pall 提供补丁。_
    * ARM64：更多 ARM BTI 修复。_感谢 Mike Pall 提供补丁。_
    * 避免记录由于 VM 钩子调用导致的干扰。_感谢 Mike Pall 提供补丁。_
    * 避免对内部注册表键使用次正规数。_感谢 Mike Pall 提供补丁。_
    * 回退 MSVC LJ_CONSTF 声明。_感谢 Mike Pall 提供补丁。_
    * bcsave.lua：新增 ppc64 和 ppc64le 映射。_感谢 Piotr Kubaj 提供补丁。_
    * 缺陷修复：修复使用 `LUA_USE_TRACE_LOGS` 定义时的构建失败问题。_感谢 lijunlong 提供补丁。_
    * DUALNUM：为 FORI 槽添加缺失的类型转换。_感谢 Mike Pall 提供补丁。_
    * DUALNUM：修复一元减法的窄化问题。_感谢 Mike Pall 提供补丁。_
    * DUALNUM：修复因之前变更导致的循环记录问题。_感谢 Mike Pall 提供补丁。_
    * DUALNUM：改进/修复一元减法的边缘情况。_感谢 Mike Pall 提供补丁。_
    * ELF/Mach-O：强制公共 API 函数的默认可见性。_感谢 Mike Pall 提供补丁。_
    * FFI：避免悬空的 `cts->L`。_感谢 Mike Pall 提供补丁。_
    * FFI：修复 JIT 编译器中的构造函数索引解析。_感谢 Mike Pall 提供补丁。_
    * FFI：修复 64 位平台上的指针差值运算。_感谢 Mike Pall 提供补丁。_
    * FFI：缩小压缩位域的容器。_感谢 Mike Pall 提供补丁。_
    * 修复编译器警告。_感谢 Mike Pall 提供补丁。_
    * 修复为 `string.byte/sub/find` 生成 IR 时的边缘情况。_感谢 Mike Pall 提供补丁。_
    * 修复记录 `string.byte/sub` 时的边缘情况。_感谢 Mike Pall 提供补丁。_
    * 修复栈调整时的 `G->jit_base` 重定位。_感谢 Mike Pall 提供补丁。_
    * 修复 minilua 中 `bit.tohex` 的未定义行为。_感谢 Mike Pall 提供补丁。_
    * 修复 MSVC LJ_CONSTF 声明。_感谢 Mike Pall 提供补丁。_
    * 修复有限精度浮点数转换的 `string.format`。_感谢 Mike Pall 提供补丁。_
    * 修复终结器中 VM 事件的错误处理。_感谢 Mike Pall 提供补丁。_
    * 忽略 PDB 文件的 git 跟踪。_感谢 Mike Pall 提供补丁。_
    * 实现 s390x 的双精度到整数转换 (#256)。_感谢 Ilya Leoshkevich 提供补丁。_
    * macOS：更改 Mach-O 目标文件布局以满足 XCode 15.0 要求。_感谢 Mike Pall 提供补丁。_
    * MIPS64：避免 `lj_vm_exit_interp` 中的非对齐加载。_感谢 Mike Pall 提供补丁。_
    * PPC：修复软浮点 `lj_num2u64()`。_感谢 Mike Pall 提供补丁。_
    * 防止 `unpack()` 中的误报 sanitizer 警告。_感谢 Mike Pall 提供补丁。_
    * 防止记录带有 -0 步长或 NaN 值的循环。_感谢 Mike Pall 提供补丁。_
    * 防止在记录函数头时清除快照。_感谢 Mike Pall 提供补丁。_
    * 移除 FP 转换的编译器标志（现已不必要）。_感谢 Mike Pall 提供补丁。_
    * 移除无意义的 GCC/MSVC const 函数属性。_感谢 Mike Pall 提供补丁。_
    * 在单独的状态中运行 VM 事件和终结器。_感谢 Mike Pall 提供补丁。_
    * s390x：简化 ceil/floor 代码 (#246)。_感谢 J. Neuschäfer 提供补丁。_
    * 统一 Lua 数字到 FFI 整数的转换。_感谢 Mike Pall 提供补丁。_
    * x64/!LJ_GC64：无 JIT 构建也需要分配限制。_感谢 Mike Pall 提供补丁。_
    * x86/x64：反向移植 `math.min()`/`math.max()` 参数检查的修复。_感谢 Mike Pall 提供补丁。_

* 升级 [ngx_postgres](https://github.com/openresty/ngx_postgres) 至 v1.1
    * 缺陷修复：在被其他模块包装时恢复 postgres 的 peer 数据。_感谢 lijunlong 提供补丁。_

* [lua-rds-parser](https://github.com/openresty/lua-rds-parser)：
    * 新增 .gitattributes 文件以修正 GitHub 的语言标识。_感谢 章亦春 (agentzh) 提供补丁。_
    * 新功能：新增 travis-ci 支持。_感谢 Ilya Shipitsin 提供补丁。_
    * 美化 README。_感谢 章亦春 (agentzh) 提供补丁。_

* 升级 [xss-nginx-module](https://github.com/openresty/xss-nginx-module) 至 v0.07
    * 缺陷修复：修复 #22 模块重复加载的问题。_感谢 lijunlong 提供补丁。_
    * 新功能：新增动态模块构建支持。_感谢 Su Yang 提供补丁。_

* 升级 [lua-resty-mysql](https://github.com/openresty/lua-resty-mysql) 至 v0.30
    * 新功能：新增对 ed25519 的支持。_感谢 lijunlong 提供补丁。_

* [form-input-nginx-module](https://github.com/openresty/form-input-nginx-module)：
    * 文档：兼容的 nginx 版本回溯至 1.9.15。_感谢 章亦春 (agentzh) 提供补丁。_

* [lua-resty-lock](https://github.com/openresty/lua-resty-lock)：
    * 文档：更正 README.markdown 中关于包状态的错误描述。_感谢 jumper047 提供补丁。_

* 升级 [echo-nginx-module](https://github.com/openresty/echo-nginx-module) 至 v0.64
    * 文档：更新 README.md 中的发布日期和版本号。_感谢 lijunlong 提供补丁。_
    * 优化：新增对 freenginx 的兼容性支持。_感谢 lijunlong 提供补丁。_

* [redis2-nginx-module](https://github.com/openresty/redis2-nginx-module)：
    * 文档：更新 nginx 兼容性列表。_感谢 章亦春 (agentzh) 提供补丁。_
    * 文档：更新 README.markdown。_感谢 Steve 提供补丁。_
    * travis：克隆 lua-resty-core 和 lua-resty-lrucache 仓库。_感谢 Thibault Charbonnier 提供补丁。_

* [lua-resty-websocket](https://github.com/openresty/lua-resty-websocket)：
    * 文档：修复注释中的拼写错误。_感谢 harry-xm 提供补丁。_

* 升级 [lua-upstream-nginx-module](https://github.com/openresty/lua-upstream-nginx-module) 至 v0.08
    * 缺陷修复：按需获取 rlock 和 wlock。_感谢 Aleksandr Tuliakov 提供补丁。_
    * 开发：确保在 nginx 1.13.6 下测试通过。_感谢 章亦春 (agentzh) 提供补丁。_
    * 文档：`get_upstreams()` 实际上会获取 `proxy_pass` 创建的隐式 upstream，但文档之前称其被排除在外。_感谢 silence2014 提供补丁。_
    * 文档：修复 get_servers 相关文档中的拼写错误。_感谢 chronolaw 提供补丁。_
    * 文档：更新 get_servers 的返回值说明。_感谢 Peter Zhu 提供补丁。_
    * travis：将 nginx 1.13.6 加入测试矩阵。_感谢 章亦春 (agentzh) 提供补丁。_
    * travis：修复构建。_感谢 章亦春 (agentzh) 提供补丁。_

* 升级 [lua-resty-upstream-healthcheck](https://github.com/openresty/lua-resty-upstream-healthcheck) 至 v0.09
    * 优化：在使用 resolve 指令时更新 peers。_感谢 Aleksandr Tuliakov 提供补丁。_

* 升级 [lua-resty-string](https://github.com/openresty/lua-resty-string) 至 v0.17
    * 新功能：新增 AES-256-CTR 绑定并复用缓冲区。_感谢 ^_^ 提供补丁。_

* 升级 [lua-cjson](https://github.com/openresty/lua-cjson) 至 v2.1.0.17
    * 缺陷修复：修复解码超出 `lua_Integer` 范围的数字时被截断的问题 (#116)。_感谢 James McCoy 提供补丁。_
    * 新功能：新增在解码时允许注释的选项。_感谢 skewb1k 提供补丁。_
    * 新功能：新增对编码输出进行缩进的选项。_感谢 skewb1k 提供补丁。_
    * 缺陷修复：消除显式将指针转换为 int 的警告。_感谢 Deyan Dobromirov 提供补丁。_
    * 优化：将 `cjson.decode_allow_comments` 重命名为 `cjson.decode_allow_comment`。_感谢 lijunlong 提供补丁。_

* [lua-resty-shell](https://github.com/openresty/lua-resty-shell)：
    * 文档：补充 `max_size` 参数默认值的说明。_感谢 lijunlong 提供补丁。_
    * README.md：新增关于默认超时时间的说明 (#21)。_感谢 Jeffrey 'jf' Lim 提供补丁。_

* [headers-more-nginx-module](https://github.com/openresty/headers-more-nginx-module)：
    * 文档：在 README 中添加分号以修复语法。_感谢 Baba Boota 提供补丁。_
    * 文档：更新版权声明。_感谢 lijunlong 提供补丁。_
    * 文档：更新最新兼容的 nginx 版本。_感谢 lijunlong 提供补丁。_

* [set-misc-nginx-module](https://github.com/openresty/set-misc-nginx-module)：
    * 文档：修复 README.markdown 中的若干拼写错误。_感谢 willmafh 提供补丁。_

* 升级 [drizzle-nginx-module](https://github.com/openresty/drizzle-nginx-module) 至 v0.1.13
    * 缺陷修复：将 peer 数据存储在模块 ctx 中，以便在上游包装器中得以保留 (#52)。_感谢 lijunlong 提供补丁。_
