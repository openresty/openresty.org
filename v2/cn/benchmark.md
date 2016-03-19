<!---
    @title         Benchmark
    @creator       Yichun Zhang
    @created       2011-06-21 05:50 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-06-21 07:34 GMT
    @changes       5
--->


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
