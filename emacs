(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize) 

(defvar required-packages
    '(
      magit
      helm
      evil
      evil-leader
      which-key
      projectile
      helm-projectile
      grizzl
      js2-mode
      zenburn-theme
      helm-ag
      ) "A list of packages to ensure are installed at launch")

(require 'cl)

; method to check if all packages are installed
(defun packages-installed-p ()
  (loop for p in required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

; if not all packages are installed, check one by one and install the missing ones.
(unless (packages-installed-p)
  ; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ; install the missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(require 'evil)
(evil-mode 1)

(require 'which-key)
(which-key-mode)

(projectile-global-mode)
(setq projectile-completion-system 'grizzl)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(menu-bar-mode -1)

(global-linum-mode 1)
(defun nolinum ()
  (global-linum-mode 0)
  )
(add-hook 'term-mode-hook 'nolinum)
(setq linum-format "%4d  ")

(setq system-uses-terminfo nil)

(global-set-key (kbd "C-k") 'windmove-up)
(global-set-key (kbd "C-j") 'windmove-down)
(global-set-key (kbd "C-h") 'windmove-left)
(global-set-key (kbd "C-l") 'windmove-right)

(add-hook 'term-mode-hook
	  (lambda ()
	    (define-key term-raw-map (kbd "C-k") 'windmove-up)
	    (define-key term-raw-map (kbd "C-j") 'windmove-down)
	    (define-key term-raw-map (kbd "C-h") 'windmove-left)
	    (define-key term-raw-map (kbd "C-l") 'windmove-right)))

(defun my/split-window-vertically ()
  (interactive)
  (split-window-vertically)
  (windmove-down)
  (switch-to-buffer (generate-new-buffer "buffer")))

(defun my/split-window-horizontally ()
  (interactive)
  (split-window-horizontally)
  (windmove-right)
  (switch-to-buffer (generate-new-buffer "buffer")))

(defun my/term ()
  (interactive)
  (term "/bin/zsh"))

(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key "p" 'projectile-find-file)
(evil-leader/set-key "-" 'my/split-window-vertically)
(evil-leader/set-key "|" 'my/split-window-horizontally)
(evil-leader/set-key "q" 'kill-buffer-and-window)
(evil-leader/set-key "w" 'save-buffer)
(evil-leader/set-key "g" 'magit-status)
(evil-leader/set-key "e" 'eval-buffer)
(evil-leader/set-key "t" 'my/term)
(evil-leader/set-key "s" 'helm-ag-project-root)

(defun my/open-configuration ()
  (interactive)
  (find-file "~/.emacs"))

(evil-leader/set-key "c" 'my/open-configuration)

(set-face-background 'mode-line "#121212")
(set-face-foreground 'mode-line "#666666")
(set-face-background 'mode-line-inactive "#121212")
(set-face-foreground 'mode-line-inactive "#222222")
