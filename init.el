(require 'package)
(require 'ob-plantuml)
(package-initialize)



(ido-mode t)

(transient-mark-mode nil)

;; Org mode items that I like
(global-set-key (kbd "C-C l") 'org-store-link)
(setq org-export-backends
      (quote (md)))
	      
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook (lambda ()
			   (message "It worked")
			   (visual-line-mode t)
			   (org-indent-mode t)))

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


