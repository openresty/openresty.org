.PHONY: all
all: faq.html

faq.html: faq.md
	markdown-toc.pl $<
	grip $< --export $@
	sed 's/<title>.*<\/title>/<title>FAQ - OpenResty<\/title>/' $@ > /tmp/a.html
	sed 's/faq\.md/OpenResty FAQ/' /tmp/a.html > /tmp/a2.html
	cp /tmp/a2.html $@

.PHONY: upload
upload: all
	./upload

