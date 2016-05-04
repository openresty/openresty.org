<!---
    @title         Getting Involved
    @creator       Yichun Zhang
    @created       2013-08-03 04:25 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2013-08-03 04:42 GMT
    @changes       7
--->

The [OpenResty](openresty.html) project has a loose organization. Most of the
components are self-contained open-source projects and are developed separately.
They all have their own code repositories, their own test suites, or even their
own maintainers. The maintainer of the [OpenResty](openresty.html) bundle, [agentzh](yichun-zhang.html),
is also maintaining most of the components included.

The [ngx_openresty GitHub repository](https://github.com/agentzh/ngx_openresty/) only
contains the facilities to generate a tarball from all the components' releases
for the bundle itself.

You can contribute patches or report bugs to each of the component separately.
Please check out the [Components](components.html) page for more details about
each component project.

For example, one of the core components, [Lua Nginx Module](lua-nginx-module.html),
has its official code repository hosted on [GitHub](github.html) as well: https://github.com/openresty/lua-nginx-module

Another core component, the [Nginx](nginx.html) core, is developed by the [Nginx company](http://nginx.com).
And the opensource development of the [Nginx](nginx.html) core usually happens
on the official [nginx-devel mailing list](http://mailman.nginx.org/mailman/listinfo/nginx-devel).
But also keep in mind that the [OpenResty](openresty.html) bundle also maintains
[a set of small patches](https://github.com/agentzh/ngx_openresty/tree/master/patches/) for
the [Nginx](nginx.html) core to fix some urgent bugs or add a few really important
features that must reside in the core.

Discussions not specific to the [Nginx](nginx.html) core should happen on the
[openresty-en mailing list](https://groups.google.com/group/openresty-en) (or
the [openresty Chinese mailing list](https://groups.google.com/group/openresty)).
See the [Community](community.html) page for more details. You are always welcome
to join us there.

The maintainer of the [OpenResty](openresty.html) bundle periodically runs a
big test cluster on [Amazon EC2](http://aws.amazon.com/ec2/) where the test
suite of each component bundled is run against the latest [Nginx](nginx.html) releases.
You can always check out the test reports on the [qa.openresty.org site](http://qa.openresty.org).
