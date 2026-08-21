<!---
    @title         Encrypted Session Nginx 模块
    @description   encrypted-session-nginx-module 基于 AES-256 加密 Nginx 变量，配合 set-misc 与 rewrite 指令可实现简单的用户登录与访问控制。
    @creator       Yichun Zhang
    @created       2011-06-21 08:34 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-06-21 08:39 GMT
    @changes       3
--->

This module provides encryption and decryption support for [Nginx](nginx.html) variables
based on AES-256 with Mac.

This module is usually used with [SetMiscNginxModule](set-misc-nginx-module.html) and
the standard [rewrite module](https://wiki.nginx.org/NginxHttpRewriteModule)'s
directives.

This module can be used to implement simple user login and access control of
web applications.

Project page: https://github.com/agentzh/encrypted-session-nginx-module
