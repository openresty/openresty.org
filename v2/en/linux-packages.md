<!---
    @title         Linux Packages
--->

OpenResty provides official pre-built packages for the following Linux distributions and versions.

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

# CentOS

You can add the `openresty` repository to your CentOS system so as to easily install
our packages and receive updates in the future (via the `yum update` command). To add the repository, just
create the file named `/etc/yum.repos.d/OpenResty.repo` with the following content:

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

To list all the packages in the `openresty` repository:

```bash
sudo yum --disablerepo="*" --enablerepo="openresty" list available
```

Then you can install a package, say, `openresty`, like this:

```bash
sudo yum install openresty
```

See the [OpenResty RPM Packages](rpm-packages.html) page for more details on these packages.

# RHEL

You can add the `openresty` repository to your RHEL system so as to easily install
our packages and receive updates in the future (via the `yum update` command). To add the repository, just
create the file named `/etc/yum.repos.d/OpenResty.repo` with the following content:

```ini
[openresty]
name=Official OpenResty Repository
baseurl=https://copr-be.cloud.fedoraproject.org/results/openresty/openresty/epel-RELEASE_VERSION-$basearch/
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://copr-be.cloud.fedoraproject.org/results/openresty/openresty/pubkey.gpg
enabled=1
enabled_metadata=1
```

You need to replace `RELEASE_VERSION` in the file content above with your RHEL system's major version number, like `5`, `6`, or `7`.

# Fedora

You can enable the `openresty` repository on your Fedora system like this:

```
sudo dnf install 'dnf-command(copr)'
sudo dnf copr enable openresty/openresty
```

Then you can easily install packages from the `openresty-openresty` repository and receive updates
in the future (through the `dnf update` command). For example, to install the `openresty` package, we can just run the
following command:

```bash
sudo dnf install openresty
```

To list all the available packages in the `openresty-openresty` repository, just type

```bash
sudo dnf repo-pkgs openresty-openresty list available
```

See the [OpenResty RPM Packages](rpm-packages.html) page for more details on these packages.

# More to come

We are still working hard on bringing package repositories for more Linux distributions like Ubuntu,
Debian, and Amazon Linux. Stay tuned!

# Packages for Non-Linux systems

We also provide pre-built binary packages for the Windows operating system. You can obtain it from the [Download](download.html) page.
