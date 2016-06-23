#!/usr/bin/env perl -p

BEGIN{ $tag=sprintf("%x%04x", int(time()/86400), int((time()%86400) / 60)); }

s{\?v=CACHETAG}{?v=$tag}g;
