
(setq doom-theme 'doom-one)
(add-to-list 'default-frame-alist '(alpha-background . 84))

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 22 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 24))

(setq display-line-numbers-type t)
(setq line-number-relative t)

(setq org-directory "~/Notes/org/")

(setq display-line-numbers-type 'relative)
(setq scroll-margin 8)

(setq ispell-program-name "hunspell")
(setq ispell-local-dictionary "en_US")

(map! :leader :desc "Write" "w" #'save-buffer )
(map! :leader :desc "Kill Buffer" "x" #'kill-this-buffer  )
(map! :leader :desc "Exit Emacs" "q" #'kill-buffer-and-window )
(map! :leader :desc "Exit Emacs" "Q" #'kill-emacs )

(map! :leader :desc "Explorer" "." #'dired-jump )
(map! :leader :desc "Explorer" "e" #'find-file )
(map! :leader :desc "Vterm" "RET" #'+vterm/here )
(map! :leader :desc "Vterm Split" "tt" #'+vterm/toggle )

(map! :leader :desc "Next Buffer" "l" #'next-buffer )
(map! :leader :desc "Previous Buffer" "h" #'previous-buffer )

(map! :leader :desc "Split Vert" "j" #'evil-window-next )
(map! :leader :desc "Split Vert" "s" #'evil-window-vsplit )
(map! :leader :desc "Split Vert" "S" #'evil-window-split )

;; (global-set-key (kbd "C-w") (lambda () (interactive) (+workspace/delete)))

(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file ; use dired-find-file instead of dired-open.
  (kbd "r") 'dired-do-rename
  (kbd "y") 'dired-do-copy
  (kbd "d") 'dired-do-delete
  (kbd "/") 'dired-goto-file
  (kbd "n") 'dired-create-empty-file
  (kbd "m") 'dired-create-directory
  (kbd "Z") 'dired-do-compress
  (kbd "X") 'dired-do-chmod
  (kbd "O") 'dired-do-chown
  (kbd "; d") 'epa-dired-do-decrypt
  (kbd "; e") 'epa-dired-do-encrypt)

(setq dired-open-extensions '(("gif" . "sxiv")
                              ("jpg" . "sxiv")
                              ("png" . "sxiv")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))

(setq delete-by-moving-to-trash t
      trash-directory "~/.local/share/Trash/files/")

(map! :leader
      (:prefix ("=" . "open file")
       :desc "Dots Files" "=" #'(lambda () (interactive) (find-file "~/Dots/"))
       :desc "" "v" #'(lambda () (interactive) (find-file "~/Videos/"))
       :desc "Edit doom packages.el" "p" #'(lambda () (interactive) (find-file "~/.config/doom/packages.el"))))

(custom-set-faces
 '(default ((t (:background "#171717"))))
 '(solaire-default-face ((t (:background "#171717")))))

(setq shell-file-name "/bin/fish"
      vterm-max-scrollback 5000)

