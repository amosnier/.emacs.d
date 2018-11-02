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

;; Activate flycheck globally.
(require 'flycheck)
(global-flycheck-mode)

;; Activate flyspell mode for comments and strings
(flyspell-prog-mode)

;; Git commit mode
(require 'git-commit)

;; Text mode hook
(defun configure-text-mode ()
  "This function improves the text mode."
  (turn-on-auto-fill)
  (flyspell-mode))
(add-hook 'text-mode-hook 'configure-text-mode)

;; Activate global company-mode
(add-hook 'after-init-hook 'global-company-mode)

(provide 'init)

;;; init.el ends here
