nginx = nginx
md2html = pandoc --from markdown_github --to html
md2text = pandoc --from markdown_github --to plain
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
	mkdir -p html/en
	$(md2html) $< --output $@

.PHONE: text
text: $(txt_files)

text/%.txt: %.md
	mkdir -p text/en
	$(md2text) $< --output $@

.PHONE: extract
extract:
	./extract.pl ../index.html en

.PHONE: gendata
gendata: html text
	./gen-data.pl en

.PHONE: initdb
initdb: gendata
	psql -Uopenresty openresty_org -f init.sql

