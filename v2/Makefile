nginx = nginx
md2html = pandoc --from markdown_github-hard_line_breaks --to html
md2text = pandoc --from markdown_github-hard_line_breaks --to plain
html_files := $(patsubst %.md,html/%.html,$(wildcard en/*.md cn/*.md))
txt_files := $(patsubst %.md,text/%.txt,$(wildcard en/*.md cn/*.md))
templates_lua = lua/openresty_org/view.lua
tt2_files := $(wildcard templates/*.tt2)

.DELETE_ON_ERRORS: $(templates_lua)

.PHONE: all
all: templates

.PHONE: templates
templates: $(templates_lua)

$(templates_lua): $(tt2_files)
	lemplate --compile $^ > $@

.PHONE: run
run:
	mkdir -p logs
	$(nginx) -p $$PWD -c conf/nginx.conf

reload: logs/nginx.pid all
	$(nginx) -p $$PWD -c conf/nginx.conf -t
	kill -HUP `cat $<`

.PHONE: clean
clean:
	rm -rf html text

.PHONE: html
html: $(html_files)

html/%.html: %.md
	mkdir -p html/en html/cn
	$(md2html) $< --output $@

.PHONE: text
text: $(txt_files)

text/%.txt: %.md
	mkdir -p text/en text/cn
	$(md2text) $< --output $@

.PHONE: extract
extract:
	./util/extract.pl ../index.html en
	./util/extract.pl ../cn/index.html cn

.PHONE: gendata
gendata: html text
	./util/gen-data.pl en
	./util/gen-data.pl cn

posts-en.tsv posts-cn.tsv:
	$(MAKE) gendata

.PHONE: initdb
initdb: posts-en.tsv posts-cn.tsv
	psql -Uopenresty openresty_org -f init.sql

