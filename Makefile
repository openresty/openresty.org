.PHONY: all
all: faq.html

%.html: %.md
	markdown-toc.pl $<
	grip $< --export $@

.PHONY: upload
upload: all
	./upload

