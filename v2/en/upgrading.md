<!---
    @title         Upgrading
    @creator       Yichun Zhang
    @created       2013-08-26 23:21 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2013-08-26 23:24 GMT
    @changes       3
--->

You can upgrade [OpenResty](openresty.html) to a newer release in the exactly
same way as upgrading [Nginx](nginx.html).

You can override the existing installation tree but you still need to restart
your running [Nginx](nginx.html) server from the new executable. Usually we
do something like this:

http://wiki.nginx.org/CommandLine#Upgrading_To_a_New_Binary_On_The_Fly

You can also just stop your current [Nginx](nginx.html) server and start it
from scratch again if you don't care about the down time in between.

But please note that HUP reload won't update the running [Nginx](nginx.html) server
processes with the newly installed executable file.

If you are using shared memory storage in your [Nginx](nginx.html) server (like
[Lua Nginx Module](lua-nginx-module.html)'s shared memory dictionaries), then
a full server restart will clear all the data in the shared memory zones. So
be careful here.
