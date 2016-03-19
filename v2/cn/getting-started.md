<!---
    @title         Getting Started
    @creator       Yichun Zhang
    @created       2011-06-20 11:39 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-11-03 06:51 GMT
    @changes       29
--->

First of all, please go to the [Download](download.html) page to get the source
code tarball of [OpenResty](openresty.html), and see the [Installation](installation.html) page
for how to build and install it into your system.


# HelloWorld

## Prepare directory layout
We first create a separate directory for our experiments. You can use an arbitrary
directory. Here for simplicity, we just use `~/work`:

```
mkdir ~/work
cd ~/work
mkdir logs/ conf/
```

Note that we've also created the `logs/` directory for logging files and `conf/` for
our config files.

## Prepare the nginx.conf config file
Create a simple plain text file named `conf/nginx.conf` with the following contents
in it:

```
worker_processes  1;
error_log logs/error.log;
events {
    worker_connections 1024;
}
http {
    server {
        listen 8080;
        location / {
            default_type text/html;
            content_by_lua '
                ngx.say("<p>hello, world</p>")
            ';
        }
    }
}
```

If you're familiar with [Nginx](nginx.html) configuration, it should look very
familiar to you. [OpenResty](openresty.html) is just an enhanced version of
[Nginx](nginx.html) by means of addon modules anyway. You can take advantage
of all the exisitng goodies in the [Nginx](nginx.html) world.

## Start the [Nginx](nginx.html) server
Assuming you have installed [OpenResty](openresty.html) into `/usr/local/openresty` (this
is the default), we make our `nginx` executable of our [OpenResty](openresty.html) installation
available in our `PATH` environment:

```
PATH=/usr/local/openresty/nginx/sbin:$PATH
export PATH
```

Then we start the nginx server with our config file this way:

```
nginx -p `pwd`/ -c conf/nginx.conf
```

Error messages will go to the stderr device or the default error log files `logs/error.log` in
the current working directory.

## Access our HelloWorld web service
We can use curl to access our new web service that says HelloWorld:

```
curl http://localhost:8080/
```

If everything is okay, we should get the output

```
<p>hello, world</p>
```

You can surely point your favorite web browser to the location `http://localhost:8080/`.

## Test performance
See [Benchmark](benchmark.html) for details.


# Where to go from here

View the documentation of each component at the [Components](components.html) page
and find [Nginx](nginx.html) related stuffs on the [Nginx Wiki site](http://wiki.nginx.org/).
