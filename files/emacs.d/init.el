(when window-system
  (load-theme 'wombat t)
  (scroll-bar-mode -1)
  (tooltip-mode -1)
  (tool-bar-mode -1)
  (global-linum-mode 1)
  (setq linum-format "%d "
	frame-title-format (list "%b %f")))

(setq inhibit-startup-screen t
      scroll-step 1
      scroll-margin 2
      sentence-end-double-space nil
      c-default-style "linux"
      custom-file (expand-file-name "custom.el" user-emacs-directory))

(menu-bar-mode -1)
(line-number-mode 1)
(column-number-mode 1)
(show-paren-mode t)
(fset 'yes-or-no-p 'y-or-n-p)

(setq backup-directory-alist `(("." . ,(expand-file-name "backups" user-emacs-directory)))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(add-to-list 'package-archives
  '("melpa" . "https://melpa.org/packages/") t)

(load custom-file :noerror)
