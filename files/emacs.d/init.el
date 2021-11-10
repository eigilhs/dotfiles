(when window-system
  (load-theme 'wombat t)
  (scroll-bar-mode -1)
  (tooltip-mode -1)
  (tool-bar-mode -1)
  (display-line-numbers-mode 1)
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

(require 'lsp-mode)
(define-derived-mode bicep-mode
  js-mode "Bicep"
  "Major mode for bicep."
  (setq js-indent-level 2)
  (setq lsp-semantic-tokens-enable t)
  (lsp))
(add-to-list 'auto-mode-alist '("\\.bicep\\'" . bicep-mode))
(add-to-list 'lsp-language-id-configuration '(bicep-mode . "bicep"))
(lsp-register-client
 (make-lsp-client
  :new-connection (lsp-stdio-connection '("dotnet"
                                          "/home/eigil/.local/share/bicep-langserver/Bicep.LangServer.dll"))
  :activation-fn (lsp-activate-on "bicep")
  :priority -1
  :server-id 'bicep-ls))
