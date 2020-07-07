<!---
    @title         Test::Nginx 0.27 Released
    @creator       Yichun Zhang
--->

We have uploaded Test::Nginx 0.27 to CPAN:

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
CPAN release, 0.26):

*   feature: added the --- reload_fails new section to skip checking
config_version after HUP reload in the HUp reload testing mode.

*   feature: added a "--- gen_dgram_request" section.

*   feature: relaxed the Server response header parsing pattern for
extracting the nginx core verison number.

*   bugfix: when --- reload_fails is specified, we did not assume ---
no_chck_leak since it would always fail in the check leak testing mode.

*   feature: implemented the `--- shutdown_error_log` section for
checking the error logs generated during nginx exit.

*   feature: added new test mode enabled by the env TEST_NGINX_USE_HTTP2=1
and new section "--- http2", for enabling the HTTP/2 protocol to
send the test request.

*   bugfix: when TEST_NGINX_USE_STAP=1 env was specified, the master process
would be turned off when for test blocks without actually using --- stap.

*   feature: be more patient to wait for the nginx to start up in profiling
and "check leak" test mode.

*   optimize: use perl's own remove_tree() instead of the shell command
'rm  -rf' since the latter may use too much memory.

*   feature: added support for the env TEST_NGINX_CHECK_LEAK_COUNT to control
how many data points to sample in the "check leak" test mode.

*   feature: now we pass through the MOCKNOEAGAIN_VERBOSE and MOCKNOEAGAIN
env to the nginx worker processes by default as well.

*   feature: added support for TEST_NGINX_WORKER_USER env for setting the user
account (and user group) for nginx worker processes; defaults to root when
the master is run by root.

*   bugfix: the value of env TEST_NGINX_WORKER_USER did not accept a single
user name (without a user group name).

*   feature: added support for the --- access_log section for checking access
log file content.

*   bugfix: valgrind test mode: we no longer disable nginx master process in
this mode.

*   bugfix: we did not clean up nginx's *_cache directories under the server
root directory.

*   feature: added support for environment variable TEST_NGINX_REUSE_PORT for
enabling the reuseport parameter in the listen directive automatically
generated in nginx.conf.

*   feature: we now check for the new "write guard" warning message to detect
misuses of lua globals.

*   feature: added the use_hup() Perl utility function.

*   feature: when --- no_error_log fails, we output up to 9 lines of
subsequent error log messages for better debuggability (for example,
wen can have complete lua backtraces).

*   feature: expanded environment values in --- user_files section.

*   bugfix: when setting TEST_NGINX_USE_HUP=1, some directories could not be
cleaned up correctly.

*   feature: implemented the TEST_NGINX_USE_RR=1 env for enabling Mozilla rr
to record the nginx server execution.

*   bugfix: increased resiliency in HUP reload mode.

*   feature: added the '--- skip_openssl' section to skip tests depending on
the OpenSSL version NGINX was built with.

*   bugfix: ensured we do not remove some files when using HUP mode.

*   bugfix: properly use a concat operator instead of a range.

*   bugfix: ensure servroot is cleaned up when starting NGINX for the first
time.

# About Test::Nginx

This Perl module provides a test scaffold for automated testing in Nginx C module
or OpenResty-based Lua library development.

This class inherits from `Test::Base`, thus bringing all its declarative
power to the Nginx C module testing practices.

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
