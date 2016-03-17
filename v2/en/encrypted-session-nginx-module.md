<!---
    @title         Encrypted Session Nginx Module
    @creator       Yichun Zhang
    @created       2011-06-21 08:34 GMT
    @modifier      YichunZhang
    @modified      2011-06-21 08:39 GMT
    @changecount   3
--->

This module provides encryption and decryption support for [Nginx](nginx/) variables based on AES-256 with Mac.

This module is usually used with [SetMiscNginxModule](set-misc-nginx-module/) and the standard [rewrite module](http://wiki.nginx.org/NginxHttpRewriteModule)'s directives.

This module can be used to implement simple user login and access control of web applications.

Project page: http://github.com/agentzh/encrypted-session-nginx-module
