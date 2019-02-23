<!---
    @title         OpenResty® EC2 Test Cluster
--->

The OpenResty EC2 test cluster (we'll call it "test cluster" from now on)
is used by OpenResty core developers to run most of its software components'
test
suites in various different test modes on Amazon EC2. The latest official
test report can always be browsed on the
[qa.openresty.org site](http://qa.openresty.org) website.

Over the years, this tool chain successfully captured various obscure regressions
in new NGINX cores, new LuaJIT cores, as well as our own components.

On the highest level, it works like this:

1. The user spawns the EC2 test cluster using her AWS API credentials locally
in a terminal by invoking the command-line tool, `dispatcher`, provided
by the [opsboy](https://github.com/openresty/opsboy) github repository.
The user specifies the test running time constraint and test tasks.

2. The `dispatcher` command-line tool spawns one or more EC2 VM instances
according to the test tasks and the time constraint specified by the user.
It will try distributing the test jobs evenly across a minimum number of
EC2 VM instances while meeting the total running time constraint at its
best effort. The VM instances will keep running. Upon job completion or
job failures, they will automatically upload the raw test run logs as tarballs
to the server `qa-data.openresty.org`. See the [Spawn the test cluster][]
section
for more details.
3. The user waits for a period of time approximately equal to the time
constraint she specifies, until all the EC2 VM instances are terminated
(by checking the EC2 console, for example).
4. After all the VM instances are terminated, the user invokes the `make
pull` command under the `misc/logs/` directory of her local clone of the
`opsboy` repository. This command will automatically download the raw test
run logs as tarballs from the server `qa-data.openresty.org` into the local
sub-directory `ortest/`.
5. The user can now run the command `make gen` under the `misc/logs/` directory
to generate a new HTML report under the `html/` sub-directory. This command
will also print out newly unpacked `.log` files under `ortest/`. Sometimes
the user may want to check out the raw test run log data in those `.log`
files.
6. The user can open the `html/index.html`file locally with her favorite
web browser  to view the HTML version of the test report. But for the best
result, one should setup a local nginx server so that one can avoid browsers'
security constraints on opening local web pages directly.

## How to save money

AWS EC2 is not a free service (though for new customers they offer free
tier instances), it is important to use some tricks to minimize the monthly
bill.

To prepare for a new OpenResty release, all projects in all test modes
using the (new) version of the nginx core the new OpenResty release is
going to use. But usually we first only run `./dispatcher` with the `t`
test
target, that is, testing all projects using the "normal test mode" (which
explains in details below in the [Test job names][] section). If there
is some big problems with the opsboy script or some projects themselves,
we can fix it more quickly and without paying too much money for too many
EC2 instances. If `t` is green, we then try `tv` and etc, one by one, or
a few modes at a time. The easiest way to waste money is to run all test
modes for all projects and then only to find there is a silly mistake somewhere.

# Setup the environment

For security reasons, not everyone can directly perform the workflow explained
above. The user must have access to our EC2 AMI images with names like
`ortest-x64-2019-02-06`. Our AMI images always follow this naming convention.
The date suffix indicates on which date the image was created. And the
`x64` infix indicates the CPU architecture (we also have `i386` ones).
The user can request permission by sending emails to [Yichun Zhang](mailto:agentzh@gmail.com).
The user may also prepare her own AMI images if she wants to, but she must
change the `run-node` script in the `ops` github repository, somewhere
near [here](https://github.com/openresty/opsboy/blob/master/misc/logs/run-node#L12).

Also, the user needs to setup the Python-based [AWS CLI tool chain](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
and [configure](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
using the user's own AWS access key and secret access key locally. Make
sure the `aws` command-line tool is visible to your `PATH` system environment
so that `opsboy`'s `run-node` tool can [invoke it](https://github.com/openresty/opsboy/blob/master/misc/logs/run-node#L41)
successfully.

Clone the `opsboy` github repository like this:

```bash
git clone git://github.com/openresty/opsboy.git
```

If you are a committer of that repository, change `git://` to `git@`.

Then always switch the current working directory to the `misc/logs/` directory
of this local clone:

```bash
cd /path/to/opsboy/misc/logs/
```

Finally you need to prepare a shell script called `sync` (the name is important!)
of the content like below in the current working directory:

```bash
#!/usr/bin/env bash

rsync -av qa-data.openresty.org:~/ortest/ ortest/ || exit 1
mkdir -p ortest/
cd ortest/ || exit 1
for tar in $(ls *.tar.gz); do
    log=${tar%.tar.gz}.log
    if [ ! -f $log ]; then
        echo $tar
        tar -xzf $tar || exit 1
    fi
done
```

The user can change the server name `qa-data.openresty.org` in this script
to her own server if her AMI images upload the test run log files to somewhere
else.

# Spawn the test cluster

Spawning a test cluster on EC2 is easy with the `dispatch` tool provided
by `opsboy`. Usually we run the command like this:

```bash
./dispatcher -r -f -t 230 -a 'linux x86_64' t-lua-resty-redis to-lua-resty-websocket
```

The `-f` option passes the `force=1` variable to the [opsboy script](https://github.com/openresty/opsboy/blob/master/samples/ortest-ec2.ob.tt)
for the EC2 test cluster, which effectively force a clean rebuild of all
the NGINX C modules (like lua-nginx-module). The `-t 230` option constraints
the total running time to 230 minutes. This is just a soft limit and the
actual running time may exceed this a bit if the job dispatcher cannot
find a better way. The `-a 'linux x86_64'` option specifies that we use
the "Linux x86_64" architecture for this test run. Another supported architecture
is `linux i386`. They are defined internally inside the `run-node` script.
Each architecture name corresponds to an AMI image (by their IDs). The
`-r` option actually invokes the AWS CLI tool to spawn EC2 instances. Usually
we first omit this option to do a "dry run", to see how many EC2 instances
will be needed and how test jobs will be distributed among them. Below
is an example for a "dry run":

```shell
$ ./dispatcher -f -t 230 -a 'linux x86_64' t-lua-resty-redis ngx_lua
Requires at least 3 machines.
bucket 1: tl-ngx_lua thv-ngx_lua force=1 (228 min)
bucket 2: twv-ngx_lua tv-ngx_lua tr-ngx_lua to-ngx_lua force=1 (228 min)
bucket 3: trv-ngx_lua tw-ngx_lua t-ngx_lua th-ngx_lua t-lua-resty-redis
force=1 (183 min)
```

Here we will need 3 machines each will take 228 or 183 minutes to complete.
At his point you may wonder how does it know how long each job it will
run? Actually it uses the meta data produced by the previous job run (generated
by the command `make gen`). So initially it will simply assumes each job
will take 5 minutes.

The metadata generated by each run is stored in the `ast.json` file in
the `misc/logs/` directory. Usually it is the `make gen` command which
automatically updates it by analyzing the raw test run log files. The HTML
report is also rendered from this data file.

The user can skip particular test jobs by passing the `-e PATTERN` option.
This option takes a Perl regex so it can be quite powerful. The regex always
work on expanded test job names, like `to-ngx_lua`.

By default, the `dispatcher` tool uses the EC2 instance type `c5.large`
to run `Linux x86_64` architecture jobs and `c3.large` to run the i386
architecture. It is also possible to change the EC2 instance type used
by passing the `-i INSTANCE-TYPE` option to the `./dispatcher` command
line, like `-i t3.small`.

The `-c` option is also occasionally used to enforce the use of lua-resty-core
to run the Lua related projects' tests (including `ngx_lua`). Also it injects
Lua code `require('resty.core.base').set_string_buf_size(1) require('resty.core.regex'
).set_buf_grow_ratio(1)` to the `init_by_lua*` phase as well. It essentially
passes the `use_lua_resty_core=1` variable setting to the [opsboy script](https://github.com/openresty/opsboy/blob/master/samples/ortest-ec2.ob.tt).

By default, nginx 1.15.8 is used (which is changing by new OpenResty releases
though). One can choose a different nginx core version by specifying the
`-v VERSION` option of the `./dispatcher` tool, like `-v 1.13.6`. Not all
nginx version numbers will work. Make sure there *is* an OpenResty version
which uses that version of the nginx core.

You can see more options by typing `./dispatcher -h` and/or by directly
looking at its Perl source code.

# Test job names

In the `dispatcher` command line, we use test job names like `t-lua-resty-redis`
and `ngx_lua`. They deserve a separate section to explain. Basically the
test job names follow the following formats:

* `<test-mode>-<project-name>`
* `<test-mode>`
* `<project-name>`

The `<test-mode>` component can take the values `t`, `tr`, `tw`, `tv`,
`trv`, `twv`, `th`, `thv`, `tl`, `to`. They corresponds to the test modes
shown on the HTML test report like the one on [qa.openresty.org](https://qa.openresty.org/).
Still we explain them one by one below:

* `t`

  Normal test mode.

* `tr`

  Mockeagain reading test mode.

* `tw`

  Mockeagain writing test mode

* `tv`

  Valgrind test mode

* `trv`

  Combination of the `tr` and `tv` test modes.

* `twv`

  Combination of the `tw` and `tv` test modes.

* `th`

  HUP reload test mode.

* `thv`

  Combination of the `th` and `tv` test modes.

* `tl`

  Leak check test mode.

* `to`

  Builds with aggressive gcc optimization levels (`-O3`) and other options (like `-funsigned-char`).

Except `to`, all the test modes above are implemented by the `Test::Nginx`
scaffold. You can read this [free e-book section](https://openresty.gitbooks.io/programming-openresty/content/testing/test-modes.html)
to learn more details about these `Test::Nginx` test modes.

The `<project-name>` component is defined as the target open source project
names. NGINX modules follow the naming convention like `ngx_lua`, `ngx_stream_lua`,
and `ngx_set_misc`. Lua libraries follow the naming convention like `lua-resty-redis`,
`lua-resty-websocket`, and etc. There are also special projects like `resty-cli`
and etc. When in doubt, you can always copy the project names from a rendered
HTML page like on the [qa.openresty.org](https://qa.openresty.org/) site.

All the test modes and project names are internally defined in the `gen-use-data`
Perl script in the `opsboy` repository. Use of unknown test modes or project
names will lead to errors in this script.

If the user specify the test mode part alone, then all the projects will
be tested under that test mode. For example, specifying `t` alone will
result in all projects' test suites to be run using the normal test mode
while `to` will lead to all projects to be tested under the aggressive
optimization build mode. Therefore, to run all the projects under all test
modes, one can simply run the command like below:

```bash
./dispatcher -r -f -t 230 -a 'linux x86_64' t tr tw tv trv twv th thv tl
to
```

Similarly, if the user specifies a project name alone, then all test modes
will be run for that particular project. For example,

```bash
./dispatcher -r -f -t 230 -a 'linux x86_64' ngx_lua
```

is equivalent to

```bash
./dispatcher -r -f -t 230 -a 'linux x86_64' t-ngx_lua tr-ngx_lua tw-ngx_lua
\
    tv-ngx_lua trv-ngx_lua twv-ngx_lua th-ngx_lua thv-ngx_lua tl-ngx_lua to-ngx_lua
```

The former is just much more concise and much less error-prone.

# The expected test failure white-list

We maintain a white-list for expected test failures for particular test
modes on particular architectures in the `parse-logs` Perl script. We can
adjust existing white-list entries or add new entries by editing the Perl
variable `%white_list` in that script file somewhere near [here](https://github.com/openresty/opsboy/blob/master/misc/logs/parse-logs#L19).
Test result with expected failures only will be rendered by the orange
color in the HTML test report (test results without any failures will be
rendered green).

Special care must be taken when white-listing test failures. The patterns
should be as specific as possible and they should only mark true false
positives that are not easy to handle on the side of the test case itself.
Too permissive white-lists would hide real problems and thus defeating
the
whole purpose of this test cluster. Don't do this unless there is no other
way.

For valgrind false positives, we update the `valgrind.suppress` file in
each project repository instead of white-listing them in `parse-logs`.
The
same caveat applies to valgrind suppression rules. One may hide true memory
issues in the future with too aggressive rules.

# Add new projects to test

To add a new project to the test cluster, the user needs to patch several
files under the `misc/logs/` directory of the opsboy source tree. The easiest
way is to check how existing projects were specified:

```bash
$ grep websocket `ls -p |grep -v /|grep -v \~|grep -v json`
gen-report:    'lua-resty-websocket' => ['openresty', 'lua-resty-websocket'
],
gen-user-data:    'resty-websocket', 'resty-lock',
index.tt:        'lua-resty-websocket' => 'github.com/openresty/lua-resty-websocket'
,
parse-logs:    'lua-resty-websocket' => [
```

We can see that lua-resty-websocket has information in the files `gen-report`,
`gen-user-data`,`index.tt`, and `parse-logs`. The last one in `parse-logs`
is not necessary since it is for the white-list of expected failures (see
the [The expected test failure white-list][] section for details). So we
can simply add similar entries in the same way as `lua-resty-websocket`
to the same places (or similar places).

We will also need to update the [samples/ortest-ec2.ob.tt2](https://github.com/openresty/opsboy/blob/master/samples/ortest-ec2.ob.tt)
file to setup the testing logic.

# Changing the test driver logic

The VM environment initialization, project building, and test suite running
in each EC2 VM instance are all done by a Perl script called `openresty-tester.pl`
which is automatically generated by the opsboy compiler tool chain from
the specification file named [samples/ortest-ec2.ob.tt2](https://github.com/openresty/opsboy/blob/master/samples/ortest-ec2.ob.tt).
The opsboy tool chain always initializes the system incrementally.

From time to time, we'll need to edit this file to accommodate new changes
in either the operating system or the target projects to be tested.

To change this `oftest-ec2.ob.tt2` file, we need to

1. switch the current working directory to the root directory of the `opsboy`
clone,
2. edit `samples/ortest-ec2.ob.tt2` file for our needs,
3. run `make test` to update the `samples/ortest-ec2.ob` file using the
Perl TT2 tool chain, generate a Perl script using the opsboy compiler,
and
finally running the Perl script using the dry-run mode, and
4. Commit the newly updated `ortest-ec2.ob.tt2` and `ortest-ec2.ob` files
to your own branch and create a GitHub pull request for review and merge.

# Under the hood

Under the hood, the `dispatcher` script invokes `gen-user-data` script
to generate final test job specification strings from the user's command-line
arguments (see [Test job names][]). This final test job specification is
passed to the new EC2 VM instances as plain-text "user data". The `dispatcher`
script
invokes the `run-node` script which in turn runs the `aws` tool provided
by the AWS CLI tool chain to spawn the EC2 instances with the specified
"user data" from our pre-defined EC2 AMI images. Our EC2 AMI image registers
the [openresty-tester](https://github.com/openresty/opsboy/blob/master/misc/openresty-tester)
init
script as a symlink under the VM's `/etc/init.d/` directory such that new
changes in this file in the GitHub repository does not require updates
in the AMI image. This `openresty-tester` script in turn calls the [openresty-tester-wrapper](https://github.com/openresty/opsboy/blob/master/misc/openresty-tester-wrapper)
script. This `openresty-tester-wrapper` script does the heavy lifting of
running the `openresty-tester.pl` script which is automatically generated
from the [ortest-ec2.ob.tt](https://github.com/openresty/opsboy/blob/master/samples/ortest-ec2.ob.tt)
opsboy
script template file using the Perl TT2 template tool chain and the opsboy
compiler tool chain. Finally, upon completion, the `openresty-tester-wrapper`
script
invokes the `~/ortest-upload` script bundled in the AMI image to upload
the test run log file tarball to the remote server (by default, it is `qa-data.openresty.org`).

# The future

There are plans to migrate this tool chain over to the upcoming OpenResty
Ops and OpenResty CI platforms developed by [OpenResty Inc.](https://openresty.com)
in
the future so that it would be much easier to use, to extend, and to maintain.

# Author

This document was written by Yichun Zhang, the creator of this OpenResty
EC2 test cluster tool chain. Feel free to contact the author by sending
emails to the yichun@openresty.com address.

# Feedback and patches

The source of this document resides in the [openresty/openresty.org](https://github.com/openresty/openresty.org/)
GitHub repository. You are welcome to create issues and/or pull requests
if you have questions or edits for this document.

Translations to other languages are also welcome.

General feedback is welcome to send to the author of this document.
