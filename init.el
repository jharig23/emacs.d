
(server-start)

(require 'package)
(add-to-list
 'package-archives
 '("melpa" . "http://melpa.org/packages/")
 t)

(package-initialize)


(require 'git)
(elpy-enable)
(show-paren-mode 1)
(setq show-paren-delay 0)
(column-number-mode 1)


(require 'highlight-symbol)
(global-set-key [(control f3)] 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)

;; This needs work
;; (global-set-key (kbd "C-x o") 'switch-window)


(setq tab-width 4)
(setq-default tab-width 4)
(setq indent-tabs-mode nil)
(setq-default indent-tabs-mode nil)

(setq nxml-child-indent 2)

(add-to-list 'load-path "~/.emacs.d/htmlize")
(add-to-list 'load-path "~/.emacs.d/plantuml-mode")
(add-to-list 'load-path "~/.emacs.d/groovy-emacs-modes")

(setq org-ditaa-jar-path "/usr/bin/ditaa")
(setq org-plantuml-jar-path "~/.emacs.d/plantuml-jar-mit-8018/plantuml.jar")
(setq plantuml-jar-path
      (expand-file-name "~/.emacs.d/plantuml-jar-mit-8018/plantuml.jar"))

;; PYTHON THINGS
(add-hook 'python-mode-hook
	  (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))
(add-hook 'python-mode-hook (lambda ()
			      (require 'sphinx-doc)
			      (sphinx-doc-mode t)))



(require 'htmlize)
(require 'plantuml-mode)
(require 'groovy-mode)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

(autoload `markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)

(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(ido-mode t)

(transient-mark-mode nil)

(defun revert-buffer-no-confirm ()
    "Revert buffer without confirmation."
    (interactive)
    (revert-buffer t t))

;; Open File at point keybinding
(global-set-key (kbd "C-x g") 'find-file-at-point)
(global-set-key (kbd "<f5>") 'revert-buffer-no-confirm)
;; Org mode items that I like
(global-set-key (kbd "C-C l") 'org-store-link)

(setq org-export-backends
      '(ascii html icalendar latex md))

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook (lambda ()
			   (visual-line-mode t)
			   (org-indent-mode t)
			   (define-key org-mode-map (kbd "M-s <up>") 'org-table-kill-row)))

;; Resize windows keybindings
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
    (global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
    (global-set-key (kbd "S-C-<down>") 'shrink-window)
    (global-set-key (kbd "S-C-<up>") 'enlarge-window)

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


(require 'hideshow)
(require 'sgml-mode)
(require 'nxml-mode)

(add-to-list 'hs-special-modes-alist
             '(nxml-mode
               "<!--\\|<[^/>]*[^/]>"
               "-->\\|</[^/>]*[^/]>"

               "<!--"
               sgml-skip-tag-forward
               nil))



(add-hook 'nxml-mode-hook 'hs-minor-mode)

;; optional key bindings, easier than hs defaults
(define-key nxml-mode-map (kbd "C-c h") 'hs-toggle-hiding)
