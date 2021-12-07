<!---
    @title         OpenResty®  Linux Packages
--->

OpenResty<sup>&reg;</sup> provides official pre-built packages for the following Linux distributions and versions.

* [Ubuntu](#ubuntu)

```
    Version         Codename        Supported Architectures
    14.04           Trusty          amd64
    16.04           Xenial          amd64, arm64
    18.04           Bionic          amd64, arm64
    20.04           Focal           amd64, arm64
```

* [Debian](#debian)

```
    Version         Codename        Supported Architectures
    9.x             Stretch         amd64, arm64
    10.x            Buster          amd64, arm64
    11.x            Bullseye        amd64, arm64
```

* [CentOS](#centos)

```
    Version         Supported Architectures
    6.x             x86_64
    7.x             x86_64, aarch64
    8.x             x86_64, aarch64
```

* [Red Hat Enterprise Linux (RHEL)](#rhel)

```
    Version         Supported Architectures
    6.x             x86_64
    7.x             x86_64, aarch64
    8.x             x86_64, aarch64
```

* [Fedora](#fedora)

```
    Version         Supported Architectures
    32              x86_64, aarch64
    33              x86_64, aarch64
    34              x86_64, aarch64
    35              x86_64
```

* [Amazon Linux](#amazon-linux)

```
    Version         Supported Architectures
    1 (2018.03)     x86_64
    2               x86_64, aarch64
```

* [SUSE Linux Enterprise](#suse-linux-enterprise)

```
    Version         Supported Architectures
    12.x            x86_64
    15.x            x86_64, aarch64
```

* [OpenSUSE Leap](#opensuse-leap)

```
    Version         Supported Architectures
    15.x            x86_64, aarch64
```

* [Alpine](#alpine)

```
    Version         Supported Architectures
    3.7             x86_64, aarch64
    3.8             x86_64, aarch64
    3.9             x86_64, aarch64
    3.10            x86_64, aarch64
    3.11            x86_64, aarch64
    3.12            x86_64, aarch64
    3.13            x86_64, aarch64
    3.14            x86_64, aarch64
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

Step 1: we should install some prerequisites needed by adding GPG public keys (could be removed later):

```bash
sudo apt-get -y install --no-install-recommends wget gnupg ca-certificates
```

Step 2: import our GPG key:

```bash
wget -O - https://openresty.org/package/pubkey.gpg | sudo apt-key add -
```

Step 3: then add the our official APT repository.

For `x86_64` or `amd64` systems:

```bash
echo "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main" \
    | sudo tee /etc/apt/sources.list.d/openresty.list
```

And for `arm64` or `aarch64` systems:

```bash
echo "deb http://openresty.org/package/arm64/ubuntu $(lsb_release -sc) main" \
    | sudo tee /etc/apt/sources.list.d/openresty.list
```

Step 4: update the APT index:

```bash
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
our packages and receive updates in the future (via the `apt-get update` command).

To add the repository, just
run the following commands (only need to run once for each system):

Step 1: install some prerequisites needed by adding GPG public keys (could be removed later):

```bash
sudo apt-get -y install --no-install-recommends wget gnupg ca-certificates
```

Step 2: import our GPG key:

```bash
wget -O - https://openresty.org/package/pubkey.gpg | sudo apt-key add -
```

Step 3: add the our official APT repository.

For `x86_64` or `amd64` systems:

```bash
codename=`grep -Po 'VERSION="[0-9]+ \(\K[^)]+' /etc/os-release`

echo "deb http://openresty.org/package/debian $codename openresty" \
    | sudo tee /etc/apt/sources.list.d/openresty.list
```

And for `arm64` or `aarch64` systems:

```bash
codename=`grep -Po 'VERSION="[0-9]+ \(\K[^)]+' /etc/os-release`

echo "deb http://openresty.org/package/arm64/debian $codename openresty" \
    | sudo tee /etc/apt/sources.list.d/openresty.list
```

Step 4: update the APT index:

```bash
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
run the following commands (replace `yum` with `dnf` below if you are using CentOS 8+):

```bash
# add the yum repo:
wget https://openresty.org/package/centos/openresty.repo
sudo mv openresty.repo /etc/yum.repos.d/

# update the yum index:
sudo yum check-update
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

For CentOS 8 and beyond, we just need to replace the `yum` commands above with `dnf`.

# RHEL

You can add the `openresty` repository to your Red Hat Enterprise Linux (RHEL) system so as to easily install
our packages and receive updates in the future (via the `yum update` command). To add the repository, just
run the following commands (replace `yum` with `dnf` below if you are using RHEL 8+):

```bash
# add the yum repo:
wget https://openresty.org/package/rhel/openresty.repo
sudo mv openresty.repo /etc/yum.repos.d/

# update the yum index:
sudo yum check-update
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

For RHEL 8 and beyond, we just need to replace the `yum` commands above with `dnf`.

# Fedora

You can enable the `openresty` repository on your Fedora system like this:

```bash
# add the repo:
wget https://openresty.org/package/fedora/openresty.repo
sudo mv openresty.repo /etc/yum.repos.d/

# update the index:
sudo dnf check-update
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
# add the repo:
wget https://openresty.org/package/amazon/openresty.repo
sudo mv openresty.repo /etc/yum.repos.d/

# update the index:
sudo yum check-update
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

# SUSE Linux Enterprise

You can enable the `openresty` repository on your SUSE Linux Enterprise Server/Desktop/Workstation (SLES) system like below:

```bash
sudo rpm --import https://openresty.org/package/pubkey.gpg
sudo zypper ar -g --refresh --check "https://openresty.org/package/sles/openresty.repo"
sudo zypper mr --gpgcheck-allow-unsigned-repo openresty
```

Then you can install a package, say, `openresty`, like this:

```bash
sudo zypper install openresty
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

See the [OpenResty RPM Packages](rpm-packages.html) page for more details on all these packages.

# OpenSUSE Leap

You can enable the `openresty` repository on your OpenSUSE Leap system like below:

```bash
sudo rpm --import https://openresty.org/package/pubkey.gpg
sudo zypper ar -g --refresh --check https://openresty.org/package/opensuse/openresty.repo
sudo zypper mr --gpgcheck-allow-unsigned-repo openresty
```

Then import our PGP key:

```bash
sudo zypper --gpg-auto-import-keys refresh
```

Then you can install a package, say, `openresty`, like this:

```bash
sudo zypper install openresty
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

See the [OpenResty RPM Packages](rpm-packages.html) page for more details on all these packages.

# Alpine

First of all, please make sure you have enabled the Alpine's official community repository.
Basically, you can just open the file `/etc/apk/repositories` and uncomment a line looks
like this:

```
http://mirror.leaseweb.com/alpine/v3.11/community
```

Your actual line could be slightly different when you are using a different mirror site
or a differnt Alpine version.

You can enable the `openresty` repository on your Alpine system like below:

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

Then we can install the `openresty` package like this:

```bash
sudo apk add openresty
```

If you want to install the `resty` command-line utility, then just install the `openresty-resty` package below:

```bash
sudo apk add openresty-resty
```

The `opm` command-line utility is in the `openresty-opm` package while the `restydoc` utility is in the
`openresty-restydoc` package.

To view all the packages provided by our repos, type the following command:

```bash
apk list | grep 'openresty\|lemplate'
```

See the [OpenResty Alpine APK Packages](apk-packages.html) page for more details on all these packages.

# Support for More Linux Distributions

We welcome community contributions of packaging sources targeting more Linux distributions like Gentoo, SLES, Arch, Slackware, and Oracle Linux.
Please ensure the resulting packages resemble our existing [RPM Packages](rpm-packages.html)
wherever possible. Thank you!

# Packages for Non-Linux systems

We also provide pre-built binary packages for the Windows operating system. You can obtain it from the [Download](download.html) page.
