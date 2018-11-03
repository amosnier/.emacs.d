;;; init.el --- Emacs configuration

;;; Commentary:
;; Trying to create a clean Emacs configuration

;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; No splash screen
(setq inhibit-splash-screen t)

;; More space for text
(menu-bar-mode 0)
(tool-bar-mode 0)

;; Use MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa stable" . "https://stable.melpa.org/packages/") t)

;; Low contrast theme
(load-theme 'zenburn t)

;; Better looking mode line
(require 'powerline)
(powerline-default-theme)

;; Activate flycheck globally.
(require 'flycheck)
(global-flycheck-mode)

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
(ivy-mode 1)

(provide 'init)

;;; init.el ends here
