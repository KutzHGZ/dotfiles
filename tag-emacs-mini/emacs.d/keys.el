;; Key binding definition file
;; ~/.emacs.d/keys.el
;; Author : Kuzma Ludovic

;; GLOBAL KEYS

;; Disable C-z in window mode
(if window-system
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

;; HELM MODE KEYS

;; M-x : Use helm to run emacs commands
(global-set-key (kbd "M-x") 'helm-M-x)

;; M-m : Show man page
(global-set-key (kbd "M-m") 'helm-man-woman)

;; C-x C-f : Use helm to find file
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; C-x C-b : Use helm to list buffers
(global-set-key (kbd "C-x C-b") 'helm-mini)
