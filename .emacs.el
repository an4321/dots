(load-theme 'wombat t)
(setq custom-file "~/.cache/emacs-custom.el")
(load custom-file)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq use-dialog-box nil)
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")
(mouse-avoidance-mode 'banish)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(set-default 'truncate-lines t)
(global-hl-line-mode 1)

(recentf-mode 1)
(save-place-mode 1)
(savehist-mode 1)

(set-face-attribute 'default nil :font "JetBrainsMonoNerdFont 16")
(add-to-list 'default-frame-alist '(font . "JetBrainsMonoNerdFont 16"))
(set-face-attribute 'font-lock-comment-face nil :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil :slant 'italic)

(global-set-key [escape] 'keyboard-escape-quit)
(setq shell-file-name "/bin/bash")
(setq delete-by-moving-to-trash t
      trash-directory "~/.local/share/Trash/files")

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)


;; straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
        (expand-file-name
          "straight/repos/straight.el/bootstrap.el"
          (or (bound-and-true-p straight-base-dir)
              user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
      (url-retrieve-synchronously
        "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
        'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)


;; basics
(straight-use-package 'counsel)
(straight-use-package 'ivy)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(ivy-mode)

(straight-use-package 'which-key)
(which-key-mode 1)
(setq which-key-separator " → "
      which-key-min-display-lines 4)


;; theming
(straight-use-package 'doom-themes)
(load-theme 'doom-monokai-pro t)

(straight-use-package 'doom-modeline)
(doom-modeline-mode 1)
(setq doom-modeline-icon nil)


;; evil
(straight-use-package 'evil)
(evil-mode 1)

(defun nb (key func) "evil normal mode bind" (with-eval-after-load 'evil (define-key evil-normal-state-map (kbd key) func)))
(defun vb (key func) "evil visual mode bind" (with-eval-after-load 'evil (define-key evil-visual-state-map (kbd key) func)))

(nb ";" 'evil-ex)
(nb "SPC e" 'counsel-find-file)
(nb "M-e" 'dired-jump)
(nb "SPC RET" 'eshell)

(nb "SPC b" 'counsel-switch-buffer)
(nb "SPC w" 'save-buffer)
(nb "SPC q" 'kill-buffer-and-window)
(nb "SPC x" 'kill-this-buffer)
(nb "SPC h" 'previous-buffer)
(nb "SPC l" 'next-buffer)

(global-set-key (kbd "M-SPC") 'counsel-switch-buffer)
(global-set-key (kbd "M-q") 'kill-this-buffer)
(global-set-key (kbd "M-l") 'next-buffer)
(global-set-key (kbd "M-h") 'previous-buffer)

(nb "SPC j" 'evil-window-next)
(nb "SPC k" 'evil-window-prev)
(nb "SPC s" 'evil-window-vnew)
(nb "SPC S" 'evil-window-new)

(nb "SPC SPC" 'project-find-file)
(global-set-key (kbd "M-f") 'project-find-file)
(nb "SPC ff" 'project-or-external-find-file)
(nb "SPC fr" 'counsel-recentf)
(nb "SPC fg" 'counsel-grep-or-swiper)
(nb "SPC fc" 'counsel-load-theme)
(nb "SPC fd" 'counsel-apropos)
(nb "SPC ." (lambda () (interactive) (find-file "~/.emacs.el")))

(nb "H" 'evil-first-non-blank-of-visual-line)
(vb "H" 'evil-first-non-blank-of-visual-line)
(nb "L" 'evil-end-of-line)
(vb "L" 'evil-end-of-line)
(nb "U" 'evil-redo)
(vb "U" 'evil-redo)

(nb "C-d" (lambda () (interactive) (evil-scroll-down nil) (evil-scroll-line-to-center (line-number-at-pos))))
(nb "C-u" (lambda () (interactive) (evil-scroll-up nil) (evil-scroll-line-to-center (line-number-at-pos))))

(straight-use-package 'evil-numbers)
(nb "SPC i" 'evil-numbers/inc-at-pt)
(nb "SPC d" 'evil-numbers/dec-at-pt)

(evil-define-key 'normal dired-mode-map
  (kbd "RET") 'dired-find-file
  (kbd "<backspace>") 'dired-up-directory
  (kbd "r") 'dired-do-rename
  (kbd "y") 'dired-do-copy
  (kbd "d") 'dired-do-delete
  (kbd "n") 'dired-create-empty-file
  (kbd "m") 'dired-create-directory
  (kbd "X") 'dired-do-chmod
  (kbd "O") 'dired-do-chown)
