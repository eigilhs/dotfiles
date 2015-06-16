(setq user-mail-address "eigilhs@math.uio.no" 
      user-full-name "Eigil Skjæveland")

(require 'nnir)
(require 'smtpmail)

(setq gnus-select-method
      '(nnimap "uio.no"
               (nnimap-address "imap.uio.no")
               (nnimap-server-port 993)
               (nnimap-stream ssl)
               (nnir-search-engine imap)))

(setq starttls-use-gnutls t
      starttls-gnutls-program "gnutls-cli"
      starttls-extra-arguments '("--insecure"))

(setq message-send-mail-function 'smtpmail-send-it
      send-mail-function 'smtpmail-send-it
      smtpmail-smtp-server "smtp.uio.no"
      smtpmail-default-smtp-server "smtp.uio.no"
      smtpmail-smtp-service 587
      smtpmail-debug-verb t
      smtpmail-debug-info t
      smtpmail-starttls-credentials '(("smtp.uio.no" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.uio.no" 587 "eigilhs" nil)))

(setq message-citation-line-function 'message-insert-formatted-citation-line)
;(setq message-citation-line-format "On %a, %b %d %Y at %r, %f wrote:")
;(setq message-citation-line-format "On %d/%m/%Y at %H:%M:%S, %f wrote:")
(setq message-citation-line-format "On %b %d, %Y at %H:%M, %f wrote:")

;; For BCC-ing myself
(setq gnus-posting-styles
      '((".*"
	 ("BCC" "eigilhs@math.uio.no")
         (address "eigilhs@math.uio.no"))))

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
