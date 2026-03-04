<!---
    @title         ChangeLog for 1.29.2.x
    @creator       Junlong Li
    @created       2026-02-28 14:33 GMT
--->

* Nginx 核心
    * 从 nginx 1.27.1 升级至 1.29.2。

* OpenSSL
    * 从版本 3.4.1 升级至 3.5.5。

* PCRE
    * 从版本 10.44 升级至 10.47。

* [lua-nginx-module](https://github.com/openresty/lua-nginx-module) v0.10.29
    * 新功能：新增 ngx_http_lua_ffi_ssl_get_client_hello_ext_present()。_感谢 Gabriel Clima 提供补丁。_
    * 新功能：新增用于绕过 HTTP 条件请求检查的函数 (#2401)。_感谢 kurt 提供补丁。_
    * 新功能：新增 lua_ssl_key_log 指令。_感谢 willmafh 提供补丁。_
    * 新功能：新增 ngx_http_lua_ffi_req_shared_ssl_ciphers()。_感谢 Sunny Chan 提供补丁。_
    * 新功能：新增 sock:getfd()。_感谢 lijunlong 提供补丁。_
    * 新功能：导出三个用于操作 ngx_http_lua_co_ctx_t 结构的函数。_感谢 lijunlong 提供补丁。_
    * 新功能：ngx_http_lua_ffi_ssl_get_client_hello_ciphers()。_感谢 Gabriel Clima 提供补丁。_
    * 新功能：新增 proxy_ssl_verify_by_lua 指令。_感谢 willmafh 提供补丁。_
    * 新功能：支持 TCP 绑定 IPv4/IPv6 的 ip 或 ip:port。_感谢 ElvaLiu 提供补丁。_
    * 缺陷修复：为 HTTP/3 QUIC SSL Lua 协程让出补丁新增宏保护。_感谢 swananan 提供补丁。_
    * 缺陷修复：修复了 Lua 阶段（access/rewrite/server_rewrite）处理完成后未刷新发送缓冲区的问题。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：修复了主机名长度超过 32 时未正确使用对应主机名的问题。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：确保在 fd 可写事件触发时上下文可正确恢复。_感谢 Zeping Bai 提供补丁。_
    * 缺陷修复：改进 HTTP/3 SSL Lua 回调中协程让出的处理逻辑。_感谢 swananan 提供补丁。_
    * 缺陷修复：修复了使用 OpenSSL 外部 QUIC API 编译的版本中 QUIC 握手无法正常恢复的问题。_感谢 swananan 提供补丁。_
    * 缺陷修复：补充了提交 e8f65dc53 中遗漏的变更。_感谢 lijunlong 提供补丁。_
    * 优化：移除了不必要的错误检查。_感谢 willmafh 提供补丁。_
    * 变更：为 ngx_http_lua_ffi_get_req_ssl_pointer() 新增 err 参数。_感谢 lijunlong 提供补丁。_
    * 代码风格：统一代码风格。_感谢 willmafh 提供补丁。_

* [stream-lua-nginx-module](https://github.com/openresty/stream-lua-nginx-module) v0.0.17
    * 新功能：新增 lua_ssl_key_log 指令，可在 tcpsock:sslhandshake 方法中记录客户端连接的 SSL 密钥，密钥采用与 Wireshark 兼容的 SSLKEYLOGFILE 格式输出。_感谢 willmafh 提供补丁。_
    * 新功能：为 Stream 子系统新增 ngx_stream_lua_ffi_get_req_ssl_pointer()。_感谢 lijunlong 提供补丁。_
    * 新功能：新增 ngx_stream_lua_ffi_req_dst_addr()。_感谢 lijunlong 提供补丁。_
    * 新功能：新增对 TCP/UDP 绑定的支持。_感谢 alonbg 提供补丁。_
    * 新功能：ngx_stream_lua_ffi_req_shared_ssl_ciphers()。_感谢 Ri Shen Chen 提供补丁。_
    * 新功能：新增 proxy_ssl_verify_by_lua 指令。_感谢 willmafh 提供补丁。_
    * 缺陷修复：修复了在 OpenSSL 1.x.x 及 BoringSSL 环境下编译失败的问题。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：修复了在 OpenSSL < 3.0.2 环境下编译失败的问题。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：修复了代码中的拼写错误。_感谢 willmafh 提供补丁。_
    * 缺陷修复：修复了编译警告。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：消除了 BoringSSL 构建版本中未使用函数的编译警告。_感谢 swananan 提供补丁。_
    * 优化：为 SSL_set_tlsext_status_type() 添加错误检查。_感谢 Fahnenfluchtige 提供补丁。_
    * 优化：在使用变量 r 之前先进行有效性检查。_感谢 Fahnenfluchtige 提供补丁。_
    * 优化：消除了构建警告。_感谢 lijunlong 提供补丁。_
    * 代码风格：规范代码风格。_感谢 lijunlong 提供补丁。_
    * 代码风格：规范代码风格。_感谢 willmafh 提供补丁。_

* [lua-resty-core](https://github.com/openresty/lua-resty-core) v0.1.32
    * 新功能：为 Stream 子系统新增地址绑定支持。_感谢 lijunlong 提供补丁。_
    * 新功能：为 ngx.resp 新增 bypass_if_checks 方法 (#495)。_感谢 kurt 提供补丁。_
    * 新功能：为 Stream 子系统新增 get_req_ssl_pointer()。_感谢 lijunlong 提供补丁。_
    * 新功能：新增 ngx.req.get_original_addr。_感谢 lijunlong 提供补丁。_
    * 新功能：新增 sock:getfd()。_感谢 lijunlong 提供补丁。_
    * 新功能：为 Stream 子系统新增 ssl.get_shared_ssl_ciphers。_感谢 Sunny Chan 提供补丁。_
    * 新功能：新增对 ssl.get_req_shared_ssl_ciphers() 的支持。_感谢 Sunny Chan 提供补丁。_
    * 新功能：get_client_hello_ciphers() (#498)。_感谢 Gabriel Clima 提供补丁。_
    * 新功能：新增 proxy_ssl_verify_by_lua 指令。_感谢 willmafh 提供补丁。_
    * 新功能：新增 get_client_hello_ext_present。_感谢 Gabriel Clima 提供补丁。_
    * 优化：移除未使用的代码。_感谢 lijunlong 提供补丁。_
    * 优化：移除未使用的参数。_感谢 Bai Miao 提供补丁。_
    * 缺陷修复：修复了因未设置输入缓冲区长度导致无法获取错误消息的问题。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：修复问题 #499，避免 C 函数立即返回 FFI_OK 时触发非预期断言。_感谢 akf00000 提供补丁。_
    * 文档：为 get_client_hello_ext_present() 补充说明文档。_感谢 lijunlong 提供补丁。_
    * 文档：修复了文档中的拼写错误。_感谢 lijunlong 提供补丁。_
    * 代码风格：规范代码风格。_感谢 lijunlong 提供补丁。_

* [luajit2](https://github.com/openresty/luajit2) v2.1-20251022
    * 为 fp:seek() 的参数新增字符串类型兼容性自动转换。_感谢 Mike Pall 提供补丁。_
    * 新增对 GNU/Hurd 平台的构建支持。_感谢 Mike Pall 提供补丁。_
    * ARM64：修复结构体按值传递的调用约定问题。_感谢 Mike Pall 提供补丁。_
    * ARM：修复软浮点模式下 math.min()/math.max() 的计算错误。_感谢 Mike Pall 提供补丁。_
    * 修复从快照恢复时因栈溢出错误导致程序计数器超出有效范围的问题。_感谢 Mike Pall 提供补丁。_
    * 修复 JIT trace 清除后字节码补丁被重复撤销的问题。_感谢 Mike Pall 提供补丁。_
    * 缺陷修复：修复了提交 538a82133ad 引入的 table.clone 功能失效问题。_感谢 lijunlong 提供补丁。_
    * 调整模板表中 nil 值标记的处理方式。_感谢 Mike Pall 提供补丁。_
    * FFI：新增 int128_t、uint128_t、__int128 等 128 位整数预声明类型。_感谢 Mike Pall 提供补丁。_
    * FFI：修复 CType 的悬空引用问题。_感谢 Mike Pall 提供补丁。_
    * 修复 load* 系列函数中的错误生成逻辑。_感谢 Mike Pall 提供补丁。_
    * 修复模板表中 nil 值标记的处理逻辑。_感谢 Mike Pall 提供补丁。_
    * 修复对新创建缓冲区执行 io.write() 时的错误。_感谢 Mike Pall 提供补丁。_
    * 修复向上递归过程中 JIT 槽溢出的问题。_感谢 Mike Pall 提供补丁。_
    * 修复错误处理过程中的错误上报逻辑。_感谢 Mike Pall 提供补丁。_
    * 修复记录 __concat 元方法时的状态恢复问题。_感谢 Mike Pall 提供补丁。_
    * 妥善处理已损坏的自定义内存分配器。_感谢 Mike Pall 提供补丁。_
    * 改进在 POSIX 系统上 CLI 的信号处理机制。_感谢 Mike Pall 提供补丁。_
    * 修复针对 cdata 元表进行 JIT 类型特化时未初始化部分值的问题。_感谢 Mike Pall 提供补丁。_
    * macOS：新增对 Apple Hardened Runtime 的支持。_感谢 Mike Pall 提供补丁。_
    * macOS：修复 Apple Hardened Runtime 的支持，并将其改为通过编译选项按需启用。_感谢 Mike Pall 提供补丁。_
    * macOS：进一步修复对 Apple Hardened Runtime 的支持。_感谢 Mike Pall 提供补丁。_
    * 从上游 v2.1 版本合并代码。_感谢 lijunlong 提供补丁。_
    * 阻止 Clang 将未定义行为（UB）当作"优化"手段，避免破坏整数类型检查逻辑。_感谢 Mike Pall 提供补丁。_
    * 从文档中移除 Cygwin，该平台已不再受支持。_感谢 Mike Pall 提供补丁。_
    * 撤销：对模板表中 nil 值标记处理方式的调整。_感谢 Mike Pall 提供补丁。_
    * iOS 安装包同样改用 dylib 扩展名。_感谢 Mike Pall 提供补丁。_
    * Windows：为 msvcbuild.bat 新增 lua52compat 编译选项。_感谢 Mike Pall 提供补丁。_
    * Windows：支持通过 msvcbuild.bat 进行混合构建。_感谢 Mike Pall 提供补丁。_
    * Windows：完善安装目录结构说明。_感谢 Mike Pall 提供补丁。_
    * x64：新增对 Intel CET IBT（间接分支跟踪）的支持。_感谢 Mike Pall 提供补丁。_
    * x86/x64：避免使用 MUL/IMUL 指令中未定义的零标志位行为。_感谢 Mike Pall 提供补丁。_

* [lua-resty-redis](https://github.com/openresty/lua-resty-redis)
    * 缺陷修复：修复了 blpop/brpop 调用超时后连接被意外关闭的问题。_感谢冉朋提供补丁。_
    * 文档：修复 README.markdown 中的拼写错误。_感谢 hms5232 提供补丁。_
    * 优化：`return setmetatable` 属于 LuaJIT 中尚未实现 JIT 编译的操作（NYI，Not Yet Implemented），此次进行了优化处理。(#287) _感谢 Zero King 提供补丁。_

* [xss-nginx-module](https://github.com/openresty/xss-nginx-module)
    * 新功能：新增动态模块构建支持。_感谢 Su Yang 提供补丁。_

* [lua-upstream-nginx-module](https://github.com/openresty/lua-upstream-nginx-module)
    * 文档：修复 get_servers 相关文档中的拼写错误。_感谢 chronolaw 提供补丁。_

* [lua-resty-lock](https://github.com/openresty/lua-resty-lock)
    * 文档：更正 README.markdown 中关于包状态的错误描述。_感谢 jumper047 提供补丁。_

* [ngx_devel_kit](https://github.com/simplresty/ngx_devel_kit)
    * src/ndk.h：当 `NDK` 未定义时，不再触发 `#error` 编译错误。_感谢 Simpl 提供补丁。_
    * src/ndk.h：当 `NDK` 未定义时，不再触发 `#error` 编译错误。_感谢 Zurab Kvachadze 提供补丁。_
    * src/ndk.h：更新版本号。_感谢 Simpl 提供补丁。_

* [headers-more-nginx-module](https://github.com/openresty/headers-more-nginx-module)
    * 缺陷修复：修复了输出响应头链表中 next 指针未置为 NULL 的问题。_感谢 lijunlong 提供补丁。_
    * 将 LICENSE 文件内容独立存放至单独文件中。_感谢 uhliarik 提供补丁。_

* [rds-csv-nginx-module](https://github.com/openresty/rds-csv-nginx-module)
    * 缺陷修复：将位域成员的类型改为 unsigned，以消除相关编译警告。_感谢 lijunlong 提供补丁。_

* [lua-resty-shell](https://github.com/openresty/lua-resty-shell)
    * 文档：补充 max_size 参数默认值的说明。_感谢 lijunlong 提供补丁。_
    * README.md：新增关于默认超时时间的说明 (#21)。_感谢 Jeffrey 'jf' Lim 提供补丁。_

* [lua-resty-mysql](https://github.com/openresty/lua-resty-mysql)
    * 缺陷修复：修复了 MySQL 驱动未能正确处理服务端查询超时（即"查询执行被中断"错误）的问题。_感谢 Nir Nahum 提供补丁。_

* [resty-cli](https://github.com/openresty/resty-cli)
    * 新功能：新增 --load-module 命令行选项。_感谢 lijunlong 提供补丁。_
    * 新功能：新增 --dump-nginx-conf 选项，可将 resty 自动生成的 nginx 配置打印输出。_感谢罗泽轩提供补丁。_

* [opm](https://github.com/openresty/opm)
    * opm：对命令行选项体系进行全面重构。_感谢 Dmitry Meyer 提供补丁。_
    * 文档：修复了用户命令行参数的示例错误。_感谢 Johnny Wang 提供补丁。_
    