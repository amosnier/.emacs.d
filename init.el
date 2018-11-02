;;; init.el --- Emacs configuration

;;; Commentary:
;; Trying to create a clean Emacs configuration

;;; Code:

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

;; Git commit mode
(require 'git-commit)

(provide 'init)

;;; init.el ends here
