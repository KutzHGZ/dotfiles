;; Emacs style definition file
;; ~/.emacs.d/style.el
;; Auhtor : Kuzma Ludovic

;; COLOR AND INDENTING

;; Colors
(set-background-color "black")
(set-foreground-color "grey")
(set-cursor-color "lime green")

;; Selection highlight color
(set-face-background 'region "dark blue")

;; Default fonts
(defconst user-font-list
  '("DejaVu Sans Mono-10:weigth=normal"
    "DejaVu Sans-10:weight=normal"
    "Consolas-10:weight=normal"
    "Courier-10:weight=normal"))

(defvar default-font nil)

(require 'cl)
(setq default-font
  (find-if (lambda (ft) (find-font (font-spec :name ft))) user-font-list))

(if (eq window-system 'x)
    (when (not default-font)
      (setq default-font (nth 1 (x-list-fonts "*")))))

(set-face-attribute 'default nil :font default-font)

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

;; Highlight above 80 column and trailing spaces
(require 'whitespace)
(global-whitespace-mode t)
(setq whitespace-style '(face lines-tail trailing))

;; Suppress whitespace trailing spaces cursor slow down
(defun whitespace-post-command-hook() nil)

;; Display column
(setq column-number-mode t)

;; Display line
(global-linum-mode 1)

;; Disable menubar
(menu-bar-mode -1)

;; Disable toolbars, tooltips and scrollbars in window mode
(if window-system
    (progn
      (tool-bar-mode -1)
      (tooltip-mode -1)
      (scroll-bar-mode -1)))
