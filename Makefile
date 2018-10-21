ELS = \
	elisp/emacs-goodies-el/color-theme.elc \
	elisp/emacs-goodies-el/color-theme-library.elc \
	elisp/emacs-goodies-el/color-theme_seldefcustom.elc \
	elisp/emacs-goodies-el/htmlize.elc \
	elisp/auto-complete.elc \
	elisp/auto-complete-config.elc \
	elisp/gnuplot.elc \
	elisp/golden-ratio.elc \
	elisp/popup.elc \
	elisp/sdcv-mode.elc \
	elisp/unicad.elc \
	elisp/yasnippet.elc

all: $(ELS)
	make -C elisp/ProofGeneral
	make -C elisp/tuareg-2.0.6

clean:
	rm -rf $(ELS)
	make -C elisp/ProofGeneral clean
	make -C elisp/tuareg-2.0.6 clean

%.elc: %.el
	emacs -batch -l init.el -f batch-byte-compile $<
