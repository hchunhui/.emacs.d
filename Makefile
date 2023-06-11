ELS = \
	elisp/emacs-goodies-el/htmlize.elc \
	elisp/auto-complete.elc \
	elisp/auto-complete-config.elc \
	elisp/auto-complete-config.elc \
	elisp/auto-complete.elc \
	elisp/chinese-fonts-setup.elc \
	elisp/dtrt-indent.elc \
	elisp/edit-env.elc \
	elisp/flymake-shellcheck.elc \
	elisp/gnuplot.elc \
	elisp/golden-ratio.elc \
	elisp/lua-mode.elc \
	elisp/popup.elc \
	elisp/rust-mode.elc \
	elisp/sdcv-mode.elc \
	elisp/solarized-definitions.elc \
	elisp/solarized-theme.elc \
	elisp/unicad.elc \
	elisp/window-numbering.elc \
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
