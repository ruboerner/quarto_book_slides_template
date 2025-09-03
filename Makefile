SHELL := /usr/bin/env bash
Q      ?= quarto
DOCS   ?= docs
CHAPTERS = methods.qmd history.qmd
SLIDE_HTMLS = $(patsubst %.qmd,$(DOCS)/%_slides.html,$(CHAPTERS))

.PHONY: all book slides clean

all: book slides

book:
	mkdir -p $(DOCS)
	$(Q) render --no-clean

slides: $(SLIDE_HTMLS)

$(DOCS)/%_slides.html: %.qmd
	mkdir -p $(DOCS)
	# Render slides with profile 'slides'. Quarto puts output into $(DOCS).
	$(Q) render --profile slides $< -t revealjs
	@test -f $@ || { echo "Slide deck not found: $@"; exit 1; }

clean:
	rm -rf $(DOCS)