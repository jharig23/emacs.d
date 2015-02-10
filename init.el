

(add-to-list 'load-path "~/.emacs.d/htmlize")
(add-to-list 'load-path "~/.emacs.d/plantuml-mode")

(setq org-ditaa-jar-path "/usr/bin/ditaa")
(setq org-plantuml-jar-path "~/.emacs.d/plantuml-jar-mit-8018/plantuml.jar")
(setq plantuml-jar-path
      (expand-file-name "~/.emacs.d/plantuml-jar-mit-8018/plantuml.jar"))


(require 'htmlize)
(require 'plantuml-mode)

(ido-mode t)

(transient-mark-mode nil)

;; Org mode items that I like
(global-set-key (kbd "C-C l") 'org-store-link)
(setq org-export-backends
      (quote (md)))
	      
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook (lambda ()
			   (visual-line-mode t)
			   (org-indent-mode t)))

;; Setup babel code evaluations
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (ruby . t)
   (ditaa . t)
   (dot . t)
   (sh . t)
   (plantuml . t)))

(defun my-org-confirm-babel-evaluate (lang body)
  (not (string= lang "plantuml"))) 

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


