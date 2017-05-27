<!---
    @title         OpenResty® Linux Packages
--->

OpenResty<sup>&reg;</sup> provides official pre-built packages for the following Linux distributions and versions.

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
    24              x86_64
    25              x86_64
    26              x86_64
```

* Amazon Linux

```
    Version         Supported Architectures
    2017.03         x86_64
```

All our repositories' metadata and binary packages in them are signed by the following GPG key, `0xD5EDEB74`:

https://openresty.org/package/pubkey.gpg

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

You can enable the `openresty` repository on your Fedora system like this:

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

We welcome community contributions of packaging sources targeting more Linux distributions like Ubuntu and
Debian. Please ensure the resulting packages resemble our existing [RPM Packages](rpm-packages.html)
wherever possible. Thank you very much!

# Packages for Non-Linux systems

We also provide pre-built binary packages for the Windows operating system. You can obtain it from the [Download](download.html) page.
