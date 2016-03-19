<!---
    @title         Dynamic Routing Based On Redis
    @creator       Yichun Zhang
    @created       2011-07-27 04:02 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2014-03-04 22:19 GMT
    @changes       17
--->

This sample demonstrates how to use Redis to route incoming requests to different
HTTP backends based on the requests' `User-Agent` header.

This demo uses the components [Lua Nginx Module](lua-nginx-module.html) and
[Lua Resty Redis Library](lua-resty-redis-library.html) enabled by default in
[OpenResty](openresty.html).

Here's the complete code listing for our `nginx.conf`:


```
worker_processes  2;
error_log logs/error.log info;

events {
    worker_connections 1024;
}

http {
    server {
        listen 8080;

        location / {
            resolver 8.8.4.4;  # use Google's open DNS server

            set $target '';
            access_by_lua '
                local key = ngx.var.http_user_agent
                if not key then
                    ngx.log(ngx.ERR, "no user-agent found")
                    return ngx.exit(400)
                end

                local redis = require "resty.redis"
                local red = redis:new()

                red:set_timeout(1000) -- 1 second

                local ok, err = red:connect("127.0.0.1", 6379)
                if not ok then
                    ngx.log(ngx.ERR, "failed to connect to redis: ", err)
                    return ngx.exit(500)
                end

                local host, err = red:get(key)
                if not host then
                    ngx.log(ngx.ERR, "failed to get redis key: ", err)
                    return ngx.exit(500)
                end

                if host == ngx.null then
                    ngx.log(ngx.ERR, "no host found for key ", key)
                    return ngx.exit(400)
                end

                ngx.var.target = host
            ';

            proxy_pass http://$target;
        }
    }
}
```


And then let's start the redis server on the localhost:6379:

```
$ ./redis-server  # default port is 6379
```


and feed some keys into this using the redis-cli utility:

```
$ ./redis-cli
   redis> set foo apache.org
   OK
   redis> set bar nginx.org
   OK
```

And then let's test our nginx app!

```
$ curl --user-agent foo localhost:8080
   <apache.org home page goes here>

   $ curl --user-agent bar localhost:8080
   <nginx.org home page goes here>
```

To further tune the performance, one could enable the connection pool for the
redis connections, as documented in [Lua Resty Redis Library](lua-resty-redis-library.html)'s
README.

Before you benchmarking your interface defined here, please ensure that you've
raised the error log level to `warn` or `notice` in your `nginx.conf` file,
as in

```
error_log logs/error.log warn;
```

because flushing error log is a very expensive operation and can hurt performance
a lot.
