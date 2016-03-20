.PHONY: all
all: faq.html

faq.html: faq.md Makefile
	markdown-toc.pl $<
	grip $< --export $@
	sed 's/<title>.*<\/title>/<title>FAQ - OpenResty<\/title>/g' $@ > /tmp/a.html
	sed 's/faq\.md/OpenResty FAQ/g' /tmp/a.html > /tmp/a2.html
	sed 's/  <link rel="icon" href=".*//g' /tmp/a2.html > /tmp/a.html
	cp /tmp/a.html $@

.PHONY: upload
upload: all
	./upload

