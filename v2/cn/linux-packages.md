<!---
    @title         Linux 包
--->

对于下列 Linux 发行版的种类和版本号，OpenResty 提供官方的预编译包。

* RHEL/CentOS

```
    版本号          支持的体系结构
    5.x             x86_64, i386
    6.x             x86_64, i386
    7.x             x86_64
```

* Fedora

```
    版本号          支持的体系结构
    23              x86_64, i386
    24              x86_64, i386
    25              x86_64, i386
    rawhide         x86_64, i386
```

# CentOS

你可以在你的 CentOS 系统中添加 `openresty` 资源库，这样就可以方便的安装我们的包，以后也可以更新（通过 `yum update` 命令）。添加资源库，你只用创建一个名为 `/etc/yum.repos.d/OpenResty.repo` 的文件，内容如下:

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

你也可以直接运行 `sudo yum-config-manager --add-repo https://openresty.org/yum/centos/OpenResty.repo` 添加该文件。

中国大陆的用户可以把 `baseurl` 改成下面的链接，速度会更快。

```ini
baseurl=https://openresty.org/yum/openresty/openresty/epel-$releasever-$basearch/
```

或者运行 `sudo yum-config-manager --add-repo https://openresty.org/yum/cn/centos/OpenResty.repo` 添加对应的文件。

列出 `openresty` 资源库里面所有的包:

```bash
sudo yum --disablerepo="*" --enablerepo="openresty" list available
```

然后你可以安装一个包，比如安装 `openresty`, 像这样:

```bash
sudo yum install openresty
```

在 [OpenResty RPM 包](rpm-packages.html) 页面能看到这些包更多的细节。

# RHEL

你可以在你的 RHEL 系统中添加 `openresty` 资源库，这样就可以方便的安装我们的包，以后也可以更新（通过 `yum update` 命令）。添加资源库，你只用创建一个名为 `/etc/yum.repos.d/OpenResty.repo` 的文件，内容如下:

```ini
[openresty]
name=Official OpenResty Repository
baseurl=https://copr-be.cloud.fedoraproject.org/results/openresty/openresty/epel-RELEASE-$basearch/
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://copr-be.cloud.fedoraproject.org/results/openresty/openresty/pubkey.gpg
enabled=1
enabled_metadata=1
```

你需要将上面内容中的 `RELEASE` 替换为你的 RHEL 系统实际的大版本号，比如 `5`
、`6` 或者 `7`。

你也可以直接运行 `sudo yum-config-manager --add-repo https://openresty.org/yum/rhel-RELEASE/OpenResty.repo` 添加对应大版本号的文件。别忘了把 `RELEASE` 改成你的 RHEL 系统的大版本号。

中国大陆的用户可以把 `baseurl` 改成下面的链接，速度会更快。

```ini
baseurl=https://openresty.org/yum/openresty/openresty/epel-$releasever-$basearch/
```

或者运行 `sudo yum-config-manager --add-repo https://openresty.org/yum/cn/rhel-RELEASE/OpenResty.repo` 添加对应的文件。

在 [OpenResty RPM 包](rpm-packages.html) 页面能看到这些包更多的细节。

# Fedora

在 Fedora 系统中你可以这样来启用 `openresty` 资源库:

```
sudo dnf install 'dnf-command(copr)'
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


# 对更多 Linux 发行版的支持

我们欢迎社区贡献更多的 Linux 发行版的打包源。请确保新的安装包尽可能地接近我们现有的 [RPM 安装包](rpm-packages.html)。非常感谢！

# 非 Linux 系统的安装包

目前 OpenResty 也提供针对 Windows 系统的二进制安装包，可以从[下载页面](download.html)获取。
