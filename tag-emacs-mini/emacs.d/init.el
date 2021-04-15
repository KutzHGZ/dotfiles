;; ~/.emacs.d/init.el
;; Emacs init file
;; Author : Kuzma Ludovic

;;
;; Version : basic
;;

;; Check emacs version
(if (< emacs-major-version 27)
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

;; Define user style file
(defconst user-style-file
  (concat user-emacs-directory "/style.el"))

;; Define user key binding file
(defconst user-key-binding-file
  (concat user-emacs-directory "/keys.el"))

;; Define user alias file
(defconst user-alias-file
  (concat user-emacs-directory "/alias.el"))

;; Make user directories

(if (not (file-exists-p user-emacs-directory))
    (make-directory user-emacs-directory))

(if (not (file-exists-p user-backup-directory))
    (make-directory user-backup-directory))

(if (not (file-exists-p user-autosave-directory))
	(make-directory user-autosave-directory))

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
 * Configuration author : Ludovic Kuzma
 * Installed packages : helm, nlinum, nlinum-hl,
 * yaml-mode, markdown-mode
 * Version : 1.2.0-Basic
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

;; Define user packages
(defconst user-packages
  '(helm
	nlinum
	nlinum-hl
	yaml-mode
	markdown-mode))

;; Setup package management
(require 'package)

(add-to-list 'package-archives
	     '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;;
;; Module configuration
;;

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

(helm-autoresize-mode t)
(helm-mode t)

;; FreeBSD man command workaround for helm man woman
(defvar man-command-args
  (when (string-prefix-p "berkeley" (symbol-name system-type) t)
	"%s"))

(when man-command-args
  (setq helm-man-format-switches man-command-args))

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
 '(package-selected-packages '(markdown-mode yaml-mode nlinum-hl nlinum helm)))
