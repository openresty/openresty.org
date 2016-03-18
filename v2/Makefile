nginx = nginx
md2html = pandoc --from markdown_github --to html
html_files := $(patsubst %.md,html/%.html,$(wildcard en/*.md cn/*.md))
templates_lua = lua/openresty_org/view.lua

.DELETE_ON_ERRORS: $(templates_lua)

.PHONE: all
all: templates

.PHONE: templates
templates: $(templates_lua)

$(templates_lua): templates/*.tt2
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
	rm -f $(html_files) $(txt_files)
	rm -rf html

html/%.html: %.md
	mkdir -p html/en
	$(md2html) $< --output $@

.PHONE: data
data: $(html_files)

.PHONE: extract
extract: data
	./extract.pl ../index.html en

.PHONE: gendata
gendata: html
	./gen-data.pl en

.PHONE: initdb
initdb:
	psql -Uopenresty openresty_org -f init.sql

.PHONE: html
html: $(html_files)
