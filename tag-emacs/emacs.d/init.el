;; ~/.emacs.d/init.el
;; Emacs init file
;; Author : Kuzma Ludovic

;;
;; Version : full
;;

;; Check emacs version
(when (< emacs-major-version 27)
  (error "Emacs version 27 or higher is required"))

;;
;; User directories
;;

;; Define user directory
(defconst user-emacs-directory "~/.emacs.d")

;; Define user backup directory
(defconst user-backup-directory
  (concat user-emacs-directory "/backup"))

;; Define user auto save directory
(defconst user-autosave-directory
  (concat user-emacs-directory "/autosave"))

;; Define user semanticdb directory
(defconst user-semanticdb-directory
  (concat user-emacs-directory "/semanticdb"))

;; Define user org directory
(defconst user-org-directory
  (concat user-emacs-directory "/org"))

;; Define user style file
(defconst user-style-file
  (concat user-emacs-directory "/style.el"))

;; Define user key binding file
(defconst user-key-binding-file
  (concat user-emacs-directory "/keys.el"))

;; Define user alias file
(defconst user-alias-file
  (concat user-emacs-directory "/alias.el"))

;; Define user todo file
(defconst user-todo-file
  (concat user-org-directory "/todo.org"))

;; Define user note file
(defconst user-note-file
  (concat user-org-directory "/note.org"))

;; Make user directories

(if (not (file-exists-p user-emacs-directory))
    (make-directory user-emacs-directory))

(if (not (file-exists-p user-backup-directory))
    (make-directory user-backup-directory))

(if (not (file-exists-p user-autosave-directory))
	(make-directory user-autosave-directory))

(if (not (file-exists-p user-semanticdb-directory))
    (make-directory user-semanticdb-directory))

(if (not (file-exists-p user-org-directory))
    (make-directory user-org-directory))

;;
;; Global configuration
;;

