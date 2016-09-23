(setq user-mail-address "eigilhs@ifi.uio.no"
      user-full-name "Eigil Skjæveland")

(setq gnus-thread-ignore-subject t)

(require 'nnir)
(require 'smtpmail)

(setq gnus-select-method
      '(nnimap "uio.no"
               (nnimap-address "imap.uio.no")
               (nnimap-server-port 993)
               (nnimap-stream ssl)
               (nnir-search-engine imap)))

(add-to-list 'gnus-secondary-select-methods
             '(nnimap "skjaeve.land"
                      (nnimap-address "zx.lc")
                      (nnimap-server-port 993)
                      (nnimap-stream ssl)
                      (nnir-search-engine imap)))
(add-to-list 'gnus-secondary-select-methods
             '(nnimap "edb"
                      (nnimap-address "zx.lc")
                      (nnimap-server-port 993)
                      (nnimap-stream ssl)
                      (nnir-search-engine imap)))
(add-to-list 'gnus-secondary-select-methods
             '(nnimap "zx"
                      (nnimap-address "zx.lc")
                      (nnimap-server-port 993)
                      (nnimap-stream ssl)
                      (nnir-search-engine imap)))

;; (setq starttls-use-gnutls t
;;       starttls-gnutls-program "gnutls-cli"
;;       starttls-extra-arguments '("--insecure"))

(setq message-send-mail-function 'smtpmail-send-it
      send-mail-function 'smtpmail-send-it
      ;; smtpmail-smtp-server "smtp.uio.no"
      ;; smtpmail-default-smtp-server "smtp.uio.no"
      ;; smtpmail-smtp-service 587
      smtpmail-debug-verb t
      smtpmail-debug-info t
      ;; smtpmail-starttls-credentials '(("smtp.uio.no" 587 nil nil))
      ;; smtpmail-auth-credentials '(("smtp.uio.no" 587 "eigilhs" nil))
      )

(defvar smtp-accounts
  '((ssl "eigilhs@ifi.uio.no" "smtp.uio.no"
         587 "eigilhs" nil)
    (ssl "edb@skjaeve.land" "zx.lc"
         465 "edb@skjaeve.land" nil)
    (ssl "eigil@skjaeve.land" "zx.lc"
         465 "eigil@skjaeve.land" nil)
    (ssl "e@zx.lc" "zx.lc"
         465 "e@zx.lc" nil)
    ))

(defun set-smtp (mech server port user password)
  "Set related SMTP variables for supplied parameters."
  (setq smtpmail-smtp-server server smtpmail-smtp-service port
        smtpmail-auth-credentials (list (list server port user
                                              password)) smtpmail-auth-supported (list mech)
                                              smtpmail-starttls-credentials nil)
  (message "Setting SMTP server to `%s:%s' for user `%s'."
           server port user))

(defun set-smtp-ssl (address server port user password &optional key
                            cert)
  "Set related SMTP and SSL variables for supplied parameters."
  (setq starttls-use-gnutls t
        starttls-gnutls-program "gnutls-cli"
        starttls-extra-arguments '("--insecure")
        smtpmail-smtp-server server
        smtpmail-mail-address address
        user-mail-address address
        smtpmail-smtp-service port
        smtpmail-auth-credentials '((server port user nil))
        smtpmail-starttls-credentials '((server port nil nil)))
  (message "Setting SMTP server to `%s:%s' for user `%s'. (SSL enabled.)" server port user))

(defun change-smtp ()
  "Change the SMTP server according to the current from line."
  (save-excursion
    (cl-loop with from = (save-restriction
                           (message-narrow-to-headers)
                           (message-fetch-field "from"))
             for (auth-mech address . auth-spec) in smtp-accounts
             when (string-match address from) do (cond
                                                  ((memq auth-mech '(cram-md5 plain login))
                                                   (cl-return (apply 'set-smtp (cons auth-mech auth-spec))))
                                                  ((eql auth-mech 'ssl)
                                                   (cl-return (apply 'set-smtp-ssl (cons address auth-spec))))
                                                  (t (error "Unrecognized SMTP auth. mechanism: `%s'." auth-mech))) finally (error "Cannot infer SMTP information."))))


(defvar %smtpmail-via-smtp (symbol-function 'smtpmail-via-smtp))

(defun smtpmail-via-smtp (recipient smtpmail-text-buffer)
  (with-current-buffer smtpmail-text-buffer
    (change-smtp))
  (funcall (symbol-value '%smtpmail-via-smtp) recipient
           smtpmail-text-buffer))

(setq message-citation-line-function 'message-insert-formatted-citation-line)
;(setq message-citation-line-format "On %a, %b %d %Y at %r, %f wrote:")
;(setq message-citation-line-format "On %d/%m/%Y at %H:%M:%S, %f wrote:")
(setq message-citation-line-format "On %b %d, %Y at %H:%M, %f wrote:")

;; For BCC-ing myself
(setq gnus-posting-styles
      '((".*"
	 ("BCC" "eigilhs@ifi.uio.no")
         (address "eigilhs@ifi.uio.no"))))

;; For nice display of threads
(when window-system
  (setq gnus-sum-thread-tree-indent "  ")
  (setq gnus-sum-thread-tree-root  "● ")
  (setq gnus-sum-thread-tree-false-root "◯ ")
  (setq gnus-sum-thread-tree-single-indent "◎ ")
  (setq gnus-sum-thread-tree-vertical        "│")
  (setq gnus-sum-thread-tree-leaf-with-other "├─► ")
  (setq gnus-sum-thread-tree-single-leaf     "╰─► "))
(setq gnus-summary-line-format
      (concat
       "%0{%U%R%z%}"
       "%3{│%}" "%1{%d%}" "%3{│%}" ;; date
       "  "
       "%4{%-20,20f%}"               ;; name
       "  "
       "%3{│%}"
       " "
       "%1{%B%}"
       "%s\n"))
(setq gnus-summary-display-arrow t)

(defvar gnus-user-format-function-g-prev "" "")
    (defun empty-common-prefix (left right)
      "Given `left' '(\"foo\" \"bar\" \"fie\") and `right' '(\"foo\"
    \"bar\" \"fum\"), return '(\"   \" \"   \" \"fum\")."
      (if (and (cdr right)   ; always keep the last part of right
    	   (equal (car left) (car right)))
          (cons (make-string (length (car left)) ? )
    	    (empty-common-prefix (cdr left) (cdr right)))
        right))
    (defun gnus-user-format-function-g (arg)
      "The full group name, but if it starts with a previously seen
    prefix, empty that prefix."
 ; line-format is updated on exiting the summary, making prev equal this
      (if (equal gnus-user-format-function-g-prev gnus-tmp-group)
          gnus-tmp-group
        (let* ((prev (split-string-and-unquote gnus-user-format-function-g-prev "\\."))
    	   (this (split-string-and-unquote gnus-tmp-group "\\.")))
          (setq gnus-user-format-function-g-prev gnus-tmp-group)
          (combine-and-quote-strings
           (empty-common-prefix prev this)
           "."))))
    (setq gnus-group-line-format "%M%S%p%P%5y:%B%(%ug%)\n")

(setq mm-discouraged-alternatives '("text/html" "text/richtext"))
