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

First of all, you need to install OpenResty to your system.
首先，你需要将 OpenResty 安装到你的系统。

If you are in Linux, please check out OpenResty's official pre-built packages if your Linux distribution is currently supported. If you use the official pre-built package, please replace the nginx command in this document below with the openresty command.
如果你使用的是 Linux 系统，请先用 OpenResty 的官方预装包，检查你的 Linux 发行版是否支持。如果你使用官方预装包，请在下面的文件里，将 Nginx 命令改为 OpenResty 命令。

Failing that, you can go to the Download page to get the source code tarball of OpenResty, and see the Installation page for how to build and install it into your system.
如果你的 Linux 系统不支持，你可以到下载页面，获取 OpenResty 的源代码tar压缩包，然后查看安装页面里关于如何安装的信息。


# HelloWorld

## Prepare directory layout
## 准备好目录

We first create a separate directory for our experiments. You can use an arbitrary
directory. Here for simplicity, we just use `~/work`:
首先，我们要新建一个单独的目录。你可以使用任何目录，简化起见，在这里我们使用 ~/work:

```
mkdir ~/work
cd ~/work
mkdir logs/ conf/
```

Note that we've also created the `logs/` directory for logging files and `conf/` for
our config files.
需要注意的是，我们还需要为日志文件建立 logs/ 目录，为配置文件建立 conf/ 目录。

## Prepare the nginx.conf config file
## 准备好 nginx.conf 配置文件

Create a simple plain text file named `conf/nginx.conf` with the following contents
in it:
新建一个空文本文档，命名为 conf/nginx.conf，并将下列内容写入文档：

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
如果你很了解 Nginx 的布局，上面的内容你会觉得很熟悉。OpenResty 只是一个借助于插件模块来实现的 Nginx 加强版。你可以利用 Nginx 世界里所有的好东西。

## Start the [Nginx](nginx.html) server
## 开始使用 Nginx 服务器

Assuming you have installed [OpenResty](openresty.html) into `/usr/local/openresty` (this
is the default), we make our `nginx` executable of our [OpenResty](openresty.html) installation
available in our `PATH` environment:
假如你已经将 OpenResty 安装到 /usr/local/openresty （这是默认值），那么 Nginx 就可以在 PATH 环境下的 OpenResty 配置里运行了：

```
PATH=/usr/local/openresty/nginx/sbin:$PATH
export PATH
```

Then we start the nginx server with our config file this way:
接下来，我们通过配置文件来使用 Nginx 服务器：

```
nginx -p `pwd`/ -c conf/nginx.conf
```

Error messages will go to the stderr device or the default error log files `logs/error.log` in
the current working directory.
报错信息会存入标准错误装置，或者存入正在运行的目录下的默认错误日志文件 logs/error.log。

## Access our HelloWorld web service
## 进入我们的 HelloWorld Web服务

We can use curl to access our new web service that says HelloWorld:
我们可以使用 curl 来获得新 Web服务 HelloWorld：

```
curl http://localhost:8080/
```

If everything is okay, we should get the output
如果全部运行正确，我们应该得到这样的结果：

```
<p>hello, world</p>
```

You can surely point your favorite web browser to the location `http://localhost:8080/`.
你当然还可以在你常用的网页浏览器，输入地址 http://localhost:8080/

## Test performance
## 测试执行效果

See [Benchmark](benchmark.html) for details.
进入性能测评页面获得更多细节。


# Where to go from here
# 接下来还可以做什么

View the documentation of each component at the [Components](components.html) page
and find [Nginx](nginx.html) related stuff on the [Nginx Wiki site](http://wiki.nginx.org/).
浏览组件页面里每个组件的文件，并找到 Nginx 维基页面上和 Nginx 相关的信息。
