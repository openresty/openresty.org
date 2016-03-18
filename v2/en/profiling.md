<!---
    @title         Profiling
    @creator       Yichun Zhang
    @created       2014-04-29 19:14 GMT
    @modifier      YichunZhang
    @modified      2014-04-29 19:18 GMT
    @changes       7
--->

[Profiling](profiling/) is important for analyzing and optimize [OpenResty](openresty/) applications' performance.

We do provide various tools based on Systemtap for profiling live [OpenResty](openresty/) applications both in production and development environments.

The most useful tools are
* C-land on-CPU Flame Graph tool: https://github.com/openresty/nginx-systemtap-toolkit#sample-bt
* C-land off-CPU Flame Graph tool: https://github.com/openresty/nginx-systemtap-toolkit#sample-bt-off-cpu
* Lua-land on-CPU Flame Graph tool: https://github.com/openresty/stapxx#lj-lua-stacks

It is recommended to build Systemtap from latest release source, see [BuildSystemtap](build-systemtap/) for details.

If you have problems in interpreting the resulting flame graphs or have troubles getting these tools running in your system, feel free to join our OpenResty [Community](community/) and ask for help.
