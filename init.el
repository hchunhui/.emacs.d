(setq use-default-font-for-symbols nil)
(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/elisp/emacs-goodies-el")

(setq-default initial-scratch-message
	      ";; A man, a plan, a canal - Panama! ;;\n\n")

;; theme
(require 'color-theme-solarized)
(color-theme-initialize)
(color-theme-solarized-dark)
;;(color-theme-dark-laptop)

;; fonts
(require 'chinese-fonts-setup)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cfs--current-profile-name "profile1" t)
 '(cfs--fontsize-steps (quote (2 4 4)) t)

;; options
(setq frame-title-format "%b@emacs")
(setq mouse-yank-at-point t)
(setq inhibit-startup-screen t)
(setq uniquify-buffer-name-style 'forward)
(setq c-default-style
      '((java-mode . "java") (awk-mode . "awk") (other . "linux")))
(put 'dired-find-alternate-file 'disabled nil)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(ido-mode t)
(show-paren-mode t)
(column-number-mode t)
(which-func-mode t)
(add-to-list 'auto-mode-alist '("\\.C\\'" . cc-mode))
(add-to-list 'auto-mode-alist '("\\.F90\\'" . f90-mode))

;; golden ratio
(require 'golden-ratio)

;; auto complete
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'coq-mode)

;; yasnippet
(require 'yasnippet-bundle)
(setq yas/root-directory "~/.emacs.d/mysnippets")
(yas/load-directory yas/root-directory)

;; sdcv
(require 'sdcv-mode)

;; unicad
(require 'unicad)

;; window numbering
(require 'window-numbering)
(window-numbering-mode 1)

;; tuareg (OCaml)
(add-to-list 'load-path "~/.emacs.d/elisp/caml-mode")
(add-to-list 'load-path "~/.emacs.d/elisp/tuareg-2.0.6")
(load "tuareg-site-file.el")

(push "~/.opam/4.07.0/share/emacs/site-lisp" load-path)
(setq merlin-command "ocamlmerlin")
(setq merlin-ac-setup t)
(autoload 'merlin-mode "merlin" "Merlin mode" t)
(add-hook 'tuareg-mode-hook 'merlin-mode)
(add-hook 'caml-mode-hook 'merlin-mode)

;; proof general (Coq)
(load-file "~/.emacs.d/elisp/ProofGeneral/generic/proof-site.el")
(setq proof-splash-enable nil)
(defvar proof-mode-map (make-sparse-keymap))
(define-key proof-mode-map (kbd "C-,") 'proof-undo-last-successful-command)
(define-key proof-mode-map (kbd "C-.") 'proof-assert-next-command-interactive)
(or (assoc 'proof-mode minor-mode-map-alist)
    (setq minor-mode-map-alist
	  (cons (cons 'proof-mode proof-mode-map)
		minor-mode-map-alist)))

(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;; flymake
(autoload 'flymake-find-file-hook "flymake" "" t)
(add-hook 'find-file-hook 'flymake-find-file-hook)
(setq flymake-gui-warnings-enabled nil)
(setq flymake-log-level 0)

(defun flymake-display-current-error ()
  "Display errors/warnings under cursor."
  (interactive)
  (let ((ovs (overlays-in (point) (1+ (point)))))
    (catch 'found
      (dolist (ov ovs)
        (when (flymake-overlay-p ov)
          (message (overlay-get ov 'help-echo))
          (throw 'found t))))))

(defun flymake-goto-next-error-disp ()
  "Go to next error in err ring, then display error/warning."
  (interactive)
  (flymake-goto-next-error)
  (flymake-display-current-error))

(defun flymake-goto-prev-error-disp ()
  "Go to previous error in err ring, then display error/warning."
  (interactive)
  (flymake-goto-prev-error)
  (flymake-display-current-error))

(defvar flymake-mode-map (make-sparse-keymap))
(define-key flymake-mode-map (kbd "<f12>") 'flymake-goto-next-error-disp)
(define-key flymake-mode-map (kbd "C-<f12>") 'flymake-goto-prev-error-disp)
(or (assoc 'flymake-mode minor-mode-map-alist)
    (setq minor-mode-map-alist
          (cons (cons 'flymake-mode flymake-mode-map)
                minor-mode-map-alist)))

;; gnuplot
(autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
(autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)
(setq auto-mode-alist (append '(("\\.gp$" . gnuplot-mode)) auto-mode-alist))

;; revert buffer
(defun wl-revert-buffer (&optional arg)
  (interactive "P")
  (revert-buffer t t arg))

;; goto char
(defun wy-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
		     char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))

;; global keys
(global-set-key [(f5)] 'wl-revert-buffer)
(global-set-key [(f6)] 'golden-ratio-mode)
(global-set-key [(f7)] 'other-window)
(global-set-key [(f8)] 'delete-other-windows)
(global-set-key [(f9)] 'compile)
(global-set-key [(f11)] 'ido-imenu)
(global-set-key (kbd "C-c d") 'sdcv-search)
(define-key global-map (kbd "C-c g") 'wy-go-to-char)


;; mew
;;(add-to-list 'load-path "~/.emacs.d/elisp/mew")
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
(setq mew-ssl-verify-level 0)

;; Optional setup (Read Mail menu):
(setq read-mail-command 'mew)

;; Optional setup (e.g. C-xm for sending a message):
(autoload 'mew-user-agent-compose "mew" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'mew-user-agent
      'mew-user-agent-compose
      'mew-draft-send-message
      'mew-draft-kill
      'mew-send-hook))

;; evil
(add-to-list 'load-path "~/.emacs.d/elisp/evil")
(require 'evil)
(global-set-key [(f1)] 'evil-mode)

;; ido-imenu
(defun ido-imenu ()
  "Update the imenu index and then use ido to select a symbol to navigate to.
Symbols matching the text at point are put first in the completion list."
  (interactive)
  (unless (featurep 'imenu)
    (require 'imenu nil t))
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet ((addsymbols (symbol-list)
                       (when (listp symbol-list)
                         (dolist (symbol symbol-list)
                           (let ((name nil) (position nil))
                             (cond
                              ((and (listp symbol) (imenu--subalist-p symbol))
                               (addsymbols symbol))

                              ((listp symbol)
                               (setq name (car symbol))
                               (setq position (cdr symbol)))

                              ((stringp symbol)
                               (setq name symbol)
                               (setq position (get-text-property 1 'org-imenu-marker symbol))))

                             (unless (or (null position) (null name))
                               (add-to-list 'symbol-names name)
                               (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    ;; If there are matching symbols at point, put them at the beginning of `symbol-names'.
    (let ((symbol-at-point (thing-at-point 'symbol)))
      (when symbol-at-point
        (let* ((regexp (concat (regexp-quote symbol-at-point) "$"))
               (matching-symbols (delq nil (mapcar (lambda (symbol)
                                                     (if (string-match regexp symbol) symbol))
                                                   symbol-names))))
          (when matching-symbols
            (sort matching-symbols (lambda (a b) (> (length a) (length b))))
            (mapc (lambda (symbol) (setq symbol-names (cons symbol (delete symbol symbol-names))))
                  matching-symbols)))))
    (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (push-mark (point))
      (goto-char position))))
