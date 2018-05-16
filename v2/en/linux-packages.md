<!---
    @title         OpenResty® Linux Packages
--->

OpenResty<sup>&reg;</sup> provides official pre-built packages for the following Linux distributions and versions.

* Ubuntu

```
    Version         Codename        Supported Architectures
    14.04           Trusty          amd64, i386
    16.04           Xenial          amd64, i386
    17.10           Artful          amd64, i386
    18.04           Bionic          amd64, i386
```

* Debian

```
    Version         Codename        Supported Architectures
    7.x             Wheezy          amd64
    8.x             Jessie          amd64
    9.x             Stretch         amd64
```

* CentOS

```
    Version         Supported Architectures
    6.x             x86_64
    7.x             x86_64
```

* Red Hat Enterprise Linux (RHEL)

```
    Version         Supported Architectures
    6.x             x86_64
    7.x             x86_64
```

* Fedora

```
    Version         Supported Architectures
    26              x86_64
    27              x86_64
```

* Amazon Linux

```
    Version         Supported Architectures
    2018.03         x86_64
```

All our repositories' metadata (and rpm binary packages) are signed by the following GPG key, `0xD5EDEB74`:

https://openresty.org/package/pubkey.gpg

**IMPORTANT!** All the official binary packages for Intel `x86_64` CPUs require SSE 4.2 instruction support in the CPU.
If you use an old CPU that does not support SSE 4.2, then you need to build OpenResty from its source tarball on *that*
CPU yourself. See the [Download](download.html) and [Installation](installation.html) page for details. Otherwise you
will see the `Illegal instruction` error when using the binary packages on your CPUs lacking SSE 4.2 support.

# Ubuntu

You can add our APT repository to your Ubuntu system so as to easily install
our packages and receive updates in the future (via the `apt-get update` command). To add the repository, just
run the following commands (only need to run once for each system):

```bash
    # import our GPG key:
    wget -qO - https://openresty.org/package/pubkey.gpg | sudo apt-key add -

    # for installing the add-apt-repository command
    # (you can remove this package and its dependencies later):
    sudo apt-get -y install software-properties-common

    # add the our official APT repository:
    sudo add-apt-repository -y "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main"

    # to update the APT index:
    sudo apt-get update
```

Then you can install a package, say, `openresty`, like this:

```bash
    sudo apt-get install openresty
```

This package also recommends the `openresty-opm` and `openresty-restydoc` packages so the latter two will
also automatically get installed by default. If that is not what you want, you can disable the automatic
installation of recommended packages like this:

```bash
    sudo apt-get install --no-install-recommends openresty
```

See the [OpenResty Deb Packages](deb-packages.html) page for more details on all available packages in this
repository.

# Debian

## Debian Jessie or Later

You can add the `openresty` repository to your Debian system so as to easily install
our packages and receive updates in the future (via the `apt-get update` command). To add the repository, just
run the following commands (only need to run once for each system):

```bash
    # import our GPG key:
    wget -qO - https://openresty.org/package/pubkey.gpg | sudo apt-key add -

    # for installing the add-apt-repository command
    # (you can remove this package and its dependencies later):
    sudo apt-get -y install software-properties-common

    # add the our official APT repository:
    sudo add-apt-repository -y "deb http://openresty.org/package/debian $(lsb_release -sc) openresty"

    # to update the APT index:
    sudo apt-get update
```

Then you can install a package, say, `openresty`, like this:

```bash
    sudo apt-get install openresty
```

This package also recommends the `openresty-opm` and `openresty-restydoc` packages so the latter two will
also automatically get installed by default. If that is not what you want, you can disable the automatic
installation of recommended packages like this:

```bash
    sudo apt-get install --no-install-recommends openresty
```

See the [OpenResty Deb Packages](deb-packages.html) page for more details on all available packages in this
repository.

## Debian Wheezy

You can add the `openresty` repository to your Deian Wheezy system so as to easily install
our packages and receive updates in the future (via the `apt-get update` command). To add the repository, just
run the following commands (only need to run once for each system):

```bash
    # import our GPG key:
    wget -qO - https://openresty.org/package/pubkey.gpg | sudo apt-key add -

    # for installing the add-apt-repository command
    # (you can remove this package and its dependencies later):
    sudo apt-get -y install python-software-properties

    # enable the wheezy-backports repository:
    sudo add-apt-repository -y "deb http://ftp.debian.org/debian wheezy-backports main"

    # add the our official APT repository:
    sudo add-apt-repository -y "deb http://openresty.org/package/debian $(lsb_release -sc) openresty"

    # to update the APT index:
    sudo apt-get update
```

Then you can install a package, say, `openresty`, like this:

```bash
    sudo apt-get install openresty
```

This package also recommends the `openresty-opm` and `openresty-restydoc` packages so the latter two will
also automatically get installed by default. If that is not what you want, you can disable the automatic
installation of recommended packages like this:

```bash
    sudo apt-get install --no-install-recommends openresty
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
    sudo yum install yum-utils
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

See the [OpenResty RPM Packages](rpm-packages.html) page for more details on all these packages.

# Fedora

You can enable the `openresty` repository on your Fedora system like this:

```bash
    sudo dnf install dnf-plugins-core
    sudo dnf config-manager --add-repo https://openresty.org/package/fedora/openresty.repo
```

Then you can easily install packages from the `openresty-openresty` repository and receive updates
in the future (through the `dnf update` command). For example, to install the `openresty` package, we can just run the
following command:

```bash
    sudo dnf install openresty
```

If you want to install the `resty` command-line utility, then install the `openresty-resty` package like below:

```bash
    sudo dnf install openresty-resty
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
    sudo yum install yum-utils
    sudo yum-config-manager --add-repo https://openresty.org/package/amazon/openresty.repo
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

# Support for More Linux Distributions

We welcome community contributions of packaging sources targeting more Linux distributions like OpenSUSE, SLES, Arch Linux, and Slackware.
Please ensure the resulting packages resemble our existing [RPM Packages](rpm-packages.html)
wherever possible. Thank you very much!

# Packages for Non-Linux systems

We also provide pre-built binary packages for the Windows operating system. You can obtain it from the [Download](download.html) page.
