(server-start)

(add-to-list 'load-path "~/.emacs.d/htmlize")
(add-to-list 'load-path "~/.emacs.d/plantuml-mode")
(add-to-list 'load-path "~/.emacs.d/groovy-emacs-modes")

(setq org-ditaa-jar-path "/usr/bin/ditaa")
(setq org-plantuml-jar-path "~/.emacs.d/plantuml-jar-mit-8018/plantuml.jar")
(setq plantuml-jar-path
      (expand-file-name "~/.emacs.d/plantuml-jar-mit-8018/plantuml.jar"))


(require 'htmlize)
(require 'plantuml-mode)
(require 'groovy-mode)
(ido-mode t)

(transient-mark-mode nil)

;; Open File at point keybinding
(global-set-key (kbd "C-x g") 'find-file-at-point)

;; Org mode items that I like
(global-set-key (kbd "C-C l") 'org-store-link)

(setq org-export-backends
      '(ascii html icalendar latex md))
	      
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook (lambda ()
			   (visual-line-mode t)
			   (org-indent-mode t)
			   (define-key org-mode-map (kbd "M-s <up>") 'org-table-kill-row)))

;; Setup babel code evaluations
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (ruby . t)
   (java . t)
   (ditaa . t)
   (dot . t)
   (sh . t)
   (plantuml . t)))

(defun my-org-confirm-babel-evaluate (lang body)
  (not (or
	(string= lang "plantuml")
	(string= lang "ditaa")
	))
  )
  

(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(org-startup-truncated nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(defun my-org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (setq filename
        (concat
         (make-temp-name
          (concat (buffer-file-name)
                  "_"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (call-process "import" nil nil nil filename)
  (insert (concat "[[" filename "]]")))


(defun pretty-print-xml-region (begin end)
  "Pretty format XML markup in region. You need to have nxml-mode
http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do
this.  The function inserts linebreaks to separate tags that have
nothing but whitespace between them.  It then indents the markup
by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
      (nxml-mode)
      (goto-char begin)
      (while (search-forward-regexp "\>[ \\t]*\<" nil t) 
        (backward-char) (insert "\n"))
      (indent-region begin end))
    (message "Ah, much better!"))
