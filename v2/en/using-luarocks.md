<!---
    @title         Using LuaRocks
    @creator       Yichun Zhang
    @created       2011-08-07 02:32 GMT
--->

**WARNING! This page is deprecated.
Use of LuaRocks with OpenResty is strongly discouraged since OpenResty provides its own package manager, [OPM](https://opm.openreresty.org).**

This sample demonstrates usage of [LuaRocks](http://www.luarocks.org/) with
[OpenResty](openresty.html). It's been tested on Linux and Mac OS X, with the
standard Lua interpreter or with [LuaJIT](luajit.html).

LuaRocks is a deployment and management system for Lua modules. LuaRocks allows
one to install Lua modules as self-contained packages called "rocks", which
also contain version dependency  information.

We assume that you have installed [OpenResty](openresty.html) into the default
location, i.e., `/usr/local/openresty`. You can adjust the paths in this sample
according to the actual installation prefix of your [OpenResty](openresty.html) installation.
If you haven't installed OpenResty yet, check out the [Download](download.html) and
[Installation](installation.html) pages.


#  Install LuaRocks
First of all, let's install LuaRocks:

Download the LuaRocks tarball from [https://luarocks.org/releases](https://luarocks.org/releases).
As of this writing, the latest version is `2.3.0`, but we'll use `2.0.13` for
compatibility throughout this sample.

```
wget http://luarocks.org/releases/luarocks-2.0.13.tar.gz
tar -xzvf luarocks-2.0.13.tar.gz
cd luarocks-2.0.13/
./configure --prefix=/usr/local/openresty/luajit \
    --with-lua=/usr/local/openresty/luajit/ \
    --lua-suffix=jit \
    --with-lua-include=/usr/local/openresty/luajit/include/luajit-2.1
make
sudo make install
```

#  Install the Lua MD5 library with LuaRocks
In this sample, we'll use the Lua MD5 library to serve as an example, so let's
install it with LuaRocks:

```
sudo /usr/local/openresty/luajit/luarocks install md5
```

#  Known issues
Pior to [OpenResty](openresty.html) 1.0.4.2rc10, it's known that turning `lua_code_cache` on
will cause LuaRocks atop [Lua Nginx Module](lua-nginx-module.html) to throw
out the following exception in `error.log`:

```
lua handler aborted: runtime error: stack overflow
```

If you're using any version of [OpenResty](openresty.html) before 1.0.4.2rc10,
please consider upgrading.
