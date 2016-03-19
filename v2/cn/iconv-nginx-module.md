<!---
    @title         Iconv Nginx Module
    @creator       Yichun Zhang
    @created       2011-06-21 09:04 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-06-22 07:36 GMT
    @changes       5
--->

This is an [Nginx](nginx.html) module that uses libiconv to convert characters
of different encoding. It brings the `set_iconv` and `iconv_filter` commands
to [Nginx](nginx.html).

It can either process [Nginx](nginx.html) variables or process response bodies
as an output filter.

This module is not enabled by default, and you need to specify the `--with-http_iconv_module` option
while [building OpenResty](installation.html). This [Nginx](nginx.html) module
requires libiconv to be installed into your system.

Use cases: http://forum.nginx.org/read.php?2,206658,207119

Project page: https://github.com/calio/iconv-nginx-module