;; Always prefer UTF-8
(prefer-coding-system 'utf-8)

;; Always use syntax coloring
(global-font-lock-mode t)

;; Suppress startup screen
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; Custom scratch message and mode
(setq initial-major-mode 'c++-mode)

(setq initial-scratch-message "\
/*
 * Welcome to Emacs
 * Author : Ludovic Kuzma
 * Installed packages :
 * [Global] : org, nlinum, nlinum-hl, dired-subtree
 * [Coding] : function-args, helm, helm-gtags, highlight-doxygen,
 * clang-format
 * [Lang]   : rust-mode, cmake-mode, yaml-mode,
 * markdown-mode, web-mode, csharp-mode
 * Version : 1.10.0-Full
 * Default C/C++ identation : Stroustrup
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
      `((".*" . ,(file-name-as-directory user-backup-directory))))

;; Enable auto save
(setq auto-save-default t)

;; Set auto save file directory
(setq auto-save-file-name-transforms
      `((".*" ,(file-name-as-directory user-autosave-directory) t)))

;; Do not create auto-save-list files and directories
(setq auto-save-list-file-prefix nil)

;; Set default man path
(setq woman-manpath '("/usr/man" "/usr/share/man" "/usr/local/man"))

;;
;; Package configuration
;;

;; On older systems (Debian) gpg is unable to update their elpa keys
;; See http://elpa.gnu.org/packages/gnu-elpa-keyring-update.html
;; We have to disable the signature check in this case
;; (setq package-check-signature nil)

;; Define user packages
(defconst user-packages
  '(helm
	helm-gtags
	function-args
	nlinum
	nlinum-hl
	highlight-doxygen
	org
	rust-mode
	cmake-mode
	yaml-mode
	markdown-mode
	web-mode
	csharp-mode
	dired-subtree
	clang-format))

;; Setup package management
(require 'package)

(add-to-list 'package-archives
			 '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
			 '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
			 '("melpa-stable" . "https://stable.melpa.org/packages/"))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; Auto install needed user package
(mapc
 (lambda (package)
   (unless (package-installed-p package)
     (package-install package)))
 user-packages)

;;
;; Module configuration
;;

;; Setup org
(require 'org)
(setq org-agenda-files (list user-todo-file))

;; Setup semantic
(require 'cedet)
(require 'eieio)
(require 'cc-mode)
(require 'semantic)

(setq semantic-default-save-directory user-semanticdb-directory)

(global-semanticdb-minor-mode t)

(global-semantic-idle-scheduler-mode t)
;; Wait 2 seconds before parsing
(setq semantic-idle-scheduler-idle-time 2)
;; Maximum buffer size (3 MB)
(setq semantic-idle-scheduler-max-buffer-size 3145728)
;; Use idle work to parse files in the same directory
(setq semantic-idle-work-parse-neighboring-files-flag t)

 ;; Semantic bottom summary
(global-semantic-idle-summary-mode t)

(semantic-mode t)

;; Setup helm
(require 'helm)
(require 'helm-config)

(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(setq helm-split-window-in-side-p t)
(setq helm-move-to-line-cycle-in-source t)

(helm-autoresize-mode t)
(helm-mode t)

;; FreeBSD man command workaround for helm man woman
(defvar man-command-args
  (when (string-prefix-p "berkeley" (symbol-name system-type) t)
	"%s"))

(when man-command-args
  (setq helm-man-format-switches man-command-args))

;; Setup helm-gtags
(require 'helm-gtags)

(setq helm-gtags-ignore-case t)
(setq helm-gtags-auto-update t)
(setq helm-gtags-use-input-at-cursor t)
(setq helm-gtags-pulse-at-cursor t)

(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)
(add-hook 'java-mode-hook 'helm-gtags-mode)

;; Setup helm semantic
(require 'helm-semantic)

;; Setup function-args
(require 'function-args)

(setq moo-select-method 'helm)

(add-hook 'c-mode-hook 'turn-on-function-args-mode)
(add-hook 'c++-mode-hook 'turn-on-function-args-mode)

;; Setup clang format
(require 'clang-format)
;; CLang format loads the default style
;; from .clang-format file in one parent directory

;; Setup web-mode
(require 'web-mode)

;; Auto pairing (<?php ?>)
(setq web-mode-enable-auto-pairing t)
;; Auto opening HTML tags
(setq web-mode-enable-auto-opening t)
;; Auto closing HTML tags (<p></p>)
(setq web-mode-enable-auto-closing t)
;; Auto quoting for attributes (attr="")
(setq web-mode-enable-auto-quoting nil)
;; Auto exending (d/ -> <div></div>)
(setq web-mode-enable-auto-expanding nil)

;; Enable gtags for web-mode (PHP, JS)
(add-hook 'web-mode-hook 'helm-gtags-mode)

;; Setup dired
(require 'dired)
(require 'dired-aux)
(require 'dired-subtree)

;; Hide dired details
(add-hook 'dired-mode-hook 'dired-hide-details-mode)
;; Isearch (C-s, C-r) only searches for filenames
(add-hook 'dired-mode-hook 'dired-isearch-filenames-mode)

;; Set maximum recusrsive directory open depth
(setq dired-subtree-cycle-depth 8)

;;
;; Custom files
;;

;; Set c-mode for OpenCL files
(add-to-list 'auto-mode-alist '("\\.cl\\'" . c-mode))

;; Set c++-mode for CUDA, Capnp files
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.capnp\\'" . c++-mode))

;; Set csharp-mode for CS
(add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-mode))

;; Set web-mode for HTML, PHP, JS, JSON, CSS, SCSS
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))

;; Set web-mode for Vue.js files
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))

;; Set org-mode for ORG files
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;;
;; Load external files
;;

;; Load style
(if (file-exists-p user-style-file)
    (load user-style-file))

;; Load custom key bindings
(if (file-exists-p user-key-binding-file)
    (load user-key-binding-file))

;; Load aliases
(if (file-exists-p user-alias-file)
    (load user-alias-file))

;;
;; Custom
;; Only one instance allowed
;; Do not move to external files
;;

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:inherit (shadow default) :foreground "dim gray"))))
 '(nlinum-current-line ((t (:inherit linum :background "lime green" :foreground "black")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(clang-format dired-subtree csharp-mode web-mode markdown-mode yaml-mode cmake-mode rust-mode highlight-doxygen nlinum-hl nlinum function-args helm-gtags helm)))
