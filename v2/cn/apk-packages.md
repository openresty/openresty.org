<!---
    @title         OpenResty Alpine APK 安装包
--->

OpenResty 官方 [APK 包仓库](linux-packages.html)提供下面的 apk 包 (适用于 Alpine 系统)。

# openresty

这是用于核心 OpenResty 服务的生产版本。

这个包注册在 `/usr/bin/openresty`, 它是 OpenResty 的 `nginx` 可执行文件 `/usr/local/openresty/nginx/sbin/nginx` 的符号链接。 默认的，你应该能在你的 `PATH` 环境变量中看到 `openresty` 命令。当你想调用这个包提供的 nginx 可执行文件时，记得总是用 `openresty` 而不是 `nginx`。 `nginx` 默认并不在你的 `PATH` 环境变量中，这是为了避免和同一个系统中其他 NGINX 包发生冲突。

你可以使用这个命令来启动默认的 OpenResty 服务

```
sudo rc-service openresty start
```

`stop`、`reload`、`upgrade`、`reopen` 和 `checkconfig` 这些指令也是支持的。

默认的服务前缀是 `/usr/local/openresty/`。对于你自己的 OpenResty 应用，强烈推荐指定你自己的前缀，并指向你自己应用的目录，像这样：

```
sudo openresty -p /opt/my-fancy-app/
```

然后在 `/opt/my-fancy-app/` 目录下会有一些 `conf/`, `html/` 和 `logs/` 这样的子目录。
用这种方法，我们可以避免污染 `/usr/local/openresty/` 下的 OpenResty 安装目录树，并且允许多个不同的 OpenResty 应用共享同一个 OpenResty 服务程序。但是你需要为每一个自己的 OpenResty 应用写一份启动脚本。你可以使用默认的 `/etc/init.d/openresty` 和 `/etc/conf.d/openresty` 启动脚本作为参考模板。

我们使用了我们自己的 OpenSSL（通过 `openresty-openssl` 包）、PCRE、zlib 和 LuaJIT 版本，来保证这些关键组件是最新的并且可以一起工作。

# openresty-resty

这个包里面有 `resty` 命令行程序，它可以在你的 `PATH` 环境变量（做为 `/usr/bin/resty`）中看到。你可以这样尝试用下

```console
$ resty -e 'ngx.say("hello")'
hello
```

这个包依赖标准 `perl` 包以及我们的 `openresty` 包才能正常工作。

你可以从 [resty-cli](https://github.com/openresty/resty-cli) 这个项目得到更多细节。

# openresty-restydoc

这个包包含 OpenResty 文档工具链和文档数据。最有用的工具是 `restydoc` 命令行程序，默认应该能在你的 `PATH` 环境变量（做为 `/usr/bin/restydoc`）里面看到。

这样尝试:

```bash
restydoc ngx_lua

restydoc -s content_by_lua

restydoc -s proxy_pass
```

可以从 `restydoc -h` 命令的输出中看到更多使用的细节。

为了达到最佳结果，请确保你的 terminal 使用的是 UTF-8 字符编码，并且安装的 `perl` 和 `groff` 是比较新的版本。否则那些非 ASCII 的字符可能显示不正常。

# openresty-debug

这个是 OpenResty 的正常调试版本。和 `openresty` 包比起来，它有以下不同：

* 这个版本禁止了 C 编译器的各种优化。
* 它打开了 NGINX 调试日志功能。
* 除了 NGINX 中默认的 epoll 模块，它额外开启了 poll 模块，以便能用上 [mockeagain](https://github.com/openresty/mockeagain) 这个测试工具。
* 对于 OpenSSL 库，它使用 `openresty-openssl-debug` 包替代了 `openresty-openssl`。
* 它在 LuaJIT 版本中打开了 API 检查和断言。
* 在 `ngx_http_lua` 模块中打开了断言。
* 它让 `ngx_http_lua` 模块在 LuaJIT 自己的垃圾回收管理内存分配失败时，立即退出当前的 nginx 工作进程（默认行为是记录错误信息并优雅退出当前工作进程）。
* NGINX 默认的服务前缀是 `/usr/local/openresty-debug/`。
* 你在 `PATH` 环境变量里面看到的入口点是 `openresty-debug` 而不是 `openresty`。
* 它没有带启动脚本。

你永远都不应该在生产环境上使用这个包。这个包是仅供开发使用。

# openresty-valgrind

这是 OpenResty 的一个特别调试版本，为了配合 Valgrind 工具链。Valgrind 是一个检测各种内存问题的强大工具，比如内存泄露和内存非法访问。为了用 Valgrind 最大限度的捕获到内存 bug，这个版本在 `openresty-debug` 基础上增加了如下操作：

* 它打上了 "[no-pool](https://github.com/openresty/no-pool-nginx)" 的补丁，禁止 NGINX 中内存池的使用。
* 它强制 LuaJIT 使用系统分配内存而不是 LuaJIT 自己分配。
* 在 LuaJIT 版本中打开内部 Valgrind 协作。
* NGINX 默认的服务前缀是 `/usr/local/openresty-valgrind/`。
* 你在 `PATH` 环境变量里面看到的入口点是 `openresty-valgrind` 而不是 `openresty-debug`。

想了解更多在 OpenResty 中基于 Valgrind 的测试细节，可以看下面的教程:

https://openresty.gitbooks.io/programming-openresty/content/testing/test-modes.html#_valgrind_mode

# openresty-openssl

这是我们自己维护的 OpenSSL 库。特别的，我们为了节省一些开销，在这个版本中已经禁用了对多线程的支持。

# openresty-openssl-debug

这是 OpenSSL 库的调试版本。和 `openresty-openssl` 相比，有这些不同：

* 禁止了所有 C 编译器优化。
* 它没有 Valgrind 错误也没有任何 Valgrind 误报。
* 汇编代码被禁止，所以我们总是有完美的基于 C 的回溯以及类似的。

# perl-lemplate

这个包提供了 [lemplate](https://metacpan.org/pod/Lemplate) 这个命令行程序，它可以把使用 perl TT2 模板语言语法的模板文件编译成 OpenResty 的独立 Lua 模块。

比如 OpenResty 的官方网站，`openresty.org`，就[使用](https://github.com/openresty/openresty.org) Lemplate 作为 HTML 页面的模板编译器。

# perl-test-nginx

这是我们的测试框架 [Test::Nginx](https://github.com/openresty/test-nginx)。从下面章节中可以看到对这个测试框架的一个完整介绍:

https://openresty.gitbooks.io/programming-openresty/content/testing/

由于 Alpine 官方的 community 仓库已经提供了这个包，我们就不自己打包了。

# 调试符号包

我们为那些包含二进制组件的包，比如 `openresty` 和 `openresty-openssl` 提供调试符号包。
调试符号包和其他标准的 APK 包一样，只是包名加了 `-dbg` 的后缀。比如 `openresty` 的调试符号是 `openresty-dbg`。

# 打包源码

build 这些包的源文件都放在 `openresty-packaging` GitHub 仓库中:

https://github.com/openresty/openresty-packaging/tree/master/alpine/

# 更多

查看 [Linux Packages](linux-packages.html) 页面获取更多关于我们官方 OpenResty 包仓库的信息。
