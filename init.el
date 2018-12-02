;;; init.el --- Emacs configuration

;;; Commentary:
;; Trying to create a clean Emacs configuration

;;; Code:

;; No splash screen
(setq inhibit-splash-screen t)

;; More space for text
(menu-bar-mode 0)
(tool-bar-mode 0)

;; Use MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; Low contrast theme
(load-theme 'zenburn t)

;; Better looking mode line
(require 'powerline)
(powerline-default-theme)

;; Activate flycheck for elisp.
(require 'flycheck)
(add-hook 'emacs-lisp-mode 'flycheck-mode)

;; Activate flyspell mode for comments and strings
(flyspell-prog-mode)

;; Git commit mode
(require 'git-commit)

;; Text mode hook
(defun my-text-mode-hook ()
  "Improve the text mode."
  (turn-on-auto-fill)
  (flyspell-mode)
  (add-to-list (make-local-variable 'company-backends) 'company-ispell))
(add-hook 'text-mode-hook 'my-text-mode-hook)
;; Nxml mode is bizarrely based on text mode, but auto-fill is disturbing there.
(add-hook 'nxml-mode-hook 'turn-off-auto-fill)

;; Activate global company-mode
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-show-numbers t)

;; Change ispell language to English
(defun my-change-language-to-english ()
  "Change the language to English for Ispell."
  (interactive)
  (ispell-change-dictionary "en")
  (defvar company-ispell-dictionary)
  (setq company-ispell-dictionary (file-truename "~/.emacs.d/dict/british-english")))

(defun my-change-language-to-french ()
  "Change the language to French for Ispell."
  (interactive)
  (ispell-change-dictionary "fr")
  (defvar company-ispell-dictionary)
  (setq company-ispell-dictionary (file-truename "~/.emacs.d/dict/french")))

(defun my-change-language-to-swedish ()
  "Change the language to Swedish for Ispell."
  (interactive)
  (ispell-change-dictionary "sv")
  (defvar company-ispell-dictionary)
  (setq company-ispell-dictionary (file-truename "~/.emacs.d/dict/swedish")))

(defun my-automatic-code-block-confirm-in-org-mode ()
  "Automatically confirm code block evaluation in org mode."
  (interactive)
  (defvar org-confirm-babel-evaluate)
  (setq org-confirm-babel-evaluate nil))

;; Activate Ivy mode
(require 'ivy)
(ivy-mode 1)
(counsel-mode 1)
(setq ivy-count-format "(%d/%d) ")
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

;; Activate elpy
(elpy-enable)

;; Smart tabs
(smart-tabs-insinuate 'c 'c++)

;; C and C++ settings
(require 'cc-vars)
(setq c-default-style "linux")

;; C++ settings
(add-hook 'c++-mode-hook (lambda () (setq comment-start "/* " comment-end   " */")))
(add-hook 'c++-mode-hook (lambda () (c-set-offset 'innamespace [0])))

;; Detect C/C++ for h files
(defun c-c++-header ()
  "Set either 'c-mode' or 'c++-mode', whichever is appropriate for header."
  (interactive)
  (let ((c-file (concat (substring (buffer-file-name) 0 -1) "c")))
    (if (file-exists-p c-file)
        (c-mode)
      (c++-mode))))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-c++-header))

;; Configure eglot for C and C++
(add-to-list 'load-path "~/.emacs.d/github/eglot/")
(require 'eglot)
(add-to-list 'eglot-server-programs '(c-mode . ("ccls")))
(add-to-list 'eglot-server-programs '(c++-mode . ("ccls")))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

;; Configure Yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; Close parentheses
(electric-pair-mode 1)

;; Ivy keyboard shortcuts
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "<f11>") 'counsel-imenu)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;; Flymake shortcuts
(define-key flymake-mode-map (kbd "M-n") 'flymake-goto-next-error)
(define-key flymake-mode-map (kbd "M-p") 'flymake-goto-prev-error)

;; General keyboard shortcuts
(global-set-key [f7] 'compile)
(global-set-key [f8] 'recompile)
(global-set-key [f9] 'previous-error)
(global-set-key [f10] 'next-error)
(global-set-key [f12] 'kill-this-buffer)

(provide 'init)

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(yasnippet-classic-snippets zenburn-theme smart-tabs-mode powerline git-commit flycheck elpy counsel cmake-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
