<!---
    @title         Dynamic Routing Based On Redis
    @creator       Yichun Zhang
    @created       2011-07-27 04:02 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-09-14 10:16 GMT
    @changes       11
--->

This sample demonstrates how to use redis to route incoming requests to different
HTTP backends based on the requests' `User-Agent` header.

This demo uses the modules [Redis2 Nginx Module](redis-2-nginx-module.html),
[Lua Nginx Module](lua-nginx-module.html), [Lua Redis Parser Library](lua-redis-parser-library.html),
and [Set Misc Nginx Module](set-misc-nginx-module.html) bundled by [OpenResty](openresty.html):

Here's the complete code listing for our `nginx.conf`:


```
worker_processes  1;
error_log logs/error.log info;

events {
    worker_connections 1024;
}

http {
    upstream apache.org {
        server apache.org;
    }

    upstream nginx.org {
        server nginx.org;
    }

    server {
        listen 8080;

        location = /redis {
            internal;
            set_unescape_uri $key $arg_key;
            redis2_query get $key;
            redis2_pass 127.0.0.1:6379;
        }

        location / {
            set $target '';
            access_by_lua '
                local key = ngx.var.http_user_agent
                local res = ngx.location.capture(
                    "/redis", { args = { key = key } }
                )

                print("key: ", key)

                if res.status ~= 200 then
                    ngx.log(ngx.ERR, "redis server returned bad status: ",
                        res.status)
                    ngx.exit(res.status)
                end

                if not res.body then
                    ngx.log(ngx.ERR, "redis returned empty body")
                    ngx.exit(500)
                end

                local parser = require "redis.parser"
                local server, typ = parser.parse_reply(res.body)
                if typ ~= parser.BULK_REPLY or not server then
                    ngx.log(ngx.ERR, "bad redis response: ", res.body)
                    ngx.exit(500)
                end

                print("server: ", server)

                ngx.var.target = server
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
redis connections, as documented in [Redis2 Nginx Module](redis-2-nginx-module.html)'s
README.
