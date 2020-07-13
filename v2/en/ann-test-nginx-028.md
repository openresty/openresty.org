<!---
    @title         Test::Nginx 0.28 Released
    @creator       Yichun Zhang
--->

We have uploaded Test::Nginx 0.28 to CPAN:

    https://metacpan.org/release/Test-Nginx

It will appear on the CPAN mirror near you in the next few hours or
so. After that, you can install the module like below

```bash
sudo cpan Test::Nginx
```

or better, when you have the App::cpanminus module already installed:

```bash
sudo cpanm Test::Nginx
```

Special thanks go to all our contributors and developers!

# Full Change logs

Here's the complete change log for this release (compared to the last
CPAN release, 0.27):

* bugfix: we downgraded the bundled version of Test::Builder to avoid the
extra dependency Test2::Util.

# About Test::Nginx

This Perl module provides a test scaffold for automated testing in Nginx C module
or OpenResty-based Lua library development.

This class inherits from `Test::Base`, thus bringing all its declarative
power to the Nginx C module testing practices.

All of our OpenResty projects are using this test scaffold for
automated regression testing.

Please check out the full documentation on CPAN:

https://metacpan.org/pod/Test::Nginx::Socket

as well as the official user guide in the book "Programming OpenResty":

https://openresty.gitbooks.io/programming-openresty/content/testing/

All of our Nginx modules (as well as our lua-resty-* libraries) are
using Test::Nginx to drive their test suites. And it is also driving
my test cluster running on Amazon EC2:

https://qa.openresty.org

Please note that this module is completely different from the
Test::Nginx module originally created by Maxim Dounin.

The git repository for this Perl module is hosted on GitHub:

https://github.com/openresty/test-nginx

# Feedback

Feedback on this release is more than welcome. Feel free to create new
[GitHub issues](https://github.com/openresty/test-nginx/issues) or send emails to one of our [mailing lists](community.html).
