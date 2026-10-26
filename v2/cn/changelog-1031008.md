<!---
    @title         变更日志 1.31.8.x
    @description   OpenResty® 1.31.8.x 系列的完整变更日志，涵盖 Nginx 核心、OpenSSL 3.5.9、PCRE2 10.49、LuaJIT 及内置组件的更新与修复。
    @creator       Junlong Li
    @created       2026-10-26 08:18 GMT
--->

# 版本 1.31.8.1 - 2026年10月26日

* Nginx 核心
    * 从 nginx 1.31.1 升级至 1.31.8。

* OpenSSL
    * 从版本 3.5.6 升级至 3.5.9。

* PCRE2
    * 从版本 10.47 升级至 10.49。

* 升级 [lua-nginx-module](https://github.com/openresty/lua-nginx-module) 至 v0.10.32rc7
    * 新功能：支持压缩通过 `ssl_certificate_by_lua*` 设置的证书。_感谢 Y.Horie 提供补丁。_
    * 缺陷修复：为每次 balancer 绑定单独分配本地地址。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：避免在过滤器中截断 Lua 上下文。_感谢 Hanada 提供补丁。_
    * 缺陷修复：修复 `balancer_by_lua*` 中重试计数回绕导致无限重试的问题。_感谢 Héctor 提供补丁。_
    * 缺陷修复：修复使用 `proxy_bind` 时 balancer keepalive 连接始终无法复用的问题。_感谢 Jiří Setnička 提供补丁。_
    * 缺陷修复：在 `precontent_by_lua` 中将返回值改为 `NGX_DECLINED`。_感谢 Hanada 提供补丁。_
    * 缺陷修复：终止用户线程时清理子协程的待处理操作。_感谢 Jun Ouyang 提供补丁。_
    * 缺陷修复：压缩证书之前清除继承的证书链。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：修复 `verify_client` 出错时重复释放客户端 CA 名称列表的问题。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：修复 `receiveuntil` 迭代器被垃圾回收后，`tcp_finalize` 中访问已释放堆内存的问题。_感谢 Y.Horie 提供补丁。_
    * 缺陷修复：标记 Lua 子请求，使其能在 HTTP/2 错误发生时被唤醒。(#2508) _感谢 kurt 提供补丁。_
    * 缺陷修复：修复 `ngx.flush()` 的缓冲区仍在队列中时就被回收的问题。(#2518) _感谢 Jiří Setnička 提供补丁。_
    * 缺陷修复：字符串辅助函数出错时抛出 `luaL_error`，而非返回 `NGX_ERROR`。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：修复 `pcre_fullinfo()` 失败时正则表达式编译仍返回 `NGX_OK` 的问题。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：拒绝在已完成握手的 cosocket 上调用 `settrustedstore`。(#2505) _感谢 perfgao 提供补丁。_
    * 缺陷修复：恢复子请求输入头列表仅含一个分段的不变条件。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：修复 `run_worker_thread` 错误处理路径中的内存泄漏、重复释放和计数过多问题。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：修复关闭 `lua_code_cache` 时 `server_rewrite_by_lua*` 使用全局 Lua VM 的问题。_感谢 xiaobiaozhao 提供补丁。_
    * 缺陷修复：修复内存不足时 `set_uri` / `set_uri_args` 从 Lua C 函数返回 -1 的问题。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：修复 `sslhandshake` 在握手立即完成时丢失证书验证错误的问题。(#2506) _感谢 kurt 提供补丁。_
    * 持续集成：使用打包的依赖测试 nginx 1.31.3。_感谢 lijunlong 提供补丁。_
    * 持续集成：更新 GitHub Actions 以使用 Node.js 24。_感谢 lijunlong 提供补丁。_
    * 文档：更新 `ngx.req.set_uri` 的文档。_感谢 Brian Rak 提供补丁。_
    * 代码风格：修正代码风格。_感谢 Hanada 提供补丁。_

* 升级 [stream-lua-nginx-module](https://github.com/openresty/stream-lua-nginx-module) 至 v0.0.20rc3
    * 缺陷修复：避免在 `receiveuntil` 迭代器被垃圾回收后访问已释放内存。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：终止用户线程时清理子协程的待处理操作。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：因错误结束连接之前，先发送完已缓冲的输出。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：修复源代码审查中发现的三个潜在问题。_感谢 lijunlong 提供补丁。_
    * 持续集成：使用打包的依赖测试 nginx 1.31.3。_感谢 lijunlong 提供补丁。_
    * 持续集成：更新 GitHub Actions 以使用 Node.js 24。_感谢 lijunlong 提供补丁。_

* 升级 [lua-resty-core](https://github.com/openresty/lua-resty-core) 至 v0.1.35rc2
    * 新功能：新增 `ngx.ssl.compress_certs()`。_感谢 Y.Horie 提供补丁。_
    * 缺陷修复：修复代码审查中发现的多个 FFI 正确性问题。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：移除 `sslhandshake` 在握手前发生错误时对结果的断言。(#534) _感谢 kurt 提供补丁。_
    * 缺陷修复：`sslhandshake` 在 FFI 立即返回 `FFI_ERROR` 时读取错误详情。(#533) _感谢 kurt 提供补丁。_
    * 缺陷修复：修复 stream cosocket 的 `getsslctx()` 绑定到错误 FFI 符号的问题。_感谢 perfgao 提供补丁。_
    * 持续集成：使用打包的依赖测试 nginx 1.31.3。_感谢 lijunlong 提供补丁。_
    * 持续集成：更新 GitHub Actions 以使用 Node.js 24。_感谢 lijunlong 提供补丁。_

* 升级 [luajit2](https://github.com/openresty/luajit2) 至 v2.1-20261023
    * 为 TNEW / TDUP 的 ALEN 添加 FOLD 规则。_感谢 Mike Pall 提供补丁。_
    * 新增行号指令，从 v3.0 反向移植。_感谢 Mike Pall 提供补丁。_
    * 允许在任意位置使用空语句（分号），从 v3.0 反向移植。_感谢 Mike Pall 提供补丁。_
    * ARM64：修复浮点范围为空时的 BC_JFORI。_感谢 Mike Pall 提供补丁。_
    * ARM64：修复 `__metatable` 字段被清除时的 `getmetatable()`。_感谢 Mike Pall 提供补丁。_
    * 避免更新分发表时与性能分析线程发生竞态。_感谢 Mike Pall 提供补丁。_
    * 反向移植部分 v3.0 语法扩展。_感谢 Mike Pall 提供补丁。_
    * 缺陷修复：更新 lj_tab.c，修复 ppc64le 上的测试失败问题。_感谢 Isgandar Valizada 提供补丁。_
    * 在 IR_ALEN 转发时检查 IR_NEWREF。_感谢 Mike Pall 提供补丁。_
    * 支持对 `unpack()` 进行 JIT 编译。_感谢 Mike Pall 提供补丁。_
    * 文档：说明位运算符的字节码兼容性。_感谢 Mike Pall 提供补丁。_
    * 对于无符号操作数，不对 `-a / -b` 进行折叠。_感谢 Mike Pall 提供补丁。_
    * 不记录步长为正零或负零的 for 循环。_感谢 Mike Pall 提供补丁。_
    * 性能分析器停止后不再使用已销毁的锁。_感谢 Mike Pall 提供补丁。_
    * DynASM/ARM64：避免 `dasm_imm13()` 中的 sanitizer 警告。_感谢 Mike Pall 提供补丁。_
    * DynASM/x86：修复 insertps 指令编码。_感谢 Mike Pall 提供补丁。_
    * DynASM/x86：修复 movd / movq 和 vmovd / vmovq 的操作数大小。_感谢 Mike Pall 提供补丁。_
    * FFI：在 `ffi.offsetof` 之后调整 `J->maxslot`。_感谢 Mike Pall 提供补丁。_
    * FFI/ARM64e：对 FFI 回调指针进行签名。_感谢 Mike Pall 提供补丁。_
    * FFI：在 CNEWI 的 FLOAD 的 FOLD 规则中保留符号属性。_感谢 Mike Pall 提供补丁。_
    * FFI：修复字符串缓冲区 `put()` 方法的 JIT 记录。_感谢 Mike Pall 提供补丁。_
    * FFI：修复 64 位算术运算的扩展语义。_感谢 Mike Pall 提供补丁。_
    * FFI/macOS：修复枚举类型的调用约定。_感谢 Mike Pall 提供补丁。_
    * FFI/macOS：修复栈上传递的可变参数的调用约定。_感谢 Mike Pall 提供补丁。_
    * FFI：在垃圾回收的原子阶段标记 `cts->L`。_感谢 Mike Pall 提供补丁。_
    * FFI：避免 `carith_ptr()` 中的 sanitizer 警告。_感谢 Mike Pall 提供补丁。_
    * FFI：在 FFI 回调中设置 `cur_L`。_感谢 Mike Pall 提供补丁。_
    * FFI：修复多个 ABI 和调用约定问题。_感谢 Mike Pall 提供补丁。_
    * 修复 s390x 上对 0 执行 BC_UNM 的问题。(#259) _感谢 Ilya Leoshkevich 提供补丁。_
    * 修复 DragonFly 上的并发分配问题（该平台不受支持）。_感谢 Mike Pall 提供补丁。_
    * 修复 `os.time()` 的边界情况。_感谢 Mike Pall 提供补丁。_
    * 文档：修正关于 Lua 5.2 扩展和兼容性的说明。_感谢 Mike Pall 提供补丁。_
    * 修复 ITERN 取消特化后立即记录 `next()` 的问题。_感谢 Mike Pall 提供补丁。_
    * 修复安全导航运算符的解析。_感谢 Mike Pall 提供补丁。_
    * 修复栈溢出时重设限制的处理逻辑。_感谢 Mike Pall 提供补丁。_
    * 修复 `unpack()` 的 JIT 记录。_感谢 Mike Pall 提供补丁。_
    * 处理 trace 拼接期间的内存不足错误。_感谢 Mike Pall 提供补丁。_
    * iOS：避免宏名称冲突。_感谢 Mike Pall 提供补丁。_
    * iOS：禁用无法正常工作的 `os.tmpname()`。_感谢 Mike Pall 提供补丁。_
    * macOS：避免机器码与 xzone malloc 回收环发生冲突。_感谢 Mike Pall 提供补丁。_
    * 统一 `os.time()` 中的检查逻辑。_感谢 Mike Pall 提供补丁。_
    * 更新 `jit.*` Lua 模块的实现。_感谢 Mike Pall 提供补丁。_
    * 优化 `string.sub` / `string.byte` 常见的单字符情况。_感谢 Mike Pall 提供补丁。_
    * 支持在 `jit.util.tracesnap()` 中按需返回程序计数器位置。_感谢 Mike Pall 提供补丁。_
    * PPC64：修正 64 位 ABI 的数字转换。_感谢 Evan Wies 提供补丁。_
    * PPC64：重置字符串缓冲区时使用指针宽度的内存访问。_感谢 Minsoo Choo 提供补丁。_
    * PPC：通过私有 GOT 而非 PLT 调用 libm 辅助函数。(#271) _感谢 Josef Schlehofer 提供补丁。_
    * PPC：修复启用 P64 时的 `string.*` 快速函数（仅用于测试）。_感谢 Mike Pall 提供补丁。_
    * PPC 软浮点：修复 `ipairs()` 返回损坏的值及 `pairs()` 产生多余 nil 的问题。(#270) _感谢 Josef Schlehofer 提供补丁。_
    * 避免 `os.time()` 中的 sanitizer 警告。_感谢 Mike Pall 提供补丁。_
    * 避免 `lj_tab_new*()` 和 `table.new()` 的 sanitizer 警告。_感谢 Mike Pall 提供补丁。_
    * s390x：新增位运算符支持。(#275) _感谢 Andreas Arnez 提供补丁。_
    * s390x：修复 ERRF cframe 槽的大端内存访问。(#268) _感谢 Ulrich Weigand 提供补丁。_
    * s390x：修复异常展开期间的错误码返回。_感谢 Ulrich Weigand 提供补丁。_
    * Windows：带进制参数的 `tonumber()` 使用 64 位转换。_感谢 Mike Pall 提供补丁。_
    * x64/ARM64/MIPS64：修复常量位移的代码生成。_感谢 Mike Pall 提供补丁。_
    * x64：修复回调结果的处理。_感谢 Mike Pall 提供补丁。_
    * x64：修复 `math.floor()` / `math.ceil()` 的参数检查。_感谢 Mike Pall 提供补丁。_
    * x64/LJ_GC64：避免栈恢复后存储到加载转发造成的停顿。_感谢 Mike Pall 提供补丁。_
    * x64/LJ_GC64：启用 XLOAD / STRREF 融合。_感谢 Mike Pall 提供补丁。_
    * x64/LJ_GC64：修复 XLOAD 融合。_感谢 Mike Pall 提供补丁。_
    * x86：按条件使用 SSE3 进行 64 位转换。_感谢 Mike Pall 提供补丁。_
    * x86：修复 `math.floor()` / `math.ceil()` 的参数检查。_感谢 Mike Pall 提供补丁。_
    * x86/x64：调整 `ipairs_aux` 以匹配 JIT 后端行为。_感谢 Mike Pall 提供补丁。_

* 升级 [opm](https://github.com/openresty/opm) 至 v0.0.12
    * 缺陷修复：网站使用 WebP 格式的 OpenResty 标志。_感谢 lijunlong 提供补丁。_
    * 变更：仅使用一个 worker 进程。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：构建时使用 `marked.parse()`，兼容 marked v4。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：生成失败时删除 templates.lua，并将 VERSION 更新为 0.0.10。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：pgmoon 解析受影响行数时不包含 NUL 字符。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：网站在登录名相同的用户和组织下均查找软件包页面。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：网站在登录名相同的用户和组织下均查找待获取的软件包。_感谢 lijunlong 提供补丁。_
    * 版本：更新至 v0.0.11。_感谢 lijunlong 提供补丁。_

* 升级 [set-misc-nginx-module](https://github.com/openresty/set-misc-nginx-module) 至 v0.34
    * 缺陷修复：初始化 base32 解码的哨兵表。_感谢 lijunlong 提供补丁。_
    * 文档：修复 README.markdown 中的若干拼写错误。_感谢 willmafh 提供补丁。_

* 升级 [lua-resty-upstream-healthcheck](https://github.com/openresty/lua-resty-upstream-healthcheck) 至 v0.10
    * 缺陷修复：发送超时时关闭探测套接字。_感谢 lijunlong 提供补丁。_

* 升级 [encrypted-session-nginx-module](https://github.com/openresty/encrypted-session-nginx-module) 至 v0.10
    * 缺陷修复：使用常量时间比较 MAC，并以对齐方式读取时间戳。_感谢 lijunlong 提供补丁。_

* 升级 [lua-resty-dns](https://github.com/openresty/lua-resty-dns) 至 v0.24
    * 缺陷修复：拒绝不完整的 DNS 资源记录。_感谢 lijunlong 提供补丁。_
    * 持续集成：从 Travis CI 迁移至 GitHub Actions。_感谢 lijunlong 提供补丁。_
    * 持续集成：测试 nginx 1.31.3。_感谢 lijunlong 提供补丁。_
    * 持续集成：更新 GitHub Actions 以使用 Node.js 24。_感谢 lijunlong 提供补丁。_

* 升级 [drizzle-nginx-module](https://github.com/openresty/drizzle-nginx-module) 至 v0.1.14
    * 缺陷修复：避免调试日志访问已释放的列数据。_感谢 lijunlong 提供补丁。_

* 升级 [lua-resty-redis](https://github.com/openresty/lua-resty-redis) 至 v0.34
    * 缺陷修复：保留模块命令参数和事务状态。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：仅根据已确认的回复更新事务状态，并为数据库和用户名使用无歧义的连接池名称。_感谢 shushen 提供补丁。_
    * 持续集成：从 Travis CI 迁移至 GitHub Actions。_感谢 lijunlong 提供补丁。_
    * 持续集成：使用打包的依赖测试 nginx 1.31.3。_感谢 lijunlong 提供补丁。_
    * 持续集成：更新 GitHub Actions 以使用 Node.js 24。_感谢 lijunlong 提供补丁。_
    * 新功能：为 `connect()` 新增 `db` / `password` / `username` / `tcp_keepalive` 选项，支持向 `hmget()` 传入 table，并包含两项缺陷修复。_感谢 shushen 提供补丁。_

* 升级 [lua-resty-memcached](https://github.com/openresty/lua-resty-memcached) 至 v0.18
    * 缺陷修复：从 `_version_reply` 返回实际错误。_感谢 lijunlong 提供补丁。_

* 升级 [ngx_postgres](https://github.com/openresty/ngx_postgres) 至 v1.1
    * 缺陷修复：在被其他模块包装时恢复 postgres 的 peer 数据。_感谢 lijunlong 提供补丁。_
    * 开发：加入 util/build.sh。_感谢 Yichun Zhang (agentzh) 提供补丁。_
    * 开发：移除 util/build.sh 中 HTTP auth request 模块的冗余配置选项。(#6) _感谢 Johnny Wang 提供补丁。_
    * 代码风格：修复 ngx-releng 发现的细微代码风格问题。_感谢 Yichun Zhang (agentzh) 提供补丁。_

* 升级 [lua-resty-openssl](https://github.com/fffonion/lua-resty-openssl) 至 v1.9.0
    * 持续集成：新增 OpenSSL 4.0 测试矩阵并升级 FIPS provider。_感谢 Wangchong Zhou 提供补丁。_
    * 持续集成：更新 GitHub Actions 版本。_感谢 Wangchong Zhou 提供补丁。_
    * 持续集成：更新工作流中的 OpenSSL 和 NGINX 版本。(#234) _感谢 Wangchong Zhou 提供补丁。_
    * 持续集成：更新 OpenSSL 版本。_感谢 Wangchong Zhou 提供补丁。_
    * 兼容性：支持 OpenResty 1.29.2。_感谢 leaf corcoran 提供补丁。_
    * 文档：改进 README 的英文表述。_感谢 Wangchong Zhou 提供补丁。_
    * 新功能：支持 OpenSSL 4.0。_感谢 Wangchong Zhou 提供补丁。_
    * 新功能：pkey 支持后量子密钥操作。_感谢 Wangchong Zhou 提供补丁。_
    * 缺陷修复：修正 `bn:mod_sqr` 和 pkey 的错误信息。(#233) _感谢 perfgao 提供补丁。_
    * 缺陷修复：改进 pkey 的原始密钥处理，使其更加通用。_感谢 Wangchong Zhou 提供补丁。_
    * 缺陷修复：pkey 识别 provider 原生密钥类型。_感谢 Wangchong Zhou 提供补丁。_
    * 缺陷修复：pkey 动态分配原始密钥缓冲区大小。_感谢 Wangchong Zhou 提供补丁。_
    * 版本：发布 1.8.0。(#237) _感谢 Wangchong Zhou 提供补丁。_
    * 版本：发布 1.9.0。_感谢 Wangchong Zhou 提供补丁。_

* 升级 [lua-resty-websocket](https://github.com/openresty/lua-resty-websocket) 至 v0.16
    * 缺陷修复：客户端拒绝状态码不是 101 的握手响应。_感谢 Shreemaan Abhishek 提供补丁。_
    * 缺陷修复：处理折叠的头字段，并去除协议字段中的多余空白。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：增强 WebSocket 解析和超时恢复的健壮性。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：在 `recv_frame` 中检查接收错误是否为 nil。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：校验握手，并支持继续接收不完整的 WebSocket 帧。_感谢 lijunlong 提供补丁。_
    * 持续集成：从 Travis CI 迁移至 GitHub Actions。_感谢 lijunlong 提供补丁。_
    * 持续集成：使用打包的依赖测试 nginx 1.31.3。_感谢 lijunlong 提供补丁。_
    * 持续集成：更新 GitHub Actions 以使用 Node.js 24。_感谢 lijunlong 提供补丁。_
    * 文档：修复注释中的拼写错误。_感谢 harry-xm 提供补丁。_

* 升级 [lua-resty-mysql](https://github.com/openresty/lua-resty-mysql) 至 v0.31
    * 缺陷修复：修正 caching_sha2 认证中密码扰乱计算的索引。_感谢 lijunlong 提供补丁。_

* 升级 [lua-cjson](https://github.com/openresty/lua-cjson) 至 v2.1.0.20
    * 缺陷修复：调整 C99 风格的 for 循环变量声明，兼容 GCC 4.8.5 的 C89 模式。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：为 `encode_indent` 字符串持有独立副本。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：在一个 cjson 实例上设置 `encode_escape_forward_slash` 不再影响其他实例。_感谢 SnowOnion 提供补丁。_
    * 持续集成：更新 GitHub Actions 以使用 Node.js 24。_感谢 lijunlong 提供补丁。_
    * 新功能：新增对编码后的对象键进行排序的选项。_感谢 Artem Krinitsyn 提供补丁。_

* 升级 [headers-more-nginx-module](https://github.com/openresty/headers-more-nginx-module) 至 v0.40
    * 缺陷修复：限制 Content-Type 字符集解析的边界，并为每个头字段重置 builtin 标志。_感谢 lijunlong 提供补丁。_
    * 文档：在 README 中添加分号以修复语法。_感谢 Baba Boota 提供补丁。_
    * 文档：更新版权声明。_感谢 lijunlong 提供补丁。_
    * 文档：更新最新兼容的 nginx 版本。_感谢 lijunlong 提供补丁。_

* 升级 [lua-resty-signal](https://github.com/openresty/lua-resty-signal) 至 v0.05
    * 缺陷修复：在所有平台上映射 SIGSYS。_感谢 lijunlong 提供补丁。_

* 升级 [ngx_devel_kit](https://github.com/openresty/ngx_devel_kit) 至 v0.3.6
    * 缺陷修复：检测 nginx 的复杂值脚本支持。_感谢 lijunlong 提供补丁。_
    * 缺陷修复：支持 nginx 1.31.3 的复杂值。_感谢 lijunlong 提供补丁。_

* 升级 [echo-nginx-module](https://github.com/openresty/echo-nginx-module) 至 v0.65
    * 缺陷修复：在内存不足时，子请求和 location 处理函数检查 ctx 是否为空。_感谢 lijunlong 提供补丁。_

* 升级 [srcache-nginx-module](https://github.com/openresty/srcache-nginx-module) 至 v0.34
    * 缺陷修复：修正 ctx 的分配大小以及空参数的清零处理。_感谢 lijunlong 提供补丁。_

* 升级 [memc-nginx-module](https://github.com/openresty/memc-nginx-module) 至 v0.21
    * 缺陷修复：在 `$memc_flags_as_http_time` 处理函数中检查 ctx 是否为空。_感谢 lijunlong 提供补丁。_

* 升级 [lua-resty-string](https://github.com/openresty/lua-resty-string) 至 v0.19
    * 缺陷修复：将 `RAND_bytes` 返回 -1 视为失败。_感谢 lijunlong 提供补丁。_
    * 新功能：新增 `md5.final_hex()` 方法，直接输出十六进制摘要。_感谢 lijunlong 提供补丁。_

* 升级 [resty-cli](https://github.com/openresty/resty-cli) 至 v0.36
    * 新功能：resty 新增 `--no-clean` 选项，退出时保留临时 nginx 前缀目录。_感谢 lijunlong 提供补丁。_
    * 优化：md2pod 将 Setext 标题正则表达式的匹配范围限制在单行内。_感谢 lijunlong 提供补丁。_
    * 优化：md2pod 为开销较大的解析正则表达式添加前置检查。_感谢 lijunlong 提供补丁。_
    * 优化：nginx-xml2pod 按标签名分派解析逻辑。_感谢 lijunlong 提供补丁。_
