<!---
    @title         Test::Nginx 0.30 Released
    @creator       Jiahao Wang
--->

We have uploaded Test::Nginx 0.30 to CPAN:

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
CPAN release, [0.29](ann-test-nginx-029.html)):

0.30 - 2022-05-13

 *   bugfix: reserved ports for stream_server_config.

 *   feature: expanded environment values in --- tcp_listen section.

 *   bugfix: user name with dash was not allowed, eg like 'www-data'. thanks
     lijunlong for the patch.

 *   bugfix: there can be trailing spaces in HTTP 0.9.

 *   feature: add TEST_NGINX_FAST_SHUTDOWN to stop Nginx without graceful.
     thanks spacewander for the patch.

 *   bugfix: supported to parse http trailer in response body. thanks Yuansheng
     for the patch.

 *   change: quic use keepalive_timeout instead of quic_max_idle_timeout now.
     thanks lijunlong for the patch.

 *   bugfix: did not skip test cases that proxy_pass or directly connect to
     request server port. thanks lijunlong for the patch.

 *   bugfix: should not change config line number for old test cases.
     thanks lijunlong for the patch.

 *   bugfix: curl request was sent before nginx startup when running in valgrind
     mode. thanks lijunlong for the patch.

 *   bugifx: waitpid failed when the process is not subprocess of perl. thanks
     lijunlong for the patch.

 *   bugfix: nginx reload hangs when http3 is enabled. thanks lijunlong for the
     patch.

 *   feature: support HTTP/3 testing. thanks lijunlong for the patch.

 *   feature: added new section "--- no_access_log" which could be used to
     specify patterns of lines that do not appear in access.log at all.
     thanks levy001 for the patch.

 *   bugfix: allow capture OpenSSL version without letter. thanks Wangchong Zhou
     for the patch.

 *   feature: check if grep_error_log is defined when grep_error_log_out exists.
     thanks spacewander for the patch.

 *   feature: add '--- curl_options' and '--- curl_protocol' section.
     thanks woodgear for the patch.

 *   feature: added file name to name of the test case. thanks lijunlong for
     the patch.

 *   feature: support FIRST to mark the beginning of test. thanks spacewander
     for the patch.

 *   bugfix: perl did not exit when kill process with SIGKILL. thanks lijunlong
     for the patch.

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
