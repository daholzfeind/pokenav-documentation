# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SPHINXPROJ    = PokeNav
SOURCEDIR     = source
BUILDDIR      = build
GH_PAGES_SOURCES = source Makefile
GH_PAGES_ADD =  CNAME .nojekyll

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)


gh-pages:
	git checkout gh-pages
	rm -rf build _sources _static
	git checkout master $(GH_PAGES_SOURCES) $(GH_PAGES_ADD)
	git reset HEAD
	make html
	rsync -avz build/html/* ./
	rm -rf $(GH_PAGES_SOURCES) build
	git add -A
	git commit -m "Generated gh-pages for `git log master -1 --pretty=short --abbrev-commit`" && git push origin gh-pages; git checkout master


livehtml:
	sphinx-autobuild -H 0.0.0.0 -p 9090 -b html -i *.swp $(SPHINXOPTS) source $(BUILDDIR)/html
