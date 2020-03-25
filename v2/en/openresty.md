<!---
    @title         OpenResty®
    @creator       Yichun Zhang
    @created       2011-06-21 04:03 GMT
--->

***New!*** [OpenResty 1.15.8.4](ann-1015008004.html) formal version is now released!

***New!*** [OpenResty 1.17.8.1 RC1](ann-1017008001rc1.html) is available for testing!

***New!*** New blog post "[How OpenResty and Nginx Allocate and Manage Memory](https://blog.openresty.com/en/how-or-alloc-mem/)" is published.

OpenResty<sup>&reg;</sup> is a full-fledged web platform that integrates our
enhanced version of the
[Nginx](nginx.html) core, our enhanced version of [LuaJIT](https://github.com/openresty/luajit2), many carefully written Lua
libraries, lots of high quality [3rd-party Nginx modules](components.html), and
most of their external dependencies. It is designed to help developers easily
build scalable web applications, web services, and dynamic web gateways.

By taking advantage of various well-designed [Nginx](nginx.html) modules (most
of which are developed by the OpenResty team themselves), OpenResty<sup>&reg;</sup> effectively
turns the nginx server into a powerful web app server, in which the web developers
can use the Lua programming language to script various existing nginx C modules
and Lua modules and construct extremely high-performance web applications that
are capable to handle 10K ~ 1000K+ connections in a single box.

OpenResty<sup>&reg;</sup> aims to run your server-side web app completely in the [Nginx](nginx.html) server,
leveraging [Nginx](nginx.html)'s event model to do non-blocking I/O not only
with the HTTP clients, but also with remote backends like MySQL, PostgreSQL,
Memcached, and Redis.

Real-world applications of OpenResty<sup>&reg;</sup> range from dynamic web portals and web
gateways, web application firewalls, web service platforms for mobile
apps/advertising/distributed storage/data analytics,
to full-fledged dynamic web applications and web sites. The hardware used to
run OpenResty<sup>&reg;</sup> also ranges from very big metals to embedded devices with very
limited resources. It is not uncommon for our production users to serve billions
of requests daily for millions of active users with just a handful of machines.

OpenResty<sup>&reg;</sup> is *not* an [Nginx](nginx.html) fork. It is a higher
level application and gateway platform using Nginx as a component.
Most of the patches applied to the [Nginx](nginx.html) core in OpenResty<sup>&reg;</sup> have
already been submitted to the official [Nginx](nginx.html) team and most of
the patches submitted have also been accepted. We constantly import the latest
features and bug fixes from the official [Nginx](nginx.html) team, the official LuaJIT repository, and other sources.

See [Components](components.html) for the complete list of software bundled
in OpenResty<sup>&reg;</sup>.

See [GettingStarted](getting-started.html) on how to quickly setup an OpenResty<sup>&reg;</sup>
server that can say hello world over HTTP. Or you can go to the [Download](download.html) section
to grab OpenResty<sup>&reg;</sup>'s source code tarball directly.

We provide free technical support through the community on the openresty and openresty-en mailing
lists. See [Community](community.html).

Our [OpenResty Inc.](https://openresty.com/) company offers commercial products based on OpenResty
to its global customers, with commercial support.
