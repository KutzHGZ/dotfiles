;; ~/.emacs.d/style.el
;; Emacs style definition file
;; Auhtor : Kuzma Ludovic

;;
;; Global configuration
;;

;; Disable bell
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; Disable menubar
(menu-bar-mode -1)

;; Disable menubar, toolbars, tooltips and scrollbars in window mode
(when window-system
    (progn
      (tool-bar-mode -1)
      (tooltip-mode -1)
      (scroll-bar-mode -1)))

;; Display line and column at the bottom
(line-number-mode t)
(column-number-mode t)

;;
;; Colors
;;

;; Set default colors for all frames
(add-to-list 'default-frame-alist '(background-color . "black"))
(add-to-list 'default-frame-alist '(foreground-color . "grey"))
(add-to-list 'default-frame-alist '(cursor-color . "lime green"))

;; Set colors for the main frame
(set-background-color "black")
(set-foreground-color "grey")
(set-cursor-color "lime green")

;; Selection highlight color
(set-face-background 'region "dark blue")

;;
;; Font
;;

(require 'cl)

;; User font list
(defconst user-font-list
  '("DejaVu Sans Mono-10:weigth=normal" ;; Default Linux font
	"DejaVu Sans-10:weight=normal"
	"Consolas-10:weight=normal"
	"Andale Mono-14:weight=normal" ;; Default macOS font
	"Courier-14:weight=normal"))

(defvar default-font nil)

(setq default-font
  (find-if (lambda (ft) (find-font (font-spec :name ft))) user-font-list))

(when (not default-font)
  (when (eq window-system 'x)
	(setq default-font (nth 1 (x-list-fonts "*")))))

(when default-font
  (set-face-attribute 'default nil :font default-font))

;;
;; Identation
;;

;; Use tabs for indentation
(setq-default indent-tabs-mode t)

;; Set tab width to 4 characters
(setq-default tab-width 4)
;; Set the basic offsets to tab-width (4) in order to use tabs for indentation
(setq-default c-basic-offset tab-width)
(setq-default cperl-indent-level tab-width)
;; web-mode offsets (HTML, CSS, [JS, PHP, ...])
(setq web-mode-markup-indent-offset tab-width)
(setq web-mode-css-indent-offset tab-width)
(setq web-mode-code-indent-offset tab-width)
;; Do not add padding inside <script></script>
(setq web-mode-script-padding 0)

;; Default identation for c-mode
(setq c-default-style "stroustrup")
;; (setq c-default-style "k&r")
;; (setq c-default-style "gnu")

;; Indent macros as regular c
;; (c-set-offset (quote cpp-macro) 0 nil)

;; Do not indent namespace {}
(c-set-offset 'innamespace 0)

;; Do not indent extern "C" {}
(c-set-offset 'inextern-lang 0)

;; Ident switch-case labels
(c-set-offset 'case-label '+)

;; Do not ident inline blocks {}
(c-set-offset 'inline-open 0)

;;
;; Alignement
;;

;; Advice align to use only spaces
(defadvice align (around align-spaces activate)
  (let ((indent-tabs-mode nil))
    ad-do-it))

;; Advice align-regexp to use only spaces
(defadvice align-regexp (around align-regexp-spaces activate)
  (let ((indent-tabs-mode nil))
    ad-do-it))

;;
;; White spaces
;;

(require 'whitespace)

;; Highlight above 80 column and trailing spaces
(setq whitespace-style '(face lines-tail trailing))
(setq whitespace-line-column 80)

;; Disable whitespace post processing
;; Increase cursor speed
(defun whitespace-post-command-hook() nil)

(defun disable-whitespace ()
  "Disable whithespace highlight"
  (set (make-local-variable 'whitespace-style) nil))

(defun disable-whitespace-linestail ()
  "Disable whithespace line tail highlight"
  (set (make-local-variable 'whitespace-style) '(face trailing)))

;; Disable whitespace for some major modes
(add-hook 'hexl-mode-hook 'disable-whitespace)
(add-hook 'term-mode-hook 'disable-whitespace)
(add-hook 'eshell-mode-hook 'disable-whitespace)

;; Disable whitespace line tail for some major modes
(add-hook 'text-mode-hook 'disable-whitespace-linestail)
(add-hook 'xml-mode-hook 'disable-whitespace-linestail)
(add-hook 'html-mode-hook 'disable-whitespace-linestail)
(add-hook 'TeX-mode-hook 'disable-whitespace-linestail)
;; Lines tail is not recommanded for PHP, HTML and JS
(add-hook 'web-mode-hook 'disable-whitespace-linestail)

(global-whitespace-mode t)

;;
;; Column line number and highlight
;;

;; Display line number left margin
(require 'nlinum)
(require 'nlinum-hl)

;; Highlight current line
(setq nlinum-highlight-current-line t)

;; (defun disable-nlinum-mode ()
;; 	"Disable nlinum mode when the buffer is to large or contains *"
;; 	(when (or (string-match "*" (buffer-name))
;; 			  (> (buffer-size) 3145728))
;; 	  (nlinum-mode -1)))

;; (add-hook 'c-mode-hook 'disable-nlinum-mode)

(defun disable-nlinum ()
  "Disable nlinum mode"
  (nlinum-mode -1))

;; Disable nlinum for some major modes
;; (add-hook 'text-mode-hook 'disable-nlinum)
(add-hook 'hexl-mode-hook 'disable-nlinum)
(add-hook 'term-mode-hook 'disable-nlinum)
(add-hook 'eshell-mode-hook 'disable-nlinum)

(global-nlinum-mode t)

;; Legacy emacs linum has performance issues
;; (global-linum-mode t)

;;
;; Doxygen highlight
;;

(require 'highlight-doxygen)

;; Enable doxygen highlight for some major modes
(add-hook 'c-mode-hook 'highlight-doxygen-mode)
(add-hook 'c++-mode-hook 'highlight-doxygen-mode)
(add-hook 'java-mode-hook 'highlight-doxygen-mode)
