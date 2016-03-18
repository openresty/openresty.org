md2html = pandoc --from markdown_github --to html
html_files := $(patsubst %.md,html/%.html,$(wildcard en/*.md cn/*.md))

all: $(txt_files) $(html_files) Makefile

clean:
	rm -f $(html_files) $(txt_files)
	rm -rf html

html/%.html: %.md
	mkdir -p html/en
	$(md2html) $< --output $@

extract:
	./extract.pl ../index.html en

gendata:
	./gen-data.pl en

initdb:
	psql -Uopenresty openresty_org -f init.sql

