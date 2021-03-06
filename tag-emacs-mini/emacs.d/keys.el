;; ~/.emacs.d/keys.el
;; Key binding definition file
;; Author : Kuzma Ludovic

;; In order to show the current keybing of emacs you can use :
;; M-x describe-key <macro>

;;
;; Global
;;

;; Disable C-z in window mode
(if window-system
    (global-unset-key (kbd "C-z")))

;; Disable right alt meta bind
;; Useful on macOS in order to use Alt Gr on a PC keybord
(setq ns-right-alternate-modifier 'none)

;; C-<tab> : align the current region
(global-set-key (kbd "C-<tab>") 'align-current)

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

;; C-<left>/C-<right> : Move to prev/next paragraph
(global-set-key (kbd "C-<up>") 'backward-paragraph)
(global-set-key (kbd "C-<down>") 'forward-paragraph)

;; C-<left>/C-<right> : Move to prev/next word
(global-set-key (kbd "C-<left>") 'left-word)
(global-set-key (kbd "C-<right>") 'right-word)

;; M-</M-> : Move to beginning/end of buffer
(global-set-key (kbd "M-<") 'beginning-of-buffer)
(global-set-key (kbd "M->") 'end-of-buffer)

;; C-a/C-e : Move to beginning/end of line
(global-set-key (kbd "C-a") 'move-beginning-of-line)
(global-set-key (kbd "C-e") 'move-end-of-line)

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
;; Helm mode
;;

;; M-x : Use helm to run emacs commands
(global-set-key (kbd "M-x") 'helm-M-x)

;; M-m : Show man page
(global-set-key (kbd "M-m") 'helm-man-woman)

;; C-x C-f : Use helm to find file
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; C-x C-b : Use helm to list buffers
(global-set-key (kbd "C-x b") 'helm-mini)
;; C-x C-b : Legacy emacs list buffers
(global-set-key (kbd "C-x C-b") 'switch-to-buffer)

;; Restore the old left, right arrow key behavior of helm

(define-key helm-map (kbd "<left>") 'helm-previous-source)
(define-key helm-map (kbd "<right>") 'helm-next-source)

(customize-set-variable 'helm-ff-lynx-style-map t)
(customize-set-variable 'helm-imenu-lynx-style-map t)
(customize-set-variable 'helm-semantic-lynx-style-map t)
(customize-set-variable 'helm-occur-use-ioccur-style-keys t)
(customize-set-variable 'helm-grep-use-ioccur-style-keys t)
