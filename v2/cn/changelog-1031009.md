<!---
    @title         变更日志 1.31.9.x
    @description   OpenResty® 1.31.9.x 系列的变更日志，涵盖 Nginx 1.31.9 安全修复、LuaJIT、TLS 和共享字典 API，以及内置组件更新。
    @creator       Junlong Li
    @created       2026-11-23 13:38 GMT
--->

# 版本 1.31.9.1 - 2026年11月23日

* Nginx 核心
    * 从 Nginx 1.31.8 升级至 1.31.9，纳入 **10 项上游安全修复**。
        * **HTTP/2 和 HTTP/3。** 修复 HTTP/2 流量控制中的内存损坏（CVE-2026-123007），以及 HTTP/2（CVE-2026-123633）和 HTTP/3（CVE-2026-121810）创建流时访问已释放内存的问题。
        * **DNS 解析和邮件代理。** 修复 DNS 响应处理（CVE-2026-123634）和邮件代理（CVE-2026-113425）中访问已释放内存的问题。
        * **HTTP 路由和请求体。** 修复涉及 `try_files` 和 `alias` 的缓冲区溢出（CVE-2026-125283），以及通过 TLS 读取请求体时 worker 进程陷入循环的问题（CVE-2026-118899）。
        * **Stream TLS。** 修复使用错误虚拟服务器配置验证客户端证书（CVE-2026-120967）、同时使用 PROXY protocol v2 和动态证书时解引用空指针（CVE-2026-120993），以及 `ssl_preread` 对 ClientHello 消息校验不足（CVE-2026-123640）的问题。[Nginx 安全公告](https://nginx.org/en/security_advisories.html)
    * 拒绝缺少冒号的 HTTP 头字段行，以及分块编码开销过大的请求体。上游还修复了 HTTP/3 QPACK 解码、丢弃请求体时代理请求可能挂起，以及 MMDB 文件中的无效 GeoIP 坐标导致的问题。[Nginx 1.31.9 变更记录](https://nginx.org/en/CHANGES)
    * 修复了上游通知处理，避免成功响应消耗 Lua balancer 的重试次数。[OpenResty #1154](https://github.com/openresty/openresty/issues/1154)

* 将 [encrypted-session-nginx-module](https://github.com/openresty/encrypted-session-nginx-module) 从 v0.10 升级至 v0.11。
    * 加密每个新会话令牌时生成随机初始化向量（IV），并使用 HMAC-SHA256 对令牌进行认证。
    * **升级注意事项。** 新版本会拒绝现有令牌，用户需要重新建立会话。请先升级所有互相交换令牌的实例，再签发新令牌。[令牌格式兼容性](https://github.com/openresty/encrypted-session-nginx-module/blob/v0.11/README.md#token-format-compatibility)

* 将 [lua-nginx-module](https://github.com/openresty/lua-nginx-module) 从 v0.10.32rc7 升级至 v0.10.32rc8。
    * 新增 FFI 支持，可在处理 ClientHello 时设置 TLS 密码列表和 TLS 1.3 密码套件，也可获取请求的 `SSL_CTX`。配置无效时保留原有设置。
    * 为共享字典新增原子操作，可在条目值仍匹配时更新其过期时间或删除该条目。
    * 新增 balancer keepalive 空闲连接数的单池上限。修复切换 TLS 时选择上游协议的问题，以及绑定无效本地地址时 worker 进程崩溃的问题。_感谢 Jun Ouyang、Weixie Cui 和 gresham 提供补丁。_
    * 改进 cosocket 排队机制。即使同一轮事件循环释放多个连接池槽位，等待中的连接也能以常数时间恢复。连接尝试期间会保留已分配的槽位。_感谢 perfgao 和 AxisNow-Dev 提供修复。_
    * 清理请求时，取消普通 Lua 协程中的待处理操作。
    * 修复 `lua_ssl_key_log` 在 BoringSSL 下不生效的问题，并在使用 BoringSSL 的构建中启用 `ngx.ssl.export_keying_material()`。_感谢耗子提供补丁。_

* 将 [stream-lua-nginx-module](https://github.com/openresty/stream-lua-nginx-module) 从 v0.0.20rc3 升级至 v0.0.20rc4。
    * 新增相应的 TLS 和共享字典 FFI 操作，并支持取消密码选择时的服务端优先设置。
    * 修复 cosocket 队列和连接池槽位管理，使等待中的连接在有空闲槽位时恢复。_感谢 perfgao 和 AxisNow-Dev 提供修复。_
    * 每次读取后解除 `receiveuntil()` 匹配模式的绑定，切换读取方式时保留尚未处理的分隔符字节。清理会话时，取消普通 Lua 协程中的待处理操作。

* 将 [lua-resty-core](https://github.com/openresty/lua-resty-core) 从 v0.1.35rc2 升级至 v0.1.35rc3。
    * 新增 `ngx.ssl.get_req_ssl_ctx()`，并在 `ngx.ssl.clienthello` 中新增 `set_ciphers()` 和 `set_ciphersuites()` 方法。这两个方法可在 `ssl_client_hello_by_lua*` 中调用，要求 OpenSSL 1.1.1 或更高版本。
    * 通过 `ngx.shared.DICT:compare_expire()` 提供原子的比较后更新与比较后删除操作。
    * 为 `ngx.balancer.enable_keepalive()` 新增可选的 `pool_size` 参数。_感谢 Jun Ouyang 提供补丁。_

* 将 [lua-resty-lock](https://github.com/openresty/lua-resty-lock) 从 v0.09 升级至 v0.10。
    * 防止原持有者在锁过期后释放或延长其他调用方新获取的锁。这一检查覆盖主动释放、修改过期时间和垃圾回收。
    * 使用配套版本的 `lua-resty-core` 和 HTTP 或 stream Lua 模块来原子地检查锁的归属。

* 将 [luajit2](https://github.com/openresty/luajit2) 从 v2.1-20261023 升级至 v2.1-20261117。
    * 修复 FFI 数组初始化的边界检查、位运算转换失败时的报错，以及将负整数转换为 64 位指针时的符号扩展。其他指针转换避免了不必要的位宽扩展。
    * 修复 `select()` 索引超出可变参数范围时的 JIT 记录，以及 `ldexp()` 指数为非整数时的常量折叠。新增三元运算符的嵌套深度检查。
    * 修复 x86 和 x64 上类型转换及存储操作的 JIT 代码生成，并避免启用 GC64 的 x64 构建在恢复栈后发生存储到加载转发停顿。
    * 修复 DynASM 行号指令中的路径转义和 ARM64 上的一项 sanitizer 警告。_感谢 Mike Pall 提供 LuaJIT 补丁。_

* 将 [lua-resty-openssl](https://github.com/fffonion/lua-resty-openssl) 从 1.9.0 升级至 1.10.0。
    * 更新了对近期 OpenResty 版本的 TLS 集成。该库优先使用 `lua-resty-core` 的 SSL 访问接口，并可调用随 OpenResty 提供的辅助模块。
    * 修复对 SM2 密钥的支持。[上游变更日志](https://github.com/fffonion/lua-resty-openssl/blob/1.10.0/CHANGELOG.md#1100---2026-11-17)

* 新增 [lua-resty-openssl-aux-module](https://github.com/fffonion/lua-resty-openssl-aux-module) 0.3.0。
    * 为 TLS 操作提供原生辅助功能。启用 `lua-resty-openssl` 时，OpenResty 默认构建该模块。

* 将 [headers-more-nginx-module](https://github.com/openresty/headers-more-nginx-module) 从 v0.40 升级至 v0.42。
    * 修复媒体类型的匹配逻辑。匹配时忽略大小写，匹配请求的内容类型时也忽略参数。
    * 修复多条指令连续替换或清除 `Content-Type` 时的字符集处理。
    * 修复仅替换模式下缺少 `Cookie` 等允许有多个值的请求头时的处理。

* 将 [drizzle-nginx-module](https://github.com/openresty/drizzle-nginx-module) 从 v0.1.14 升级至 v0.1.15。
    * 向客户端发送的数据积压时暂停从数据库读取，恢复读取时沿用剩余的接收超时时间。复用流式输出缓冲区，同时保留 RDS 帧结构。
    * 仅在发送 SQL 前重试失败的连接，避免重复执行可能已经运行的查询。
    * 移除密码日志，修复 keepalive 配置校验和 IPv6 地址处理。

* 将 [echo-nginx-module](https://github.com/openresty/echo-nginx-module) 从 v0.65 升级至 v0.66。
    * `echo_duplicate` 会拒绝溢出的计数和输出长度，`echo_foreach_split` 会拒绝空分隔符。
    * 修复请求清理顺序，避免内存分配失败后留下仍在运行的休眠定时器。

* 将 [array-var-nginx-module](https://github.com/openresty/array-var-nginx-module) 从 v0.06 升级至 v0.07。
    * 在映射或拼接数组前校验数组引用，并拒绝溢出的初始容量。有效的数组引用在内部重定向和子请求中仍可使用。

* 将 [ngx_postgres](https://github.com/openresty/ngx_postgres) 从 1.1 升级至 v1.2。
    * 修复在 Nginx 1.31.3 及更高版本上对复杂配置值的支持。_感谢 Appla 提供补丁。_

* Windows 构建
    * 改用 HTTPS 从上游归档下载 zlib。
    * Windows CI 任务会上传构建生成的 `nginx.exe`。如果同时生成了 `lua51.dll`，也会一并上传。_感谢 Adam Delarosa 和 sunaer 提供补丁。_
