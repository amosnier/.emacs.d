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
(package-initialize)
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; Low contrast theme
(load-theme 'zenburn t)

;; Better looking mode line
(require 'powerline)
(powerline-default-theme)

;; Activate flymake for elisp.
(require 'flymake)
(add-hook 'emacs-lisp-mode 'flymake-mode)

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

;; Activate Ivy mode
(require 'ivy)
(ivy-mode 1)
(counsel-mode 1)
(setq ivy-count-format "(%d/%d) ")
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

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

;; HTML settings
(add-hook 'html-mode-hook (lambda () (setq tab-width 2)))
(add-hook 'html-mode-hook (lambda () (setq indent-tabs-mode t)))

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
