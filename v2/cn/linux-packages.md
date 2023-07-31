<!---
    @title         OpenResty® Linux 包
--->

对于下列 Linux 发行版的种类和版本号，OpenResty<sup>&reg;</sup> 提供官方的预编译包。

* [Ubuntu](#ubuntu)

```
    版本            版本名         支持的体系结构
    14.04           Trusty          amd64
    16.04           Xenial          amd64, arm64
    18.04           Bionic          amd64, arm64
    20.04           Focal           amd64, arm64
    22.04           Jammy           amd64, arm64
```

* [Debian](#debian)

```
    版本           版本名        支持的体系结构
    9.x             Stretch         amd64, arm64
    10.x            Buster          amd64, arm64
    11.x            Bullseye        amd64, arm64
```

* [CentOS](#centos)

```
    版本号         支持的体系结构
    6.x             x86_64
    7.x             x86_64, aarch64
    8.x             x86_64, aarch64
    9.x             x86_64, aarch64
```

* [Red Hat 企业版 Linux (RHEL)](#rhel)

```
    版本号          支持的体系结构
    6.x             x86_64
    7.x             x86_64, aarch64
    8.x             x86_64, aarch64
    9.x             x86_64, aarch64
```

* [Fedora](#fedora)

```
    版本号          支持的体系结构
    32              x86_64, aarch64
    33              x86_64, aarch64
    34              x86_64, aarch64
    35              x86_64, aarch64
    36              x86_64, aarch64
```

* [Amazon Linux](#amazon-linux)

```
    版本号         支持的体系结构
    1 (2018.03)    x86_64
    2              x86_64, aarch64
```

* [Alibaba Cloud Linux](#alibaba-cloud-linux)

```
    版本号         支持的体系结构
    2              x86_64, aarch64
    3              x86_64, aarch64
```

* [TencentOS Linux](#tencentos-linux)

```
    版本号         支持的体系结构
    2              x86_64, aarch64
    3              x86_64, aarch64
```

* [Rocky Linux](#rocky-linux)

```
    版本号         支持的体系结构
    8.x            x86_64, aarch64
    9.x            x86_64, aarch64
```

* [Oracle Linux](#oracle-linux)

```
    版本号         支持的体系结构
    6.x            x86_64
    7.x            x86_64, aarch64
    8.x            x86_64, aarch64
```

* [SUSE Linux Enterprise](#suse-linux-enterprise)

```
    版本号          支持的体系结构
    12.x            x86_64
    15.x            x86_64, aarch64
```

* [OpenSUSE Leap](#opensuse-leap)

```
    版本号          支持的体系结构
    15.x            x86_64, aarch64
```

* [Alpine](#alpine)

```
    版本号          支持的体系结构
    3.7             x86_64, aarch64
    3.8             x86_64, aarch64
    3.9             x86_64, aarch64
    3.10            x86_64, aarch64
    3.11            x86_64, aarch64
    3.12            x86_64, aarch64
    3.13            x86_64, aarch64
    3.14            x86_64, aarch64
    3.15            x86_64, aarch64
```

* [CBL-Mariner](#cbl-mariner)

```
    版本号          支持的体系结构
    2.0             x86_64
```

我们仓库的所有元数据（以及 rpm 二进制包）都是用下面的 GPG 密钥， `0xD5EDEB74` 签名的：

https://openresty.org/package/pubkey.gpg

# Ubuntu

你可以在你的 Ubuntu 系统中添加我们的 APT 仓库，这样就可以便于未来安装或更新我们的软件包（通过 `apt-get update` 命令）。
运行下面的命令就可以添加仓库（每个系统只需要运行一次）：

步骤一：安装导入 GPG 公钥时所需的几个依赖包（整个安装过程完成后可以随时删除它们）：

```bash
sudo apt-get -y install --no-install-recommends wget gnupg ca-certificates
```

步骤二：导入我们的 GPG 密钥：

  - ubuntu 16 ~ 20 版本
```bash
wget -O - https://openresty.org/package/pubkey.gpg | sudo apt-key add -
```
  - ubuntu 22 及以上版本
```
wget -O - https://openresty.org/package/pubkey.gpg | sudo gpg --dearmor -o /usr/share/keyrings/openresty.gpg
```

步骤三：添加我们官方 APT 仓库。

对于 `x86_64` 或 `amd64` 系统，可以使用下面的命令：

  - ubuntu 16 ~ 20 版本
```bash
echo "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main" \
    | sudo tee /etc/apt/sources.list.d/openresty.list
```

  - ubuntu 22 及以上版本
```bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/openresty.gpg] http://openresty.org/package/ubuntu $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/openresty.list > /dev/null
```

而对于 `arm64` 或 `aarch64` 系统，则可以使用下面的命令:

  - ubuntu 16 ~ 20 版本
```bash
echo "deb http://openresty.org/package/arm64/ubuntu $(lsb_release -sc) main" \
    | sudo tee /etc/apt/sources.list.d/openresty.list
```

  - ubuntu 22 及以上版本
```bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/openresty.gpg] http://openresty.org/package/arm64/ubuntu $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/openresty.list > /dev/null
```

步骤四：更新 APT 索引：

```bash
sudo apt-get update
```

然后就可以像下面这样安装软件包，比如 `openresty`：

```bash
sudo apt-get -y install openresty
```

这个包同时也推荐安装 `openresty-opm` 和 `openresty-restydoc` 包，所以后面两个包会缺省安装上。
如果你不想自动关联安装，可以用下面方法关闭自动关联安装：

```bash
sudo apt-get -y install --no-install-recommends openresty
```

参阅 [OpenResty Deb 包](deb-packages.html) 页面获取这个仓库里头更多可用包的信息。

# Debian

你可以在你的 Debian 系统中添加 `openresty` 仓库，这样就可以便于未来安装或更新我们的软件包（通过 `apt-get update` 命令）。
运行下面的命令就可以添加我们的仓库（每个系统只需要运行一次）：

步骤一：安装导入 GPG 公钥时所需的几个依赖包（整个安装过程完成后可以随时删除它们）：

```bash
sudo apt-get -y install --no-install-recommends wget gnupg ca-certificates

步骤二：导入我们的 GPG 密钥：

```bash
wget -O - https://openresty.org/package/pubkey.gpg | sudo apt-key add -
```

步骤三：添加我们官方 APT 仓库。

对于 `x86_64` 或 `amd64` 系统，可以使用下面的命令：

```bash
codename=`grep -Po 'VERSION="[0-9]+ \(\K[^)]+' /etc/os-release`

echo "deb http://openresty.org/package/debian $codename openresty" \
    | sudo tee /etc/apt/sources.list.d/openresty.list
```

而对于 `arm64` 或 `aarch64` 系统，则可以使用下面的命令:

```bash
codename=`grep -Po 'VERSION="[0-9]+ \(\K[^)]+' /etc/os-release`

echo "deb http://openresty.org/package/arm64/debian $codename openresty" \
    | sudo tee /etc/apt/sources.list.d/openresty.list
```

步骤四：更新 APT 索引：

```bash
sudo apt-get update
```

然后就可以像下面这样安装软件包，比如 `openresty`：

```bash
sudo apt-get -y install openresty
```

这个包同时也推荐安装 `openresty-opm` 和 `openresty-restydoc` 包，所以后面两个包会缺省安装上。
如果你不想自动关联安装，可以用下面方法关闭自动关联安装：

```bash
sudo apt-get -y install --no-install-recommends openresty
```

参阅 [OpenResty Deb 包](deb-packages.html) 页面获取这个仓库里头更多可用包的信息。

# CentOS

你可以在你的 CentOS 系统中添加 `openresty` 仓库，这样就可以便于未来安装或更新我们的软件包（通过 `yum check-update` 命令）。
运行下面的命令就可以添加我们的仓库（对于 CentOS 8 或以上版本，应将下面的 `yum` 都替换成 `dnf`）：

## CentOS 8 或者更老版本

```bash
# add the yum repo:
wget https://openresty.org/package/centos/openresty.repo
sudo mv openresty.repo /etc/yum.repos.d/openresty.repo

# update the yum index:
sudo yum check-update
```

## CentOS 9 或者更新版本

```bash
# add the yum repo:
wget https://openresty.org/package/centos/openresty2.repo
sudo mv openresty2.repo /etc/yum.repos.d/openresty.repo

# update the yum index:
sudo yum check-update
```

然后就可以像下面这样安装软件包，比如 `openresty`：

```bash
sudo yum install -y openresty
```

如果你想安装命令行工具 `resty`，那么可以像下面这样安装 `openresty-resty` 包：

```bash
sudo yum install -y openresty-resty
```

命令行工具 `opm` 在 `openresty-opm` 包里，而 `restydoc` 工具在
`openresty-doc` 包里头。

列出所有 `openresty` 仓库里头的软件包：

```bash
sudo yum --disablerepo="*" --enablerepo="openresty" list available
```

参考 [OpenResty RPM 包](rpm-packages.html)页面获取这些包更多的细节。

对于 CentOS 8 及更新版本，我们只需要将上面的 `yum` 命令都替换成 `dnf` 即可。

# RHEL

你可以在你的 RHEL 系统中添加 `openresty` 仓库，这样就可以便于未来安装或更新我们的软件包（通过 `yum check-update` 命令）。添加仓库，运行下面的命令（对于 RHEL 8 或以上版本，应将下面的 `yum` 都替换成 `dnf`）：

## RHEL 8 或者更老的版本

```bash
# add the yum repo:
wget https://openresty.org/package/rhel/openresty.repo
sudo mv openresty.repo /etc/yum.repos.d/openresty.repo

# update the yum index:
sudo yum check-update
```

## RHEL 9 或者更新的版本

```bash
# add the yum repo:
wget https://openresty.org/package/rhel/openresty2.repo
sudo mv openresty2.repo /etc/yum.repos.d/openresty.repo

# update the yum index:
sudo yum check-update
```

添加了包仓库之后就可以像下面这样安装软件包，比如 `openresty`：

```bash
sudo yum install -y openresty
```

如果你想安装命令行工具 `resty`，那么可以像下面这样安装 `openresty-resty` 包：

```bash
sudo yum install -y openresty-resty
```

命令行工具 `opm` 在 `openresty-opm` 包里，而 `restydoc` 工具在
`openresty-doc` 包里头。

列出所有 `openresty` 仓库里头的软件包：

```bash
sudo yum --disablerepo="*" --enablerepo="openresty" list available
```

我们的包仓库中有某些包，比如 `perl-Test-Nginx` 和 `perl-Lemplate`，依赖开启一些可选的 RHEL 标准包仓库。比如
在 RHEL 6 和 RHEL 7 上，需要启用 RHEL 官方的 Optional RPM 包仓库。在 RHEL 7 上可以运行这条命令：

```bash
sudo subscription-manager repos --enable rhel-7-server-optional-rpms
```

在 RHEL 6 上则是这样的：

```bash
sudo subscription-manager repos --enable rhel-6-server-optional-rpms
```

而在 RHEL 8 上则需要开启 RHEL 官方的 CodeReady 仓库：

```bash
sudo subscription-manager repos --enable codeready-builder-for-rhel-8-x86_64-rpms
```

在 [OpenResty RPM 包](rpm-packages.html) 页面能看到这些包更多的细节。

请注意在 RHEL 8 上面缺少 `perl-Lemplate` 这个 RPM 包，这是因为 RHEL 8 相比 RHEL 7 从其标准仓库中移除了 `perl-Template-Toolkit`
这样的 Perl 模块包。

对于 RHEL 8 及更新版本，我们只需要将上面的 `yum` 命令都替换成 `dnf` 即可。

# Fedora

在 Fedora 系统中你可以这样来启用 `openresty` 仓库:

```bash
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://openresty.org/package/fedora/openresty.repo
```

然后你就可以方便的从 `openresty-openresty` 仓库中安装和更新包(通过 `dnf update` 命令)。 比如我们可以运行下面的命令来安装 `openresty`:

```bash
sudo dnf install -y openresty
```

如果想安装 `resty` 命令行工具，则像下面这样安装 `openresty-resty` 软件包：

```bash
sudo dnf install -y openresty-resty
```

命令行工具 `opm` 在 `openresty-opm` 包里，而 `restydoc` 工具在
`openresty-doc` 包里头。

列出在 `openresty-openresty` 仓库中所有可用的包, 可以这样

```bash
sudo dnf repo-pkgs openresty-openresty list available
```

在 [OpenResty RPM 包](rpm-packages.html) 页面能看到这些包更多的细节。

# Amazon Linux

你可以在你的 Amazon Linux （亚马逊 Linux）系统里用下面命令添加 `openresty` 仓库：

```bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://openresty.org/package/amazon/openresty.repo
```

然后你就可以像下面这样安装包了，比如说安装 `openresty`：

```bash
sudo yum install -y openresty
```

如果想安装 `resty` 命令行工具，则像下面这样安装 `openresty-resty` 软件包：

```bash
sudo yum install -y openresty-resty
```

命令行工具 `opm` 在 `openresty-opm` 包里，而 `restydoc` 工具在
`openresty-doc` 包里头。

列出在 `openresty-openresty` 仓库中所有可用的包, 可以这样

```bash
sudo yum repo-pkgs openresty-openresty list available
```

在 [OpenResty RPM 包](rpm-packages.html) 页面能看到这些包更多的细节。

请注意在 Amazon Linux 2 系统上缺少那些 `*-asan` RPM 包，因为 Amazon Linux 2 官方的 clang 包里缺少 `libclang_rt.a` 这个库文件）。

# Alibaba Cloud Linux

你可以在你的 Alibaba Cloud Linux （阿里云 Linux）系统里用下面命令添加 `openresty` 仓库：

```bash
# 新增仓库
wget https://openresty.org/package/alinux/openresty.repo
sudo mv openresty.repo /etc/yum.repos.d/

# 更新索引
sudo yum check-update
```

然后你就可以像下面这样安装包了，比如说安装 `openresty`：

```bash
sudo yum install -y openresty
```

如果想安装 `resty` 命令行工具，则像下面这样安装 `openresty-resty` 软件包：

```bash
sudo yum install -y openresty-resty
```

命令行工具 `opm` 在 `openresty-opm` 包里，而 `restydoc` 工具在
`openresty-doc` 包里头。

列出在 `openresty-openresty` 仓库中所有可用的包, 可以这样

```bash
sudo yum --disablerepo="*" --enablerepo="openresty" list
```

在 [OpenResty RPM 包](rpm-packages.html) 页面能看到这些包更多的细节。

# TencentOS Linux

你可以在你的 TencentOS Linux （腾讯云 Linux）系统里用下面命令添加 `openresty` 仓库：

```bash
# 新增仓库
wget https://openresty.org/package/tlinux/openresty.repo
sudo mv openresty.repo /etc/yum.repos.d/

# 更新索引
sudo yum check-update
```

然后你就可以像下面这样安装包了，比如说安装 `openresty`：

```bash
sudo yum install -y openresty
```

如果想安装 `resty` 命令行工具，则像下面这样安装 `openresty-resty` 软件包：

```bash
sudo yum install -y openresty-resty
```

命令行工具 `opm` 在 `openresty-opm` 包里，而 `restydoc` 工具在
`openresty-doc` 包里头。

列出在 `openresty-openresty` 仓库中所有可用的包, 可以这样

```bash
sudo yum --disablerepo="*" --enablerepo="openresty" list
```

在 [OpenResty RPM 包](rpm-packages.html) 页面能看到这些包更多的细节。

# Rocky Linux

你可以在你的 Rocky Linux 系统里用下面命令添加 `openresty` 仓库：

## Rocky 8

```bash
# add the repo:
repo=openresty.repo
wget https://openresty.org/package/rocky/openersty.repo
sudo mv openresty.repo /etc/yum.repos.d/openresty.repo

# update the index:
sudo yum check-update
```

## Rocky 9 或者更新版本

```bash
# add the repo:
wget https://openresty.org/package/rocky/openresty2.repo
sudo mv openresty2.repo /etc/yum.repos.d/openresty.repo

# update the index:
sudo yum check-update
```

然后你就可以像下面这样安装包了，比如说安装 `openresty`：

```bash
sudo yum install -y openresty
```

如果想安装 `resty` 命令行工具，则像下面这样安装 `openresty-resty` 软件包：

```bash
sudo yum install -y openresty-resty
```

命令行工具 `opm` 在 `openresty-opm` 包里，而 `restydoc` 工具在
`openresty-doc` 包里头。

列出在 `openresty-openresty` 仓库中所有可用的包, 可以这样

```bash
sudo yum --disablerepo="*" --enablerepo="openresty" list
```

在 [OpenResty RPM 包](rpm-packages.html) 页面能看到这些包更多的细节。

# Oracle Linux

你可以在你的 Oracle Linux 统里用下面命令添加 `openresty` 仓库：

```bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://openresty.org/package/oracle/openresty.repo
```

然后你就可以像下面这样安装包了，比如说安装 `openresty`：

```bash
sudo yum install -y openresty
```

如果想安装 `resty` 命令行工具，则像下面这样安装 `openresty-resty` 软件包：

```bash
sudo yum install -y openresty-resty
```

命令行工具 `opm` 在 `openresty-opm` 包里，而 `restydoc` 工具在
`openresty-doc` 包里头。

列出在 `openresty-openresty` 仓库中所有可用的包, 可以这样

```bash
sudo yum repo-pkgs openresty-openresty list
```

在 [OpenResty RPM 包](rpm-packages.html) 页面能看到这些包更多的细节。

# SUSE Linux Enterprise

你可以在你的 SUSE Linux Enterprise Server/Desktop/Workstation (SLES) 系统中如下所示启用 openresty 包仓库：

```bash
sudo rpm --import https://openresty.org/package/pubkey.gpg
sudo zypper ar -g --refresh --check "https://openresty.org/package/sles/openresty.repo"
sudo zypper mr --gpgcheck-allow-unsigned-repo openresty
```

然后你就可以像下面这样安装包了，比如说安装 `openresty`：

```bash
sudo zypper install -y openresty
```

如果想安装 `resty` 命令行工具，则像下面这样安装 `openresty-resty` 软件包：

```bash
sudo zypper install -y openresty-resty
```

命令行工具 `opm` 在 `openresty-opm` 包里，而 `restydoc` 工具在
`openresty-doc` 包里头。

列出在 `openresty-openresty` 仓库中所有可用的包, 可以这样

```bash
sudo zypper pa -r openresty
```

在 [OpenResty RPM 包](rpm-packages.html) 页面能看到这些包更多的细节。

# OpenSUSE Leap

你可以在你的 OpenSUSE Leap 系统中如下所示启用 openresty 包仓库：

```bash
sudo zypper ar -g --refresh --check https://openresty.org/package/opensuse/openresty.repo
```

接着导入我们的 PGP 公钥：

```bash
sudo zypper --gpg-auto-import-keys refresh
```

然后你就可以像下面这样安装包了，比如说安装 `openresty`：

```bash
sudo zypper install -y openresty
```

如果想安装 `resty` 命令行工具，则像下面这样安装 `openresty-resty` 软件包：

```bash
sudo zypper install -y openresty-resty
```

命令行工具 `opm` 在 `openresty-opm` 包里，而 `restydoc` 工具在
`openresty-doc` 包里头。

列出在 `openresty-openresty` 仓库中所有可用的包, 可以这样

```bash
sudo zypper pa -r openresty
```

在 [OpenResty RPM 包](rpm-packages.html) 页面能看到这些包更多的细节。

# Alpine

首先，请确保你本地已经启用了 Alpine 官方的 community 仓库。方法是，确保你本地的 `/etc/apk/repositories` 文件里的类似下面这一行没有被注释掉：

```
http://mirror.leaseweb.com/alpine/v3.11/community
```

你实际看到的行可能与上面这一行略有区别，当你使用了不同的源镜像网站或者不同的 Alpine 版本。

你可以通过下面的命令在你的 Alpine 系统上启用 `openresty` 仓库：

```bash
# first, let's add the public key used to sign the repo:
wget 'http://openresty.org/package/admin@openresty.com-5ea678a6.rsa.pub'
sudo mv 'admin@openresty.com-5ea678a6.rsa.pub' /etc/apk/keys/

# then, add the repo:
. /etc/os-release
MAJOR_VER=`echo $VERSION_ID | sed 's/\.[0-9]\+$//'`

echo "http://openresty.org/package/alpine/v$MAJOR_VER/main" \
    | sudo tee -a /etc/apk/repositories

# update the local index cache:
sudo apk update
```

然后你就可以像下面这样安装包了，比如说安装 `openresty`：

```bash
sudo apk add openresty
```

如果想安装 `resty` 命令行工具，则像下面这样安装 `openresty-resty` 软件包：

```bash
sudo apk add openresty-resty
```

命令行工具 `opm` 在 `openresty-opm` 包里，而 `restydoc` 工具在
`openresty-restydoc` 包里头。

列出在 `openresty` 仓库中所有可用的包, 可以这样做：

```bash
apk list | grep 'openresty\|lemplate'
```

在 [OpenResty Alpine APK 包](apk-packages.html) 页面能看到这些包更多的细节。

# CBL-Mariner

你可以在你的 CBL-Mariner 系统中添加 openresty 包仓库，如下所示：

```bash
# add the repo:
wget https://openresty.org/package/mariner/openresty.repo
sudo mv openresty.repo /etc/yum.repos.d/

# update the index:
sudo yum makecache
```

然后就可以像下面这样安装软件包，如安装 `openresty`:

```bash
sudo yum install -y openresty
```

如果你想安装命令行工具 `resty`，那么可以像下面这样安装 `openresty-resty` 包：

```bash
sudo yum install -y openresty-resty
```

命令行工具 `opm` 在 `openresty-opm` 包里，而 `restydoc` 工具在
`openresty-doc` 包里头。

列出所有 `openresty` 仓库里头的软件包：

```bash
sudo yum --disablerepo="*" --enablerepo="openresty" list
```

参考 [OpenResty RPM 包](rpm-packages.html)页面获取这些包更多的细节。

# 更多 Linux 发行版的支持

我们欢迎社区贡献更多的 Linux 发行版，比如 Gentoo, Arch, Slackware 的包仓库。请确保新的安装包尽可能地接近我们现有的 [RPM 安装包](rpm-packages.html)。非常感谢！

# 非 Linux 系统的安装包

目前 OpenResty 也提供针对 Windows 系统的二进制安装包，可以从[下载页面](download.html)获取。
