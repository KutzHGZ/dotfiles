;; Emacs style definition file
;; ~/.emacs.d/style.el
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

;;
;; Colors
;;

(set-background-color "black")
(set-foreground-color "grey")
(set-cursor-color "lime green")

;; Selection highlight color
(set-face-background 'region "dark blue")

;;
;; Font
;;

;; User font
(defconst user-font-list
  '("DejaVu Sans Mono-10:weigth=normal"
    "DejaVu Sans-10:weight=normal"
    "Consolas-10:weight=normal"
    "Courier-10:weight=normal"))

(defvar default-font nil)

(require 'cl)

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

;; Use tabs for indent
(setq-default indent-tabs-mode t)

;; Set tab width
(setq-default tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

;; Default ident for c-mode
(setq c-default-style "k&r")
;; (setq c-default-style "gnu")

;; Ident macros as regular c
;; (c-set-offset (quote cpp-macro) 0 nil)

;; Do not ident namespace {}
(c-set-offset 'innamespace 0)

;; Do not ident extern "C" {}
(c-set-offset 'inextern-lang 0)

;; Ident with case label
(c-set-offset 'case-label '+)

(require 'whitespace)

;; Highlight above 80 column and trailing spaces
(setq whitespace-style '(face lines-tail trailing))

;; Disable whitespace post processing
;; Increase cursor speed
(defun whitespace-post-command-hook() nil)

(global-whitespace-mode t)

;; Display line and column at the bottom
(line-number-mode t)
(column-number-mode t)

;; Display line number left margin
(require 'nlinum)
(require 'nlinum-hl)

;; Highlight current line
(setq nlinum-highlight-current-line t)

(global-nlinum-mode t)

;; Legacy emacs linum has performance issues
;;(global-linum-mode t)

