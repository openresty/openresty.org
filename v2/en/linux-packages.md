<!---
    @title         OpenResty® Linux Packages
--->

OpenResty<sup>&reg;</sup> provides official pre-built packages for the following Linux distributions and versions.

* Ubuntu

```
    Version         Codename        Supported Architectures
    14.04           Trusty          amd64
    16.04           Xenial          amd64
    18.04           Bionic          amd64
    18.10           Cosmic          amd64
    19.04           Disco           amd64
    19.10           Eoan            amd64
```

* Debian

```
    Version         Codename        Supported Architectures
    8.x             Jessie          amd64
    9.x             Stretch         amd64
    10.x            Buster          amd64
```

* CentOS

```
    Version         Supported Architectures
    6.x             x86_64
    7.x             x86_64, aarch64 (arm64)
    8.x             x86_64
```

* Red Hat Enterprise Linux (RHEL)

```
    Version         Supported Architectures
    6.x             x86_64
    7.x             x86_64
    8.x             x86_64
```

* Fedora

```
    Version         Supported Architectures
    28              x86_64
    29              x86_64
    30              x86_64
    31              x86_64
```

* Amazon Linux

```
    Version         Supported Architectures
    1 (2018.03)     x86_64
    2               x86_64
```

* OpenSUSE Leap

```
    Version         Supported Architectures
    15.1            x86_64
```

All our repositories' metadata (and rpm binary packages) are signed by the following GPG key, `0xD5EDEB74`:

https://openresty.org/package/pubkey.gpg

**IMPORTANT!** All the official binary packages for Intel `x86_64` CPUs require SSE 4.2 instruction support in the CPU.
If you use an old CPU that does not support SSE 4.2, then you need to build OpenResty from its source tarball on *that*
CPU yourself. See the [Download](download.html) and [Installation](installation.html) page for details. Otherwise you
will see the `Illegal instruction` error when using the binary packages on your CPUs lacking SSE 4.2 support.

# Ubuntu

Note: if nginx is already installed and running, try disabling and stopping it before installing openresty like below:

```bash
sudo systemctl disable nginx
sudo systemctl stop nginx
```

Otherwise the installation might fail.

You can add our APT repository to your Ubuntu system so as to easily install
our packages and receive updates in the future (via the `apt-get update` command). To add the repository, just
run the following commands (only need to run once for each system):

```bash
# install some prerequisites needed by adding GPG public keys (could be removed later)
sudo apt-get -y install --no-install-recommends wget gnupg ca-certificates

# import our GPG key:
wget -O - https://openresty.org/package/pubkey.gpg | sudo apt-key add -

# for installing the add-apt-repository command
# (you can remove this package and its dependencies later):
sudo apt-get -y install --no-install-recommends software-properties-common

# add the our official APT repository:
sudo add-apt-repository -y "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main"

# to update the APT index:
sudo apt-get update
```

Then you can install a package, say, `openresty`, like this:

```bash
sudo apt-get -y install openresty
```

This package also recommends the `openresty-opm` and `openresty-restydoc` packages so the latter two will
also automatically get installed by default. If that is not what you want, you can disable the automatic
installation of recommended packages like this:

```bash
sudo apt-get -y install --no-install-recommends openresty
```

See the [OpenResty Deb Packages](deb-packages.html) page for more details on all available packages in this
repository.

# Debian

Note: if nginx is already installed and running, try disabling and stopping it before installing openresty like below:

```bash
sudo systemctl disable nginx
sudo systemctl stop nginx
```

Otherwise the installation might fail.

You can add the `openresty` repository to your Debian system so as to easily install
our packages and receive updates in the future (via the `apt-get update` command). To add the repository, just
run the following commands (only need to run once for each system):

```bash
# install some prerequisites needed by adding GPG public keys (could be removed later)
sudo apt-get -y install --no-install-recommends wget gnupg ca-certificates

# import our GPG key:
wget -O - https://openresty.org/package/pubkey.gpg | sudo apt-key add -

# for installing the add-apt-repository command
# (you can remove this package and its dependencies later):
sudo apt-get -y install --no-install-recommends software-properties-common

# add the our official APT repository:
sudo add-apt-repository -y "deb http://openresty.org/package/debian $(lsb_release -sc) openresty"

# to update the APT index:
sudo apt-get update
```

Then you can install a package, say, `openresty`, like this:

```bash
sudo apt-get -y install openresty
```

This package also recommends the `openresty-opm` and `openresty-restydoc` packages so the latter two will
also automatically get installed by default. If that is not what you want, you can disable the automatic
installation of recommended packages like this:

```bash
sudo apt-get -y install --no-install-recommends openresty
```

See the [OpenResty Deb Packages](deb-packages.html) page for more details on all available packages in this
repository.

# CentOS

You can add the `openresty` repository to your CentOS system so as to easily install
our packages and receive updates in the future (via the `yum update` command). To add the repository, just
run the following commands:

```bash
sudo yum install yum-utils
sudo yum-config-manager --add-repo https://openresty.org/package/centos/openresty.repo
```

Then you can install a package, say, `openresty`, like this:

```bash
sudo yum install openresty
```

If you want to install the `resty` command-line utility, then install the `openresty-resty` package like below:

```bash
sudo yum install openresty-resty
```

The `opm` command-line utility is in the `openresty-opm` package while the `restydoc` utility is in the
`openresty-doc` package.

