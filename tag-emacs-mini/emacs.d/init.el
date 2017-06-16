;; Emacs init file
;; ~/.emacs.d/init.el
;; Author : Kuzma Ludovic

;;
;; Version : basic
;;

;; Check emacs version
(if (< emacs-major-version 24)
    (error "Emacs version 24 or higher is required"))

;; Define user directory
(defconst user-emacs-directory "~/.emacs.d")

;; Define user backup directory
(defconst user-backup-directory
  (concat user-emacs-directory "/backup"))

;; Define user style file
(defconst user-style-file
  (concat user-emacs-directory "/style.el"))

;; Define user key binding file
(defconst user-key-binding-file
  (concat user-emacs-directory "/keys.el"))

;; Define user alias file
(defconst user-alias-file
  (concat user-emacs-directory "/alias.el"))

;; Define user packages
(defconst user-packages
  '(helm))

;; Make directory
(if (not (file-exists-p user-emacs-directory))
    (make-directory user-emacs-directory))

(if (not (file-exists-p user-backup-directory))
    (make-directory user-backup-directory))

;; Always prefer UTF-8
(prefer-coding-system 'utf-8)

;; Always use syntax coloring
(global-font-lock-mode t)

;; Suppress startup screen
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; Custom scratch message and mode
(setq initial-major-mode 'c-mode)

(setq initial-scratch-message "\
/*
 * Welcome to Emacs
 * Configuration author : Ludovic Kuzma
 * Installed packages : helm
 * Version : Basic
 * Default c identation : k&r
 */
")

;; Enable backup file
(setq make-backup-files t)

;; Preserve hard links to the file
(setq backup-by-copying-when-linked t)

;; Preserve owner and group of the file
(setq backup-by-copying-when-mismatch t)

;; Set backup files directory
(setq backup-directory-alist
      `((".*" . ,user-backup-directory)))

;; Set auto save file directory
(setq auto-save-file-name-transforms
      `((".*" ,user-backup-directory t)))

;; Setup package management
(require 'package)

(add-to-list 'package-archives
	     '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
	     '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; Auto install needed user package
(mapc
 (lambda (package)
   (unless (package-installed-p package)
     (package-install package)))
 user-packages)

;; Setup helm
(require 'helm)
(require 'helm-config)

(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(setq helm-split-window-in-side-p t)
(setq helm-move-to-line-cycle-in-source t)

(helm-autoresize-mode 1)
(helm-mode 1)

;; Load style
(if (file-exists-p user-style-file)
    (load user-style-file))

;; Load custom key bindings
(if (file-exists-p user-key-binding-file)
    (load user-key-binding-file))

;; Load aliases
(if (file-exists-p user-alias-file)
    (load user-alias-file))
