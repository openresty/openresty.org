<!---
    @title         Linux Packages
--->

OpenResty provides official pre-built packages for the following Linux distributions and versions:

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

You can add the `openresty` repository to your RHEL or CentOS system so as to easily install
our packages and receive updates automatically in the future. To add the repository, just
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

# Fedora

You can enable the `openresty` repository on your Fedora system like this:

```
sudo dnf install yum-plugin-copr
sudo dnf copr enable openresty/openresty
```

Then you can easily install packages from the `openresty-openresty` repository and receive updates
automatically in the future. For example, to install the `openresty` package, we can just run the
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