To list all the packages in the `openresty` repository:

```bash
sudo yum --disablerepo="*" --enablerepo="openresty" list available
```

See the [OpenResty RPM Packages](rpm-packages.html) page for more details on all these packages.

# RHEL

You can add the `openresty` repository to your Red Hat Enterprise Linux (RHEL) system so as to easily install
our packages and receive updates in the future (via the `yum update` command). To add the repository, just
run the following commands:

```bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://openresty.org/package/rhel/openresty.repo
```

On older systems like RHEL 6.x, the last command may yield the following error due to a problem in its
`yum-config-manager` command:

```
[Errno 14] Peer cert cannot be verified or peer cert invalid
```

If this error happens, then you can just use the following command instead to enable the repository:


```bash
sudo yum-config-manager --add-repo http://openresty.org/package/rhel/openresty.repo
```

After adding the package repository, you can now install a package, say, `openresty`, like this:

```bash
sudo yum install openresty
```

If you want to install the `resty` command-line utility, then install the `openresty-resty` package like below:

```bash
sudo yum install openresty-resty
```

The `opm` command-line utility is in the `openresty-opm` package while the `restydoc` utility is in the
`openresty-doc` package.

To list all the packages in the `openresty` repository:

```bash
sudo yum --disablerepo="*" --enablerepo="openresty" list available
```

Some packages in this repository, like `perl-Test-Nginx` and `perl-Lemplate` do require
some extra optional RHEL official repositories to be enabled.
On RHEL 7 and 6, you need to enable the "optional" rpm repository, for example, for RHEL 7:

```bash
sudo subscription-manager repos --enable rhel-7-server-optional-rpms
```

and for RHEL 6:

```bash
sudo subscription-manager repos --enable rhel-6-server-optional-rpms
```

And for RHEL 8, you need to enable the "CodeReady" Linux Builder repository like this:

```bash
sudo subscription-manager repos --enable codeready-builder-for-rhel-8-x86_64-rpms
```

See the [OpenResty RPM Packages](rpm-packages.html) page for more details on all these packages.

Please note that the `perl-Lemplate` RPM package is currently unvailable on RHEL 8 since its official repositories
removes some dependency Perl module packages like `perl-Template-Toolkit` (as compared to RHEL 7).

# Fedora

You can enable the `openresty` repository on your Fedora system like this:

```bash
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://openresty.org/package/fedora/openresty.repo
```

Then you can easily install packages from the `openresty-openresty` repository and receive updates
in the future (through the `dnf check-update` command). For example, to install the `openresty` package, we can just run the
following command:

```bash
sudo dnf install -y openresty
```

If you want to install the `resty` command-line utility, then install the `openresty-resty` package like below:

```bash
sudo dnf install -y openresty-resty
```

The `opm` command-line utility is in the `openresty-opm` package while the `restydoc` utility is in the
`openresty-doc` package.

To list all the available packages in the `openresty-openresty` repository, just type

```bash
sudo dnf repo-pkgs openresty list available
```

See the [OpenResty RPM Packages](rpm-packages.html) page for more details on these packages.

# Amazon Linux

You can enable the `openresty` repository on your Amazon Linux system like this:

```bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://openresty.org/package/amazon/openresty.repo
```

Then you can install a package, say, `openresty`, like this:

```bash
sudo yum install -y openresty
```

If you want to install the `resty` command-line utility, then install the `openresty-resty` package like below:

```bash
sudo yum install -y openresty-resty
```

The `opm` command-line utility is in the `openresty-opm` package while the `restydoc` utility is in the
`openresty-doc` package.

To list all the packages in the `openresty` repository:

```bash
sudo yum --disablerepo="*" --enablerepo="openresty" list available
```

See the [OpenResty RPM Packages](rpm-packages.html) page for more details on all these packages.

Please note that the `*-asan` RPM packages are currently unavailable for Amazon Linux 2 due to a bug in Amazon Linux's
official clang packages (missing the `libclang_rt.a` library file).

# OpenSUSE Leap

You can enable the `openresty` repository on your OpenSUSE Leap system like below:

```bash
sudo zypper ar -g --refresh --check https://openresty.org/package/opensuse/openresty.repo
```

Then you can install a package, say, `openresty`, like this:

```bash
sudo zypper install -y openresty
```

If you want to install the `resty` command-line utility, then install the `openresty-resty` package like below:

```bash
sudo zypper install -y openresty-resty
```

The `opm` command-line utility is in the `openresty-opm` package while the `restydoc` utility is in the
`openresty-doc` package.

To list all the packages in the `openresty` repository:

```bash
sudo zypper pa -r openresty
```

Note that we currently do not provide separate `*-debuginfo` packages in this repository for OpenSUSE Leap. Instead, the
binaries directly contain the DWARF symbols and are not stripped.

See the [OpenResty RPM Packages](rpm-packages.html) page for more details on all these packages.

# Support for More Linux Distributions

We welcome community contributions of packaging sources targeting more Linux distributions like Gentoo, SLES, Arch, Slackware, and Oracle Linux.
Please ensure the resulting packages resemble our existing [RPM Packages](rpm-packages.html)
wherever possible. Thank you!

# Packages for Non-Linux systems

We also provide pre-built binary packages for the Windows operating system. You can obtain it from the [Download](download.html) page.
