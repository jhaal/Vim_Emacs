;;############################################################################
(org-babel-load-file(expand-file-name "~/.emacs.d/config.org"))
;;############################################################################
;;FileTree in Emacs
;;############################################################################
(add-to-list 'load-path "/home/user01/.emacs.d/neotree")
(require 'neotree)
(global-set-key [f7] 'neotree-toggle)
(setq neo-smart-open t)
;; save/restore opened files
(desktop-save-mode 1)
;; Toggle comment lines
(global-set-key (kbd "C-/") 'comment-line)
;; change all prompts of yes/no to y/n
(defalias 'yes-or-no-p 'y-or-n-p)
;;############################################################################
;;Load and add MELPA, ELPA, ORG-MODE
;;############################################################################
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
    (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/")t)
(package-initialize)
;; ################################################################
;; Package utility for use-package,which-key,beacon,dashboard etc.
;; It has the added advantage to check and install if package not
;; installed earlier
;; ################################################################
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
;; which-key utility package
(use-package which-key
  :ensure t
  :init
  (which-key-mode))
;; beacon utility package
(use-package beacon
  :ensure t
  :init
  (beacon-mode 2))
;; org-mode-bullets
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
;; Dashboard mode
;;;; (use-package dashboard
 ;; :ensure t
 ;; :config
 ;; (dashboard-setup-startup-hook)
 ;; (setq dashboard-items '((recents . 5)))
 ;; (setq dashboard-banner-logo-title "Alok_Jha"))
;; pop-up-kill-ring
(use-package popup-kill-ring
  :ensure t
  :bind ("M-y" . popup-kill-ring))
(use-package swiper
  :ensure t
  :bind ("C-r" . swiper))
(require 'org-ac) 
(org-ac/config-default)
;; ################################################################
;; multiple cursor
;; ################################################################
(require 'multiple-cursors)
;; for active region spanning multiple lines
(global-set-key (kbd "C-s-M C-s-M") 'mc/edit-lines)
;;When you want to add multiple cursors not based on continuous lines
;; but based on keywords in the buffer, use
(global-set-key (kbd "C-s-z") 'mc/mark-next-like-this)
(global-set-key (kbd "C-s-a") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-s-q") 'mc/mark-all-like-this)
(global-set-key (kbd "C-s-SPC") 'set-rectangular-region-anchor)
(global-set-key (kbd "C-s-<mouse-1>") 'mc/add-cursor-on-click)
;; ################################################################
;; start auto-complete with emacs
;; ################################################################
(require 'auto-complete)
;; default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)
(require 'yasnippet)
(yas-global-mode 1)
;; auto complete initialization for auto-complete-c-headers and c/c++ hooks
(defun my:ac-c-header-init()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/opt/intel/compilers_and_libraries_2018.3.222/linux/ipp/include")
  (add-to-list 'achead:include-directories '"/opt/intel/compilers_and_libraries_2018.3.222/linux/mkl/include")
  (add-to-list 'achead:include-directories '"/opt/intel/compilers_and_libraries_2018.3.222/linux/pstl/include")
  (add-to-list 'achead:include-directories '"/opt/intel/compilers_and_libraries_2018.3.222/linux/tbb/include")
  (add-to-list 'achead:include-directories '"/opt/intel/compilers_and_libraries_2018.3.222/linux/daal/include")
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-linux-gnu/4.9/include")
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-linux-gnu/4.9/include-fixed")
  )
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)
;; add time-stamp to saved file
(add-hook 'before-save-hook 'time-stamp)
;; ###########################################################
;;Solarized theme starts here
;;############################################################
(load-theme 'solarized-dark t)
;; ##########################################################
;;Doom theme application starts here
;;###########################################################
;;(require 'doom-themes)
;;(setq doom-themes-enable-bold t
;;      doom-themes-enable-italic t)
;;(setq doom-font (font-spec :family "Fira Mono":size 14))
;;(load-theme 'doom-molokai t)
;;##########################################################
;;Python language support
;;##########################################################
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)                 ; optional
;;##########################################################
;; smooth scrolling
;;##########################################################
(setq mouse-wheel-scroll-amount '(2 ((shift) . 2))) ;; two lines at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
;;##########################################################
;;Fortran language support
;;##########################################################
(add-hook 'f90-mode-hook 'fortpy-setup)
(setq fortpy-complete-on-percent t)
(setq fortpy-complete-on-bracket t)
;;#########################################################
;;C and C++ language support
;;#########################################################
;;(use-package company
;;	     :ensure t
;;	     :config
;;	     (setq company-idle-delay 0)
;;	     (setq company-minimum-prefix-length 3))

;;(with-eval-after-load 'company
;;  (define-key company-active-map (kbd "M-n") nil)
;;  (define-key company-active-map (kbd "M-p") nil)
;;  (define-key company-active-map (kbd "C-n") #'company-select-next)
;;  (define-key company-active-map (kbd "C-p") #'company-select-previous))

;;(use-package company-irony
;;	     :ensure t
;;	     :config
;;	     (require 'company)
;;	     (add-to-list 'company-backends 'company-irony))

;;(use-package irony
;;	     :ensure t
;;	     :config
;;	     (add-hook 'c++-mode-hook 'irony-mode)
;;	     (add-hook 'c-mode-hook 'irony-mode)
;;	     (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

;;(with-eval-after-load 'company
;;  (add-hook 'c++-mode-hook 'company-mode)
;;  (add-hook 'c-mode-hook 'company-mode))
;;####################################################################
;; shell command redifinition
;; #####################################################################
(global-set-key (kbd "<f5>") 'shell-command)
(setq shell-file-name "/bin/bash")
(global-set-key (kbd "<f6>") 'shell)
(setq ibuffer-expert t)
;;####################################################################
;; Airline -theme Note: It requires Powerline to be installed!!
;;####################################################################
(require 'airline-themes)
(load-theme 'airline-dark t)
(setq airline-display-directory-full t)
;;#####################################################################
;; Header configuration
;; https://www.emacswiki.org/emacs/AutoInsertMode
;;#####################################################################
;; c-mode autoinsert
(auto-insert-mode)
(setq auto-insert-query nil);; if you don't want to be prompted before insertion
(eval-after-load 'autoinsert
  '(define-auto-insert '("\\.c\\'" . "C skeleton")
     '(
       "Short description: "
       "/**====================================================================="\n       
       "\n * "
       (file-name-nondirectory (buffer-file-name))
       \n"*DESCRIPTION:" str \n
       "*AUTHOR: Alok_Jha"\n
       "*E-mail: jhaalok1984_at_gmail.com"\n
       "*ORGANIZATION:NPCIL"\n
       "*VERSION:"\n
       "*REVISION:"\n
       "*CREATED:"(format-time-string "%A, %e %B %Y.")\n
       "*====================================================================="\n       
       "*/" > \n \n
       "#include <stdio.h>" \n
       "int main()" \n
       "{" > \n
       > _ \n
       "}" > \n)))
;; c++ mode autoinsert
(eval-after-load 'autoinsert
  '(define-auto-insert '("\\.\\(CC?\\|cc\\|cxx\\|cpp\\|c++\\)\\'" . "C++ skeleton")
     '(
       "Short description: "
       "/**====================================================================="\n       
       "\n * "
       (file-name-nondirectory (buffer-file-name))
       \n"*DESCRIPTION:" str \n
       "*AUTHOR: Alok_Jha"\n
       "*E-mail: jhaalok1984_at_gmail.com"\n
       "*ORGANIZATION:NPCIL"\n
       "*VERSION:"\n
       "*REVISION:"\n
       "*CREATED:"(format-time-string "%A, %e %B %Y.")\n
       "*====================================================================="\n       
       "*/" > \n \n
       "#include <iostream>" \n
       "using namespace std;" \n \n
       "main()" \n
       "{" \n
       > _ \n
       "}" > \n)))
;; fortran mode auto-insert
(eval-after-load 'autoinsert
  '(define-auto-insert '("\\.\\(f90\\|f95\\|f03\\|for\\|f\\)\\'" . "fortran skeleton")
     '(
       "Short description: "
       "!====================================================================="\n
       "  !"(file-name-nondirectory (buffer-file-name))\n
       "!DESCRIPTION:" str \n
       "!AUTHOR: Alok_Jha"\n
       "!E-mail: jhaalok1984_at_gmail.com"\n
       "!ORGANIZATION:NPCIL"\n
       "!VERSION:"\n
       "!REVISION:"\n
       "!CREATED:"(format-time-string "%A, %e %B %Y.")\n
       "!====================================================================="\n
        \n \n
	)))
;; python mode auto-insert
(eval-after-load 'autoinsert
  '(define-auto-insert '("\\.py\\'" . "python skeleton")
     '(
       "Short description: "
       "#!/home/user01/anaconda3/bin/python3"\n
       "##!/usr/env/python3"\n
       "#====================================================================="\n
       "  #"(file-name-nondirectory (buffer-file-name))\n
       "#DESCRIPTION:" str \n
       "#AUTHOR: Alok_Jha"\n
       "#E-mail: jhaalok1984_at_gmail.com"\n
       "#ORGANIZATION:NPCIL"\n
       "#VERSION:"\n
       "#REVISION:"\n
       "#CREATED:"(format-time-string "%A, %e %B %Y.")\n
       "#===================================================================="\n
       \n \n
       )))
;; #####################################################################
;; template-based headings
;; #####################################################################
;; (auto-insert-mode)
;; (setq auto-insert-directory "~/.emacs.d/templates/")
;; (setq auto-insert-query nil);; if you don't want to be prompted before insertion
;; (define-auto-insert "\.py" "templatepy.py")
;; (define-auto-insert "\.c" "templatec.py")
;; (define-auto-insert "\.cpp" "templatecpp.py")
;; (define-auto-insert "\.f90" "templatefort.py")
;;###################################################################
;; LATEX/AUCTEX settings for emacs
;;###################################################################
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
;; (add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'ac-LaTeX-mode-setup)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode-on t)
;; if the above doesn't work, try
;; (require 'tex)
;; (TeX-global-PDF-mode t)
(require 'ac-math)
(add-to-list 'ac-modes 'latex-mode)
(defun ac-LaTeX-mode-setup () ; add ac-sources to default ac-sources
   (setq ac-sources
         (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
                 ac-sources))
   )
(add-hook 'LaTeX-mode-hook 'ac-LaTeX-mode-setup)
;; https://www.gnu.org/software/auctex/manual/reftex.html#Installation
;; (add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode
(global-auto-complete-mode t)
(setq ac-math-unicode-in-math-p t)
;;###################################################################
;;Default settings/ Factory settings
;;###################################################################
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (org-ac page-break-lines swiper popup-kill-ring org-bullets beacon ac-math auctex auctex-latexmk auto-complete-auctex ace-mc smooth-scrolling auto-complete-c-headers use-package ac-c-headers ac-clang ac-php neotree org-download company-irony company airline-themes yasnippet-snippets smartparens fortpy jedi clues-theme solarized-theme f90-interface-browser))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#002b36" :foreground "#839496" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 129 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
