<!---
    @title         Routing MySQL Queries Based On URI Args
    @creator       Yichun Zhang
    @created       2011-11-16 04:06 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-11-16 04:22 GMT
    @changes       9
--->

This sample demonstrates how to route incoming requests to different MySQL queries
based on different combinations of URI query arguments, preserving streaming
output capabilities provided by [Drizzle Nginx Module](drizzle-nginx-module.html) and
[Rds Json Nginx Module](rds-json-nginx-module.html).

This demo uses the modules [Drizzle Nginx Module](drizzle-nginx-module.html),
[Lua Nginx Module](lua-nginx-module.html), [Rds Json Nginx Module](rds-json-nginx-module.html),
and [Set Misc Nginx Module](set-misc-nginx-module.html) bundled by [OpenResty](openresty.html).

Here's the complete code listing for our `nginx.conf`:


```
worker_processes  2;
error_log logs/error.log warn;

events {
    worker_connections 1024;
}

http {
    upstream backend {
        drizzle_server 127.0.0.1:3306 protocol=mysql
                       dbname=ngx_test user=ngx_test password=ngx_test;
        drizzle_keepalive max=10 overflow=ignore mode=single;
    }

    server {
        listen 8080;

        location @cats-by-name {
            set_unescape_uri $name $arg_name;
            set_quote_sql_str $name;
            drizzle_query 'select * from cats where name=$name';
            drizzle_pass backend;
            rds_json on;
        }

        location @cats-by-id {
            set_quote_sql_str $id $arg_id;
            drizzle_query 'select * from cats where id=$id';
            drizzle_pass backend;
            rds_json on;
        }

        location = /cats {
            access_by_lua '
                if ngx.var.arg_name then
                    return ngx.exec("@cats-by-name")
                end

                if ngx.var.arg_id then
                    return ngx.exec("@cats-by-id")
                end
            ';

            rds_json_ret 400 "expecting \"name\" or \"id\" query arguments";
        }
    }
}
```


And then we start our [Nginx](nginx.html) server with this configure file and
test with our `/cats` service like this:

```
$ curl 'localhost:8080/cats'
{"errcode":400,"errstr":"expecting \"name\" or \"id\" query arguments"}

$ curl 'localhost:8080/cats?name=bob'
[{"id":3,"name":"bob"}]

$ curl 'localhost:8080/cats?id=2'
[{"id":2,"name":null}]
```

The actual output rows may vary depending on the actual contents in your `cats` table
anyway.
