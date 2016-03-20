Name
====

openresty.org - Code for the official site of OpenResty

Table of Contents
=================

* [Name](#name)
* [Description](#description)
* [Building](#building)
* [Credit](#credit)
* [Author](#author)
* [Copyright and License](#copyright-and-license)

Description
===========

This repository holds the source code and configurations for the official OpenResty site (https://openresty.org/).

This site is a dynamic web application built entirely upon the OpenResty stack, backed by the PostgreSQL database management system.

The latest generation of this site is under the `v2/` directory of this repository.

Building
========

You need to install both OpenResty and PostgreSQL 9.x, obviously.

You need to install `pandoc` to your system. On Mac OS X, for example, it's as simple as

```bash
brew install pandoc
```

You'll also need `perl` installed in your system for building the web site (not needed for serivce deployment though).

```bash
cd v2/
make gendata  # generate data files from .md files

# create the test database "openresty_org" and the test account "openresty" in your local PostgreSQL server.
# using commands in the initial comment lines of the init.sql file.

make initdb   # create the database and load the data files
make run      # starting the test nginx server listened on localhost:8080
make reload   # for reloading the test nginx server
```

If you want to re-generate the `openresty_org.templates` Lua module from the TT2 template files under `templates/`, then
you need to install the Lemplate CPAN module like this:

```bash
sudo cpan Lemplate
```

and then just run

```bash
make
```

The `.po` files under `po/` would be automatically updated according to the latest Lua source and TT2 template files
with this command as well. If you make any edits to the `.po` files, then remember to re-run the `make` command to
make your changes take effect (by updating the `openresty_org.i18n` Lua module file from the `.po` files).

Credit
======

* Thanks [Mashape.com](https://www.mashape.com) for contributing the page templates for the v2 version of this site.

[Back to TOC](#table-of-contents)

Author
======

Yichun Zhang (agentzh) &lt;agentzh@gmail.com&gt;

[Back to TOC](#table-of-contents)

Copyright and License
=====================

This module is licensed under the BSD license.

Copyright (C) 2011, 2012, 2013, 2014, 2015, 2016 by Yichun "agentzh" Zhang (章亦春) &lt;agentzh@gmail.com&gt;, CloudFlare Inc.

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

[Back to TOC](#table-of-contents)

