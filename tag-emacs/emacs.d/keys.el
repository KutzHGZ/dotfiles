;; ~/.emacs.d/keys.el
;; Key binding definition file
;; Author : Kuzma Ludovic

;;
;; Global
;;

;; Disable C-z in window mode
(when window-system
    (global-unset-key (kbd "C-z")))

;; C-c <space> : select all the current buffer
(global-set-key (kbd "C-c SPC") 'mark-whole-buffer)

;; C-c g : goto line
(global-set-key (kbd "C-c g") 'goto-line)

;; M-<up>/M-<down> : Move to prev/next function
(global-set-key (kbd "M-<up>") '(lambda () (interactive)
				  (beginning-of-defun 1)))

(global-set-key (kbd "M-<down>") '(lambda () (interactive)
				    (beginning-of-defun -1)))

;; M-<left>/M-<right> : Move to prev/next list
(global-set-key (kbd "M-<left>") 'backward-list)
(global-set-key (kbd "M-<right>") 'forward-list)

;; C-c a : goto the begin of the function
(global-set-key (kbd "C-c a") 'beginning-of-defun)

;; C-c e : goto the end of the function
(global-set-key (kbd "C-c e") 'end-of-defun)

;; C-c c : comment region
(global-set-key (kbd "C-c c") 'comment-region)

;; C-c u : uncomment region
(global-set-key (kbd "C-c u") 'uncomment-region)

;; C-c r : replace string
(global-set-key (kbd "C-c r") 'replace-string)

;; C-c C-d : change working directory
(global-set-key (kbd "C-c d") 'cd)

;; C-c t : open a terminal
(global-set-key (kbd "C-c t") 'term)

;; C-c p : list packages
(global-set-key (kbd "C-c p") 'list-packages)

;; C-c s : delete trailing white space
(global-set-key (kbd "C-c s") 'delete-trailing-whitespace)

;;
;; Org mode
;;

;; M-T : Open todo file
(global-set-key (kbd "M-T") '(lambda () (interactive)
			       (find-file user-todo-file)))

;; M-N : Open note file
(global-set-key (kbd "M-N") '(lambda () (interactive)
			       (find-file user-note-file)))

;; M-O : Open org agenda
;; Incompatible with Putty terminal
;; (global-set-key (kbd "M-O") 'org-agenda)

;;
;; Helm mode
;;

;; M-x : Use helm to run emacs commands
(global-set-key (kbd "M-x") 'helm-M-x)

;; M-m : Show man page
(global-set-key (kbd "M-m") 'helm-man-woman)

;; C-x C-f : Use helm to find file
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; C-x b : Use helm to list buffers
(global-set-key (kbd "C-x b") 'helm-mini)
;; C-x C-b : Legacy emacs list buffers
(global-set-key (kbd "C-x C-b") 'switch-to-buffer)

;; M-q : List semantic tags
(define-key helm-gtags-mode-map (kbd "M-q") 'helm-semantic)

;; M-s t : List tags
(define-key helm-gtags-mode-map (kbd "M-s t") 'helm-gtags-select)

;; M-s f : List tags in this function
(define-key helm-gtags-mode-map (kbd "M-s f") 'helm-gtags-tags-in-this-function)

;; M-s s : Find symbol
(define-key helm-gtags-mode-map (kbd "M-s s") 'helm-gtags-find-symbol)

;; M-s l : Show stack
(define-key helm-gtags-mode-map (kbd "M-s l") 'helm-gtags-show-stack)

;; M-s c : Clear stack
(define-key helm-gtags-mode-map (kbd "M-s c") 'helm-gtags-clear-stack)

;; M-. : Find references and push to stack
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)

;; M-? : Pop stack
(define-key helm-gtags-mode-map (kbd "M-?") 'helm-gtags-pop-stack)

;; Restore the old left, right arrow key behavior of helm

(define-key helm-map (kbd "<left>") 'helm-previous-source)
(define-key helm-map (kbd "<right>") 'helm-next-source)

(customize-set-variable 'helm-ff-lynx-style-map t)
(customize-set-variable 'helm-imenu-lynx-style-map t)
(customize-set-variable 'helm-semantic-lynx-style-map t)
(customize-set-variable 'helm-occur-use-ioccur-style-keys t)
(customize-set-variable 'helm-grep-use-ioccur-style-keys t)

;;
;; Functions-args mode
;;

;; C-: : Completion with function-args and helm
(define-key c-mode-map (kbd "C-:") 'moo-complete)
(define-key c++-mode-map (kbd "C-:") 'moo-complete)

;;
;; Clang format
;;

;; backtab : Clang format region
(global-set-key (kbd "<backtab>") 'clang-format-region)

