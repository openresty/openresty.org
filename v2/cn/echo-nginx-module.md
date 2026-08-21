<!---
    @title         Echo Nginx 模块
    @description   echo-nginx-module 封装了大量 Nginx 内部 API，用于流式输入输出、并发/串行子请求、定时器与元数据访问，主要用于测试与调试。
    @creator       Yichun Zhang
    @created       2011-06-21 08:24 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-08-26 01:12 GMT
    @changes       4
--->

This module wraps lots of [Nginx](nginx.html) internal APIs for streaming input
and output, parallel/sequential subrequests, timers and sleeping, as well as
various meta data accessing.

Basically it provides various utilities that help testing and debugging of other
modules by trivially emulating different kinds of faked subrequest locations.

Documentation: https://wiki.nginx.org/HttpEchoModule

Project page: https://github.com/agentzh/echo-nginx-module
