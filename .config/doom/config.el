
;; doom-one doom-vibrant doom-nord
;; doom-dracula doom-material: High contrast
(setq doom-theme 'doom-one)
(add-to-list 'default-frame-alist '(alpha-background . 84))

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 21 :weight 'semi-light))

(custom-set-faces
 '(default ((t (:background "#171717"))))
 '(solaire-default-face ((t (:background "#171717")))))

;; (setq initial-buffer-choice "~/")

(after! evil-snipe (evil-snipe-mode -1))
(evil-snipe-mode -1)

(setq display-line-numbers-type t
      line-number-relative t
      display-line-numbers-type 'relative
      scroll-margin 8
      shell-file-name "/bin/fish"
      vterm-max-scrollback 5000

      ispell-program-name "hunspell"
      ispell-local-dictionary "en_US"

      delete-by-moving-to-trash t
      trash-directory "~/.local/share/Trash/files"
      projectile-project-search-path "~/Desktop")


(map! "M-D" #'kill-emacs)
(map! "M-a" #'+workspace/cycle)
(map! "M-d" #'+workspace/delete)
(map! "M-H" #'+workspace/swap-left)
(map! "M-L" #'+workspace/swap-right)
(map! :n "M-n" #'(lambda () (interactive) (+workspace/new-named "Notes") (find-file "~/Documents/Org/index.org")))

(map! :leader :desc "Write" "w" #'save-buffer)
(map! :leader :desc "Kill Buffer" "x" #'kill-this-buffer)
(map! :leader :desc "Exit Emacs" "q" #'kill-buffer-and-window)
(map! :leader :desc "Explorer" "e" #'find-file)
(map! :leader :desc "Explorer" "E" #'dired-jump)

(map! "M-RET" #'+vterm/here)
(map! :after evil
      :n "M-t" #'+vterm/toggle
      :i "M-t" #'+vterm/toggle)

(map! :leader :desc "Next Buffer" "l" #'next-buffer)
(map! :leader :desc "Previous Buffer" "h" #'previous-buffer)

(map! :leader :desc "Switch to Buffer" "d" #'+vertico/switch-workspace-buffer)
(map! :leader :desc "Next Window" "j" #'evil-window-next)
(map! :leader :desc "Split Vert" "s" #'evil-window-vnew)
(map! :leader :desc "Split Hor" "S" #'evil-window-new)

(map! :after evil
      :n "t" #'avy-goto-char-timer
      :v "t" #'avy-goto-char-timer

      :n "U" #'evil-redo)

(map! :after evil
      :map evil-normal-state-map
      "C-a" #'evil-numbers/inc-at-pt
      "C-x" #'evil-numbers/dec-at-pt)

(after! org
  (setq org-directory "~/Documents/Org"
        org-display-inline-image 1)
  (map! :map evil-normal-state-map
        "M-g" #'org-next-link
        "M-G" #'org-previous-link
        "mh" #'org-next-visible-heading
        "mf" #'+org/toggle-fold
        "mc" #'+org/close-fold
        "ma" #'org-agenda-week-view
        "mb" #'org-table-create
        "mn" #'org-insert-link
        "ms" #'org-schedule
        "ml" #'org-toggle-link-display
        "mp" #'+org-pretty-mode
        "mt" #'org-todo)
  )

(defun kill-dired-buffers ()
  (interactive)
  (mapc (lambda (buffer)
          (when (eq 'dired-mode (buffer-local-value 'major-mode buffer))
            (kill-buffer buffer)))
        (buffer-list)))

(evil-define-key 'normal dired-mode-map
  (kbd "TAB") 'dired-display-file
  (kbd "q") 'kill-dired-buffers
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file
  (kbd "l") 'my-run-two-commands
  (kbd "r") 'dired-do-rename
  (kbd "y") 'dired-do-copy
  (kbd "d") 'dired-do-delete
  (kbd "n") 'dired-create-empty-file
  (kbd "N") 'dired-create-directory
  (kbd "Z") 'dired-do-compress
  (kbd "X") 'dired-do-chmod
  (kbd "O") 'dired-do-chown
  (kbd "; d") 'epa-dired-do-decrypt
  (kbd "; e") 'epa-dired-do-encrypt)

(map! :leader "be" #'kill-dired-buffers)

