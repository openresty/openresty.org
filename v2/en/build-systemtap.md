<!---
    @title         Build Systemtap
    @creator       Yichun Zhang
    @created       2014-03-04 22:18 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2015-01-27 06:32 GMT
    @changes       20
--->

1. Install the prerequisites on your Linux distribution, for example:
* Fedora:

```
sudo yum install gcc gcc-c++ elfutils-devel
```

* Ubuntu:

```
sudo apt-get install build-essential zlib1g-dev elfutils libdw-dev gettext
```

2. Compile and install systemtap from source:

```
wget https://sourceware.org/systemtap/ftp/releases/systemtap-2.6.tar.gz
tar -xvf systemtap-2.6.tar.gz
cd systemtap-2.6/
./configure --prefix=/opt/stap --disable-docs \
            --disable-publican --disable-refdocs CFLAGS="-g -O2"
make -j8   # the -j8 option assumes you have about 8 logical CPU cores available
sudo make install
```


If you'd like to build with the latest elfutils from the official source too:

```
cd /tmp
wget https://fedorahosted.org/releases/e/l/elfutils/0.161/elfutils-0.161.tar.bz2
tar -xvf elfutils-0.161.tar.bz2
```


Pass the following option to `./configure` when building systemtap (above):

```
--with-elfutils=/tmp/elfutils-0.161
```

Generally it's recommended to use the elfutils that comes with your package
manager if it is up to date, because it's usually compiled with the necessary
other libraries such as zlib to decompress headers.

And then invoke stap like this:

```
$ /opt/stap/bin/stap -V
Systemtap translator/driver (version 2.6/0.161, non-git sources)
Copyright (C) 2005-2014 Red Hat, Inc. and others
This is free software; see the source for copying conditions.
enabled features: AVAHI LIBRPM LIBSQLITE3 NSS BOOST_SHARED_PTR TR1_UNORDERED_MAP NLS LIBXML2
```

Or you can just add the `/opt/stap/bin` path to your `PATH` environment.
