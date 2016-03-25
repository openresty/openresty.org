<!---
    @title         Installation
    @creator       Yichun Zhang
    @created       2011-06-21 04:40 GMT
--->

If you haven't downloaded the [OpenResty](openresty.html) source code tarball,
please go to the [Download](download.html) page first.

(If you are on Windows, then you should check out [this documentation](https://github.com/openresty/openresty/blob/master/doc/README-win32.md#readme) instead.)

Basically, building and installing [OpenResty](openresty.html) is as simple
as

```
tar xvf ngx_openresty-VERSION.tar.gz
cd ngx_openresty-VERSION/
./configure
make
make install
```

where `VERSION` should be replaced by a concrete version number of [OpenResty](openresty.html),
like `0.8.54.6`.

If your system environment is modern enough, then you almost always want to
enable the PCRE JIT support and IPv6 support in your NGINX by passing the `--with-pcre-jit` and
`--with-ipv6` options to the `./configure` script.

By default, OpenResty is installed into the prefix `/usr/local/openresty/`.

Finally, you need to add the command-line utilities provided by OpenResty to your
`PATH` environment, as in

```
export PATH=/usr/local/openresty/bin:/usr/local/openresty/nginx/sbin:$PATH
```

if you are using bash. Better add this line to your shell's startup script, like `~/.bashrc`
or `~/.bash_profile`.

If you have problems while building or want finer control over the building
process, please read on.

# Prerequisites
You should have `perl 5.6.1+`, `libreadline`, `libpcre`, `libssl` installed
into your system. For Linux, you should also ensure that `ldconfig` is in your
PATH environment.

## Debian and Ubuntu users
You're recommended to install the following packages using apt-get:

```
apt-get install libreadline-dev libncurses5-dev libpcre3-dev \
    libssl-dev perl make build-essential
```


## Fedora and RedHat users
You're recommended to install the following packages using yum:

```
yum install readline-devel pcre-devel openssl-devel gcc
```


## Mac OS X (Darwin) users
You're recommended to install prerequisites PCRE and OpenSSL using some package
management tool, like [Homebrew](http://mxcl.github.com/homebrew/):

```
brew update
brew install pcre openssl
```

Alternatively you can install PCRE and/or OpenSSL from source all by yourself
:)

After installing PCRE and OpenSSL, you may need to specify the paths for their
headers and libraries to your C compiler and linker, for example,

```
$ ./configure \
   --with-cc-opt="-I/usr/local/opt/openssl/include/ -I/usr/local/opt/pcre/include/" \
   --with-ld-opt="-L/usr/local/opt/openssl/lib/ -L/usr/local/opt/pcre/lib/" \
   -j8
```

assuming that your PCRE and OpenSSL are installed under the prefix `/usr/local/opt/` which
is the default for homebrew.

See also [Issue #3](https://github.com/agentzh/ngx_openresty/issues/3).


## FreeBSD users
You need to install the following ports:
* devel/gmake
* security/openssl
* devel/pcre

## Solaris 11 users
You need to install the following packages from the official repository:
* gcc-3
* SUNWlibm
Usually it's just as simple as

```
pfexec pkg install gcc-3 SUNWlibm
```


# Build OpenResty

## [Download](download.html)
download the latest ngx_openresty tarball can be fetched from the [Download](download.html) page
and unpack it like this:

```
tar xzvf ngx_openresty-VERSION.tar.gz
```

where `VERSION` should be replaced by real version numbers like `0.8.54.6`.

## ./configure
Then enter the `ngx_openresty-VERSION/` directory, and type the following command
to configure:

```
./configure
```

By default, `--prefix=/usr/local/openresty` is assumed. You should only disable
[LuaJIT](luajit.html) 2 when your platform does not support [LuaJIT](luajit.html).

You can specify various options, as in

```
./configure --prefix=/opt/openresty \
            --with-pcre-jit \
            --with-ipv6 \
            --without-http_redis2_module \
            --with-http_iconv_module \
            --with-http_postgres_module \
            -j2
```

All of the standard [Nginx](nginx.html) configure file options can be used here,
including `--add-module=PATH` for adding your own 3rd-party [Nginx](nginx.html) C
modules. Try `./configure --help` to see more options available.

Errors in running the ./configure script can be found in the file `build/nginx-VERSION/objs/autoconf.err` where
`VERSION` should be replaced by a concrete version number of [OpenResty](openresty.html),
like `0.8.54.6`.

### Notes for Solaris users
For Solaris, it's common to install libraries like OpenSSL to `/lib`, so when
it complaints about missing OpenSSL and you have indeed already installed it,
specify the `--with-ld-opt='-L/lib'` option.

## make
Now you can compile everything up using the command

```
make
```

If your machine has multiple cores and your `make` supports the jobserver feature,
you can compile things in parallel like this:

```
make -j2
```

assuming you have 2 CPU cores.

## make install
If all the previous steps go without problems, you can install [OpenResty](openresty.html) into
your system by typing the command

```
make install
```

On Linux, it often requires `sudo` to gain root access.

If you prefer building the OpenSSL and PCRE dependencies from their source tarballs,
then you could follow the commands below (you may want to change the version
number accordingly):


```
wget https://www.openssl.org/source/openssl-1.0.2f.tar.gz
tar -zvxf openssl-1.0.2f.tar.gz

wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.38.tar.gz
tar -xvf pcre-8.38.tar.gz

wget https://openresty.org/download/openresty-1.9.7.3.tar.gz
tar -zxvf openresty-1.9.7.3.tar.gz
cd openresty-1.9.7.3/

# assuming your have 4 spare logical CPU cores
./configure --with-openssl=../openssl-1.0.2f \
                 --with-pcre=../pcre-8.38 -j4
make -j4
sudo make install
```

