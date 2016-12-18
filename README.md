Name
====

OpenResty.org - Code and data for the official site of OpenResty

Table of Contents
=================

* [Name](#name)
* [Description](#description)
* [Building](#building)
* [TODO](#todo)
* [Credit](#credit)
* [Author](#author)
* [Copyright and License](#copyright-and-license)
* [See Also](#see-also)

Description
===========

This repository holds the source code and configurations for the [official OpenResty site](https://openresty.org/).

This site is a dynamic web application built entirely upon the OpenResty stack, backed by the [PostgreSQL](http://www.postgresql.org/)
database management system.

The latest generation of this site is under the `v2/` directory of this repository.

Building
========

You need to install both OpenResty and [PostgreSQL](http://www.postgresql.org/) 9.x, obviously.

You need to install [pandoc](http://pandoc.org/) to your system. On Mac OS X, for example, it's as simple as

```bash
brew install pandoc
```

You'll also need `perl` installed in your system for building the web site (not needed for serivce deployment though).

```bash
cd v2/

make gendata  # generate data files from .md files

# create the test database "openresty_org" and the test account "openresty" in your local PostgreSQL server.
# using commands in the initial comment lines of the init.sql file.
# for example:
psql -Upostgres    # or "psql postgres", depending on your Pg installation
# postgres=# create user openresty with password 'speedtheweb';
# postgres=# create database openresty_org;
# postgres=# grant all privileges on database openresty_org to openresty;

make initdb   # create the database and load the data files
make run      # starting the test nginx server listened on localhost:8080
make reload   # for reloading the test nginx server
```

If your machine has more than one spare CPU cores, then you can specify the `-jN` option of `make` to build the HTML
docs in parallel, as in

```bash
make gendata -j8
```

This command will run the build in 8 parallel jobs, thus utilizing 8 CPU cores at most.

If you want to re-generate the `openresty_org.templates` Lua module from the TT2 template files under `templates/`, then
you need to install the [Lemplate](https://metacpan.org/pod/Lemplate) CPAN module like this:

```bash
sudo cpan Lemplate
```

and then just run

```bash
make
```

The `.po` files under `po/` are for I18N (we need to support both the English and Chinese versions of this site, at least).
These files are similar to the `.po` files used by the classic [GNU gettext](https://www.gnu.org/software/gettext/) toolchain,
but we do not use `GNU gettext` at all.  Our `.po` files would be automatically updated according to the latest Lua source
and TT2 template files with this command as well. If you make any edits to the `.po` files, then remember to re-run the
`make` command to make your changes take effect (by updating the `openresty_org.i18n` Lua module file from the `.po` files).

TODO
====

* Add responsive design to the web page templates for mobile devices with small screens.
* Add a in-memory caching layer to the openresty_org web app via [lua-resty-lrucache](https://github.com/openresty/lua-resty-lrucache)
and/or [lua_shared_dict](https://github.com/openresty/lua-nginx-module#lua_shared_dict).
* Translate more English `.md` documents into Chinese.
* Add a pager to the search result page in the `openresty_org` web app.
* Add an RSS feed endpoint in the `openresty_org` web app.
* Add another tab page to the right-hand side-bar of the web pages featuring the top N hot pages.
* Add an OpenResty logo to the web page header.
* Remove the dependency on `pandoc` by migrating to a standalone Perl script.

[Back to TOC](#table-of-contents)

Credit
======

* Thanks [Mashape.com](https://www.mashape.com) for contributing the page templates for the v2 version of this site.
* Thanks leaf corcoran for contributing the [pgmoon library](https://github.com/leafo/pgmoon) for communicating
with PostgreSQL via cosockets.

[Back to TOC](#table-of-contents)

Author
======

Yichun Zhang (agentzh) &lt;agentzh@gmail.com&gt;

[Back to TOC](#table-of-contents)

Copyright and License
=====================

This module is licensed under the BSD license.

Copyright (C) 2011-2017 by Yichun "agentzh" Zhang (章亦春) &lt;agentzh@gmail.com&gt;, OpenResty Inc.

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

[Back to TOC](#table-of-contents)

See Also
========

* The [OpenResty Survey](https://github.com/agentzh/openresty-survey) web application.

[Back to TOC](#table-of-contents)

