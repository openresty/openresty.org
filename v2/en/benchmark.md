<!---
    @title         Benchmark
    @creator       Yichun Zhang
    @created       2011-06-21 05:50 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2012-04-19 02:12 GMT
    @changes       14
--->


# HelloWorld
Testing the performance of a HelloWorld server does not mean many things but
it does tell us where the ceiling is.

The HelloWorld server based on [OpenResty](openresty.html) is described in the
[GettingStarted](getting-started.html) document.

Below is the result using the command `http_load -p 10 -s 5 http://localhost:8080/` on
my ThinkPad T400 laptop with ngx_openresty 1.0.10.1:

```
139620 fetches, 10 max parallel, 1.67544e+06 bytes, in 5.00001 seconds
12 mean bytes/connection
27923.9 fetches/sec, 335087 bytes/sec
msecs/connect: 0.0531258 mean, 4.076 max, 0.014 min
msecs/first-response: 0.258796 mean, 5.353 max, 0.067 min
HTTP response codes:
  code 200 -- 139620
```


So on my laptop, for only a single worker nginx server, we've got ~28k r/s.
The memory footprint of the `node` process under load is 38.0m VIRT, 2.5m RES.

For comparison, HelloWorld servers using nginx + php-fpm 5.2.8 gives ~6k r/s:

```
http_load -p 10 -s 5 url
29703 fetches, 10 max parallel, 326733 bytes, in 5 seconds
11 mean bytes/connection
5940.6 fetches/sec, 65346.6 bytes/sec
msecs/connect: 0.0394686 mean, 1.172 max, 0.02 min
msecs/first-response: 1.62616 mean, 6.744 max, 0.719 min
HTTP response codes:
  code 200 -- 29703
```

And [node.js](http://nodejs.org/) v0.6.1 yields 10k r/s:

```
51206 fetches, 10 max parallel, 614472 bytes, in 5 seconds
12 mean bytes/connection
10241.2 fetches/sec, 122894 bytes/sec
msecs/connect: 0.0356567 mean, 1.316 max, 0.019 min
msecs/first-response: 0.916395 mean, 14.236 max, 0.077 min
HTTP response codes:
  code 200 -- 51206
```

The memory footprint of the `node` process under load is 629m  VIRT, 50m RES.


##  For Mac OS X Lion Users
Note that Mac OS X Lion has known issues that need to be fixed on your system
before attempting to replicate our benchmark results.

In brief, raise the number of  available ephemeral ports using [this fix](http://serverfault.com/questions/145907/does-mac-os-x-throttle-the-rate-of-socket-creation).

Compile an up-to-date version of ab (Apache's benchmark tool) according to [this post](http://superuser.com/questions/323840/apache-bench-test-erroron-os-x-apr-socket-recv-connection-reset-by-peer-54).

Then, `ab -k -c10 -n10000 -t1 -r 'http://127.0.0.1:8080/'` will deliver benchmark
results.

Otherwise use an alternative lightweight HTTP load-testing tool [weighttp](http://redmine.lighttpd.net/projects/weighttp/wiki) and
the invocation `weighttp -k -c10 -n10000 'http://127.0.0.1:8080/'` for benchmarking.
