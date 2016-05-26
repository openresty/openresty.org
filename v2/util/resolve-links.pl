#!/usr/bin/env perl

use strict;
use warnings;

use File::Temp qw( tempfile );
use File::Copy qw( move );

my $infile = shift
    or die "No input file specified.\n";

open my $in, $infile
    or die "Cannot open $infile for reading: $!\n";

my ($out, $outfile) = tempfile("mdXXXXXXX", TMPDIR => 1);

my $c = 0;
while (<$in>) {
    $c += s! (\s) (balancer|ssl_certificate)_by_lua\* ( [\s,.:?] )
           !$1\[${2}_by_lua*](https://github.com/openresty/lua-nginx-module#${2}_by_lua_block)$3!xgs;

    $c += s! (\s) set_(md5) ( [\s,.:?] )
           !$1\[set_$2](https://github.com/openresty/set-misc-nginx-module#set_$2)$3!xgs;

    $c += s! (\s) (init(?:_worker)?|content|rewrite|access|log|(?:header|body)_filter)_by_lua\*
             ( [\s,.:?] )
           !$1\[${2}_by_lua*](https://github.com/openresty/lua-nginx-module#${2}_by_lua)$3!xgs;

    $c += s! (\s) ngx_(encrypted_session|headers_more|lua|echo|memc|redis2|srcache) ( [\s,.:?] ) !
            my ($pre, $name, $post) = ($1, $2, $3);
            (my $name2 = $name) =~ s/_/-/g;
            "$pre\[ngx_$name](https://github.com/openresty/$name2-nginx-module#readme)$post"
           !xegs;

    $c += s! (\s) ngx_devel_kit ( [\s,.:?] ) !$1\[ngx_devel_kit](https://github.com/simpl/ngx_devel_kit#readme)$2!xgs;

    $c += s! (\s) ngx_(iconv|form_input) ( [\s,.:?] ) !
            my ($pre, $name, $post) = ($1, $2, $3);
            (my $name2 = $name) =~ s/_/-/g;
            "$pre\[ngx_$name](https://github.com/calio/$name2-nginx-module#readme)$post"
           !xgse;

    $c += s! (\s) ( ngx\. (?: exit
                            | req\.(?:append|init|finish)_body
                            | re\.(?:g?match|g?sub|find)
                            | worker\.(?:p?id|count)
                            | send_headers
                            | status
                            | flush
                            | print
                            | say
                            )
                  | tcpsock:sslhandshake
                  | lua_ssl_verify_depth
                  | lua_ssl_trusted_certificate
                  | lua_check_client_abort
                   ) ( (?: \( [^)]* \) )? ) ( [\s,.:?] ) !
            my ($pre, $txt, $parens, $post) = ($1, $2, $3, $4);
            my $anchor = gen_anchor($txt);
            "$pre\[$txt$parens](https://github.com/openresty/lua-nginx-module#$anchor)$post"
            !xges;

    $c += s! (\s) ( ngx_http_(ssi|addition) (?: [_ ] module)? ) ( [\s,.:?] ) !$1\[$2](http://nginx.org/en/docs/http/ngx_http_${3}_module.html)$4!gxs;

    $c += s! (\s) FFI ( [\s,.:?] ) !$1\[FFI](http://luajit.org/ext_ffi.html)$2!gxs;

    $c += s! (\s) \$(upstream_addr) ( [\s,.:?] ) !$1\[\$$2](http://nginx.org/en/docs/http/ngx_http_upstream_module.html#var_$2)$3!gxs;

    $c += s! (\s) ssl\.(cert_pem_to_der) ( (?:\(\))? ) ( [\s,.:?] ) !
            my ($pre, $txt, $parens, $post) = ($1, $2, $3, $4);
            my $anchor = gen_anchor($txt);
            "$pre\[$txt$parens](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#$anchor)$post"
            !egx;

    $c += s! (\s) ( ngx\.(?:semaphore|ssl|balancer|ocsp) ) ( [\s,.:?] ) !
            my ($pre, $txt, $post) = ($1, $2, $3);
            (my $file = $txt) =~ s{\.}{/}g;
            "$pre\[$txt](https://github.com/openresty/lua-resty-core/blob/master/lib/$file.md#readme)$post"
            !egx;

    $c += s! (\s) (resty-cli|lua-cjson|lua-resty-(?:core|memcached|redis|dns|lock|lrucache|websocket)) ( [\s,.:?] ) !$1\[$2](https://github.com/openresty/$2#readme)$3!gxs;
    $c += s! (\s) (error_page|client_body_buffer_size) ( [\s,.:?] ) !$1\[$2](http://nginx.org/r/$2)$3!gxs;

    $c += s! (\s) (table\.concat) ( (?:\(\))? ) ( [\s,.:?] ) !$1\[$2$3](http://www.lua.org/manual/5.1/manual.html#pdf-$2)$4!gxs;
    $c += s! (\s) ([Nn]ginx) ( [\s,.:?] ) !$1\[$2](nginx.html)$3!gxsi;
    print $out $_;
}

close $outfile;

close $in;

if ($c) {
    warn "$c edits.\n";
    move($outfile, $infile)
        or die "Cannot move $outfile to $infile: $!\n";
}

sub gen_anchor {
    my $link = shift;
    $link =~ s/[^-\w_ ]//g;
    $link =~ s/ /-/g;
    if ($link =~ /^[A-Z][a-z]+_[A-Z][a-z]+/) {
        $link =~ s/_/-/g;
    }
    lc($link);
}
