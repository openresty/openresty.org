<!---
    @title         Benchmark
    @creator       Yichun Zhang
    @created       2011-06-21 05:50 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-06-21 07:34 GMT
    @changes       5
--->

<!---
This Benchmark page on Chinese website is different from the Benchmark page on English site.


# HelloWorld
Testing the performance of a HelloWorld server does not mean many things but
it does tell us where the ceiling is.


The HelloWorld server based on [OpenResty](openresty.html) is described in the
[GettingStarted](getting-started.html) document.


Below is the result using the command `ab -c10 -n50000 http://localhost:8080/` on
my ThinkPad T400 laptop with ngx_openresty 0.8.54.6:


```
Server Software:        ngx_openresty/0.8.54
Server Hostname:        localhost
Server Port:            8080

Document Path:          /
Document Length:        20 bytes

Concurrency Level:      10
Time taken for tests:   2.459 seconds
Complete requests:      50000
Failed requests:        0
Write errors:           0
Total transferred:      8550342 bytes
HTML transferred:       1000040 bytes
Requests per second:    20335.69 [#/sec] (mean)
Time per request:       0.492 [ms] (mean)
Time per request:       0.049 [ms] (mean, across all concurrent requests)
Transfer rate:          3396.04 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.1      0       8
Processing:     0    0   0.2      0       8
Waiting:        0    0   0.1      0       8
Total:          0    0   0.2      0       8

Percentage of the requests served within a certain time (ms)
  50%      0
  66%      0
  75%      0
  80%      0
  90%      1
  95%      1
  98%      1
  99%      1
 100%      8 (longest request)
```


So on my laptop, for a single nginx worker, we've got 20k+ r/s. For comparison,
HelloWorld servers using nginx + php-fpm 5.2.8 gives 4k r/s, Erlang R14B2 raw
gen_tcp server gives 8k r/s, and [[node.js|http://nodejs.org/] v0.4.8 yields 5.7k
r/s.

--->

<!---Below is the original benchmark page from English site.--->

# HelloWorld
Testing the performance of a HelloWorld server does not mean many things but
it does tell us where the ceiling is.
测试 HelloWorld 服务器运行效果的意义在于，让我们知道它的瓶颈所在。

The HelloWorld server based on [OpenResty](openresty.html) is described in the
[GettingStarted](getting-started.html) document.
基于 [OpenResty](openresty.html) 的 HelloWorld 服务器，在[新手上路](getting-started.html)页面中有介绍。

Below is the result using the command `http_load -p 10 -s 5 http://localhost:8080/` on
my ThinkPad T400 laptop with ngx_openresty 1.0.10.1:
在我的 ThinkPad T400 笔记本电脑上，用 `http_load -p 10 -s 5 http://localhost:8080/`压测 ngx_openresty 1.0.10.1，得到了如下测试结果：


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
在我的这个笔记本电脑上，单个 nginx worker 进程可以压到 ~28 r/s.
该负载下的 `worker` 进程内存占用是 38.0m VIRT, 2.5m RES。
For comparison, HelloWorld servers using nginx + php-fpm 5.2.8 gives ~6k r/s:
相比较而言，使用nginx + php-fpm 5.2.8，HelloWorld 服务器的测试结果是 ~6k r/s

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
使用 [node.js](http://nodejs.org/) v0.6.1，测试结果是 ~10k r/s：

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
该负载下的`node`进程内存占用是629m VIRT, 50m RES。

##  For Mac OS X Lion Users
##  写给 Mac OS X Lion 的用户

Note that Mac OS X Lion has known issues that need to be fixed on your system
before attempting to replicate our benchmark results.
需要注意的是，在你尝试重复我们的测试结果之前，Mac OS X Lion 有已知的问题需要你先修复。

In brief, raise the number of  available ephemeral ports using [this fix](http://serverfault.com/questions/145907/does-mac-os-x-throttle-the-rate-of-socket-creation).
简单来说，用 [本页信息](http://serverfault.com/questions/145907/does-mac-os-x-throttle-the-rate-of-socket-creation) 里的方法来增加可用的临时端口。

Compile an up-to-date version of ab (Apache's benchmark tool) according to [this post](http://superuser.com/questions/323840/apache-bench-test-erroron-os-x-apr-socket-recv-connection-reset-by-peer-54).
依据[本页信息](http://superuser.com/questions/323840/apache-bench-test-erroron-os-x-apr-socket-recv-connection-reset-by-peer-54)，使用最新版的 ab（Apache 的性能测试工具）来编译。

Then, `ab -k -c10 -n10000 -t1 -r 'http://127.0.0.1:8080/'` will deliver benchmark
results.
然后，使用命令`ab -k -c10 -n10000 -t1 -r 'http://127.0.0.1:8080/'`，你就会得到测试结果。

Otherwise use an alternative lightweight HTTP load-testing tool [weighttp](http://redmine.lighttpd.net/projects/weighttp/wiki) and
the invocation `weighttp -k -c10 -n10000 'http://127.0.0.1:8080/'` for benchmarking.
或者，使用其他的HTTP负载测试小工具 [weighttp](http://redmine.lighttpd.net/projects/weighttp/wiki)，并调用 `weighttp -k -c10 -n10000 'http://127.0.0.1:8080/'` 进行测试。
