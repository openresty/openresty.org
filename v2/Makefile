MARKDOWN = pandoc --from markdown_github --to html
all: $(patsubst %.md,html/%.html,$(wildcard en/*.md cn/*.md)) Makefile

clean:
	rm -f $(patsubst %.md,html/%.html,$(wildcard en/*.md cn/*.md))
	rm -rf html

html/%.html: %.md
	mkdir -p html/en
	$(MARKDOWN) $< --output $@

