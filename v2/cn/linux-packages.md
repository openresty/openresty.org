<!---
    @title         Linux Packages
--->

对于下列 Linux 发行系统和版本，OpenResty 提供官方预编译包。

* RHEL/CentOS

```
    Version         Supported Architectures
    5.x             x86_64, i386
    6.x             x86_64, i386
    7.x             x86_64
```

* Fedora

```
    Version         Supported Architectures
    22              x86_64, i386
    23              x86_64, i386
    24              x86_64, i386
```

# RHEL/CentOS

你可以在你的 RHEL 或者 CentOS 系统中添加 `openresty` 资源库，这样就可以方便的安装我们的包，以后也可以更新（通过 `yum update` 命令）。添加资源库，你只用创建一个名为 `/etc/yum.repos.d/OpenResty.repo` 的文件，内容如下:

```ini
[openresty]
name=Official OpenResty Repository
baseurl=https://copr-be.cloud.fedoraproject.org/results/openresty/openresty/epel-$releasever-$basearch/
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://copr-be.cloud.fedoraproject.org/results/openresty/openresty/pubkey.gpg
enabled=1
enabled_metadata=1
```

列出 `openresty` 资源库里面所有的包:

```bash
sudo yum --disablerepo="*" --enablerepo="openresty" list available
```

然后你可以安装一个包，比如安装 `openresty`, 像这样:

```bash
sudo yum install openresty
```

在 [OpenResty RPM 包](rpm-packages.html) 页面能看到这些包更多的细节。

# Fedora

在 Fedora 系统中你可以这样来启用 `openresty` 资源库:

```
sudo dnf install yum-plugin-copr
sudo dnf copr enable openresty/openresty
```

然后你就可以方便的从 `openresty-openresty` 资源库中安装和以后更新包(通过 `dnf update` 命令)。 比如我们可以运行下面的命令来安装 `openresty`:

```bash
sudo dnf install openresty
```

列出在 `openresty-openresty` 资源库中所有可用的包, 可以这样

```bash
sudo dnf repo-pkgs openresty-openresty list available
```

在 [OpenResty RPM 包](rpm-packages.html) 页面能看到这些包更多的细节。


# 更多精彩，未完待续

我们正在尽力为你带来更多 Linux 发行版本的包资源库，比如 Ubuntu, Debian 和 Amazon Linux. 敬请期待!
