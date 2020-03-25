<!---
    @title         安装
    @creator       Yichun Zhang
    @created       2011-06-21 04:40 GMT
--->

***最新！*** [OpenResty 1.15.8.4](ann-1015008004.html) 正式版已发布。

***最新！*** [OpenResty 1.17.8.1 RC1](ann-1017008001rc1.html) 已经发布供测试。

***最新！*** 新博客文章[OpenResty 和 Nginx 如何分配和管理内存](https://blog.openresty.com.cn/cn/how-or-alloc-mem/) 已发布。

对于一些常见的 Linux 发行版本，OpenResty<sup>&reg;</sup> 提供 [官方预编译包](linux-packages.html)。确保你首先用这种方式来安装。

对于 Mac OS X 或 macOS 用户，强烈推荐您使用 [homebrew](https://brew.sh/) 包管理工具安装 OpenResty。可以直接使用下面
这一条命令：

```bash
brew install openresty/brew/openresty
```

如果你之前是从 `homebrew/nginx` 安装的 OpenResty，请先执行：

```bash
brew untap homebrew/nginx
```

如果您还没有下载 [OpenResty](openresty.html) 的源码包, 请到 [Download](download.html) 页下载。

首先，您可以根据下面的示例安装和构建[OpenResty](openresty.html)。

```bash
tar -xzvf openresty-VERSION.tar.gz
cd openresty-VERSION/
./configure
make
sudo make install
```

示例中的 `VERSION`替换成 [OpenResty](openresty.html)的版本号, 比如
`1.11.2.1`。
如果您在构建过程中需要对于细节更加灵活的控制，请您继续阅读。

# 安装前的准备

您必须将这些库 `perl 5.6.1+`, `libpcre`, `libssl`安装在您的电脑之中。
对于 Linux来说, 您需要确认使用 `ldconfig` 命令，让其在您的系统环境路径中能找到它们。

## Debian 和 Ubuntu 用户

推荐您使用 apt-get安装以下的开发库:

```bash
apt-get install libpcre3-dev \
    libssl-dev perl make build-essential curl
```

## Fedora 和 RedHat 用户

推荐您使用yum安装以下的开发库:

```bash
yum install pcre-devel openssl-devel gcc curl
```

## Mac OS X (macOS) 用户

对于 Mac OS X 或 macOS 用户，强烈推荐您使用 [homebrew](https://brew.sh/) 包管理工具安装 OpenResty。可以直接使用下面
这一条命令：

```bash
brew install openresty/brew/openresty
```

如果你之前是从 `homebrew/nginx` 安装的 OpenResty，请先执行：

```bash
brew untap homebrew/nginx
```

推荐您使用一些软件管理工具先安装PCRE, 比如说 [Homebrew](http://mxcl.github.com/homebrew/):

```bash
brew update
brew install pcre openssl
```

当然了，您也可以直接通过代码安装 PCRE 和 OpenSSL.

安装好 PCRE 和 OpenSSL 之后，可以使用下面的命令进行安装：

```bash
$ ./configure \
   --with-cc-opt="-I/usr/local/opt/openssl/include/ -I/usr/local/opt/pcre/include/" \
   --with-ld-opt="-L/usr/local/opt/openssl/lib/ -L/usr/local/opt/pcre/lib/" \
   -j8
```

假设 hombrew 把库都安装到 `/usr/local/opt/` 目录下面。

## FreeBSD 用户

您需要安装以下的工具:

* devel/gmake
* security/openssl
* devel/pcre

## Solaris 11 用户
您需要从官方的源中安装以下的工具:

* gcc-3
* SUNWlibm
通常情况下可以根据以下的示例安装：

```bash
pfexec pkg install gcc-3 SUNWlibm
```

# 构建 OpenResty

## 下载

从下载页 [Download](download.html)下载最新的 OpenResty<sup>&reg;</sup> 源码包，并且像下面的示例一样将其解压:

```bash
tar -xzvf openresty-VERSION.tar.gz
```

`VERSION` 的地方替换成您下载的源码包的版本号，比如说 `0.8.54.6`。

## ./configure

然后在进入 `openresty-VERSION/` 目录, 然后输入以下命令配置:

```bash
./configure
```

默认, `--prefix=/usr/local/openresty` 程序会被安装到/usr/local/openresty目录。

您可以指定各种选项，比如

```bash
./configure --prefix=/opt/openresty \
            --with-luajit \
            --without-http_redis2_module \
            --with-http_iconv_module \
            --with-http_postgres_module
```

试着使用 `./configure --help` 查看更多的选项。

配置文件（./configure script）运行出错可以到 `build/nginx-VERSION/objs/autoconf.err` 找到。
`VERSION` 的地方必须与[OpenResty](openresty.html)版本号相对应, 比如
`0.8.54.6`。

### Solaris的用户请注意：

对于 Solaris,安装开发库一般通过 OpenSSL 的形式插入 `/lib`, 因此当编译时出现
missing OpenSSL 说明您已经安装过了t, 特别是一些选项的时候
`--with-ld-opt='-L/lib'` 。

## make

您可以使用下面的命令来编译：

```bash
make
```

如果您的电脑支持多核 `make` 工作的特性, 您可以这样编译:

```bash
make -j2
```

假设您是的机器是双核。

## make install

如果前面的步骤都没有问题的话,您可以使用下面的命令安装
[OpenResty](openresty.html) 到您的系统中：

```bash
make install
```

在 Linux 上，通常需要使用 `sudo` 来获取 root 权限来完成安装。
