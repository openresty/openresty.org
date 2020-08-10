<!---
    @title         OpenResty®
    @creator       Yichun Zhang
    @created       2011-06-21 04:03 GMT
--->

OpenResty<sup>&reg;</sup> 是一个基于 [Nginx](nginx.html) 与 Lua 的高性能 Web 平台，其内部集成了大量精良的
Lua 库、第三方模块以及大多数的依赖项。用于方便地搭建能够处理超高并发、扩展性极高的动态
Web 应用、Web 服务和动态网关。

OpenResty<sup>&reg;</sup> 通过汇聚各种设计精良的 [Nginx](nginx.html) 模块（主要由
OpenResty 团队自主开发），从而将 [Nginx](nginx.html) 有效地变成一个强大的通用
Web 应用平台。这样，Web 开发人员和系统工程师可以使用 Lua
脚本语言调动 [Nginx](nginx.html) 支持的各种 C 以及 Lua 模块，快速构造出足以胜任 10K
乃至 1000K 以上单机并发连接的高性能 Web 应用系统。

OpenResty<sup>&reg;</sup> 的目标是让你的Web服务直接跑在 [Nginx](nginx.html) 服务内部，充分利用
[Nginx](nginx.html) 的非阻塞 I/O 模型，不仅仅对 HTTP 客户端请求,甚至于对远程后端诸如
MySQL、PostgreSQL、Memcached 以及 Redis 等都进行一致的高性能响应。

参考 [组件](components.html) 可以知道 OpenResty<sup>&reg;</sup> 中包含了多少软件。

参考 [上路](getting-started.html) 学习如何从最简单的 hello world
开始使用 OpenResty<sup>&reg;</sup> 开发 HTTP 业务，或前往  [下载](download.html) 直接获取
OpenResty<sup>&reg;</sup> 的源代码包开始体验。
