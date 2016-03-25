nginx = nginx

md2html = pandoc --from markdown_github-hard_line_breaks --to html
md2text = pandoc --from markdown_github-hard_line_breaks --to plain

html_files := $(patsubst %.md,html/%.html,$(wildcard en/*.md cn/*.md))
txt_files := $(patsubst %.md,text/%.txt,$(wildcard en/*.md cn/*.md))

i18n_lua = lua/openresty_org/i18n.lua
templates_lua = lua/openresty_org/templates.lua

lua_files := $(sort $(filter-out $(i18n_lua) $(templates_lua),$(wildcard lua/*.lua lua/openresty_org/*.lua)))
tt2_files := $(sort $(wildcard templates/*.tt2))

extract_pl = ./util/extract.pl
gendata_pl = ./util/gen-data.pl
msginit_pl = ./util/msginit.pl
msgfmt_pl = ./util/msgfmt.pl

po_files = po/cn.po
tsv_files = posts-en.tsv posts-cn.tsv

.DELETE_ON_ERRORS: $(templates_lua)

.PHONE: all
all: templates msgfmt

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
	rm -rf html text *.tsv
	rm -f $(templates_lua)

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

# WARNING: this target will override existing .md files
# so any manual edits would get lost!
.PHONE: extract
extract:
	$(extract_pl) ../v1/index.html en
	$(extract_pl) ../v1/cn/index.html cn

.PHONE: gendata
gendata: $(tsv_files)

$(tsv_files): $(html_files) $(txt_files) $(gendata_pl)
	$(gendata_pl) en
	$(gendata_pl) cn

.PHONE: initdb
initdb: $(tsv_files)
	psql -Uopenresty openresty_org -f init.sql

.PHONE: deploy
deploy:
	ls $(tsv_files)
	psql -Uopenresty openresty_org -f init.sql

.PHONE: msginit
msginit: $(po_files)

$(po_files): $(lua_files) $(tt2_files) $(msginit_pl)
	$(msginit_pl) --outdir po --locale cn $(lua_files) $(tt2_files)

.PHONE: msgfmt
msgfmt: $(i18n_lua)

$(i18n_lua): $(po_files) $(msgfmt_pl)
	$(msgfmt_pl) -o $(i18n_lua) $(po_files)
