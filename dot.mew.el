(setq mew-config-alist
      '(
	(default
	 (mailbox-type          imap)
	 (proto                 "%")
	 (imap-server           "mail.ustc.edu.cn")
	 (imap-user             "hchunhui@mail.ustc.edu.cn")
	 (name                  "Chunhui He")
	 (user                  "hchunhui")
	 (mail-domain           "mail.ustc.edu.cn")
	 (fcc                   "%Sent Items")
	 (imap-delete           t)
	 (imap-queue-folder     "%queue")
	 (imap-trash-folder     "%Trash") ;; This must be in concile with your IMAP box setup
	 (smtp-auth-list        ("PLAIN" "LOGIN" "CRAM-MD5"))
	 (smtp-user             "hchunhui@mail.ustc.edu.cn")
	 (smtp-server           "mail.ustc.edu.cn"))
	))

;; general config for all accounts
(setq mew-summary-reply-with-citation-position 'body)
(setq mew-summary-form-list
      '((t
	 (type (5 date) " |" (25 from) " |" t (45 subj) " |" (0 body)))))
(setq mew-cite-fields '("Date:" "From:"))
(setq mew-cite-format "\nOn %s, %s wrote:\n")
(setq mew-use-unread-mark t)
(setq mew-use-master-passwd t)
