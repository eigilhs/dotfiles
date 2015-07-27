(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (monokai)))
 '(custom-safe-themes
   (quote
    ("d6e27431f8cafb4a9136aebb1d4061f895b120bf88d34ff60c390d9905bd4e36" "57f8801351e8b7677923c9fe547f7e19f38c99b80d68c34da6fa9b94dc6d3297" "97a2b10275e3e5c67f46ddaac0ec7969aeb35068c03ec4157cf4887c401e74b1" "0e121ff9bef6937edad8dfcff7d88ac9219b5b4f1570fd1702e546a80dba0832" "941bc214a26ed295e68bbeaadcd279475a3d6df06ae36b0b2872319d58b855f7" default)))
 '(inhibit-startup-screen t))
;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
;;)


;; ===== Automatically load abbreviations table =====
;; Note that emacs chooses, by default, the filename
;; "~/.abbrev_defs", so don't try to be too clever
;; by changing its name

(scroll-bar-mode -1)
(when window-system
  (tooltip-mode -1)
  (tool-bar-mode -1))
(menu-bar-mode -1)

(setq-default abbrev-mode t)
(read-abbrev-file "~/.abbrev_defs")
(setq save-abbrevs t)

;; ===== Set the highlight current line minor mode =====
;;(global-hl-line-mode 1)

;; ========== Line by line scrolling ==========
(setq scroll-step 1)

;; ===== Set standard indent to 2 rather that 4 ====
(setq standard-indent 4)

;; ========== Place Backup Files in Specific Directory ==========
;; Enable backup files.
(setq make-backup-files t)
;; Enable versioning with default values (keep five last versions, I think!)
(setq version-control t)
;; Save all backup file in this directory.
(setq backup-directory-alist (quote ((".*" . "/tmp/"))))

;; ========== Enable Line and Column Numbering ==========
;; Show line-number in the mode line
(line-number-mode 1)
;; Show column-number in the mode line
(column-number-mode 1)

(setq tramp-default-method "rsync")

(fset 'yes-or-no-p 'y-or-n-p)
(show-paren-mode t)
(global-linum-mode 1)
(setq linum-format "%d ")

;;(load-theme 'tango-dark t)
;(require 'color-theme)
;(color-theme-initialize)
;(color-theme-billw)
;;(color-theme-blippblopp)

;;(require 'python-mode)
;;(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;;(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(autoload 'python-mode "python" nil t)

(setq browse-url-browser-function 'browse-url-chromium)
(setq-default frame-title-format (list "%b %f"))

(require 'whitespace)
(global-set-key "\C-c_w" 'whitespace-mode)
(prefer-coding-system      'utf-8)
(add-to-list 'load-path "~/emacs.d/")

;; ===== Turn off tab character =====
;; Use (setq ...) to set value locally to a buffer
;; Use (setq-default ...) to set value globally
(setq-default indent-tabs-mode nil)

;; Go bits. 
;;(require 'go-mode-load)
;;(add-hook 'before-save-hook #'gofmt-before-save)
;;(add-hook 'go-mode-hook (lambda () (setq indent-tabs-mode nil)))
;;(add-hook 'go-mode-hook (lambda () (setq tab-width 4)))

(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use 120 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
;;    (if (> (x-display-pixel-width) 1280)
;;           (add-to-list 'default-frame-alist (cons 'width 120))
;;           (add-to-list 'default-frame-alist (cons 'width 80)))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist 
         (cons 'height (/ (- (x-display-pixel-height) 100)
                             (frame-char-height)))))))

(add-hook 'c-mode-hook 'fci-mode)
(add-hook 'python-mode-hook 'fci-mode)
(setq fci-rule-color "red")
(setq fci-rule-column 72)

(add-to-list 'load-path "~/.emacs.d/plugins/")
(require 'ido)
(ido-mode t)

(autoload 'notmuch "notmuch" "notmuch mail" t)
(require 'undoc)
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "<menu>") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(load-theme 'monokai t)

(require 'multiple-cursors)
;; Experimental multiple-cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-S-c C-e") 'mc/edit-ends-of-lines)
(global-set-key (kbd "C-S-c C-a") 'mc/edit-beginnings-of-lines)
;; Mark additional regions matching current region
(global-set-key (kbd "M-æ") 'mc/mark-all-dwim)
(global-set-key (kbd "C-å") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-æ") 'mc/mark-next-like-this)
(global-set-key (kbd "C-Æ") 'mc/mark-more-like-this-extended)
(global-set-key (kbd "M-å") 'mc/mark-all-in-region)
;; Symbol and word specific mark-more
(global-set-key (kbd "s-æ") 'mc/mark-next-word-like-this)
(global-set-key (kbd "s-å") 'mc/mark-previous-word-like-this)
(global-set-key (kbd "M-s-æ") 'mc/mark-all-words-like-this)
(global-set-key (kbd "s-Æ") 'mc/mark-next-symbol-like-this)
(global-set-key (kbd "s-Å") 'mc/mark-previous-symbol-like-this)
(global-set-key (kbd "M-s-Æ") 'mc/mark-all-symbols-like-this)
;; Extra multiple cursors stuff
(global-set-key (kbd "C-~") 'mc/reverse-regions)
(global-set-key (kbd "M-~") 'mc/sort-regions)
(global-set-key (kbd "C-#") 'mc/insert-numbers)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
;; Set anchor to start rectangular-region-mode
(global-set-key (kbd "C- ") 'set-rectangular-region-anchor)


(set-frame-size-according-to-resolution)
(global-set-key (kbd "S-<f9>") 'backward-kill-word)
(global-set-key (kbd "<f6>") 'smex)
(global-set-key "\M-[1;5C" 'forward-word)
(global-set-key "\M-[1;5D" 'backward-word)
(global-set-key "\M-[1;5A" 'backward-paragraph)
(global-set-key "\M-[1;5B" 'forward-paragraph)
;(global-set-key "\M-H[3~" 'forward-paragraph)

;; simple regexp used to check the message. Tweak to your own need.
;; (defvar my-message-attachment-regexp "\\([Ww]e send\\|[Ii] send\\|attach\\)")
(defvar my-message-attachment-regexp "\\([Vv]edlagt\\|[Vv]edlegg\\)")
;; the function that checks the message
(defun my-message-check-attachment nil
  "Check if there is an attachment in the message if I claim it."
  (save-excursion
    (message-goto-body)
    (when (search-forward-regexp my-message-attachment-regexp nil t nil)
      (message-goto-body)
      (unless (or (search-forward "<#part" nil t nil)
  		  (message-y-or-n-p
                   "No attachment. Send the message ?" nil nil))
  	(error "No message sent")))))
;; check is done just before sending the message
(add-hook 'message-send-hook 'my-message-check-attachment)
