;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Gregory McIntyre"
      user-mail-address "greg@gregorymcintyre.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Comic Mono" :size 18)
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 15))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-horizon)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; OS X Apple button based shortcuts: recent, buffers, project files, close,
;; previous buffer, next buffer
(global-set-key (kbd "s-r") 'recentf-open-files)
(global-set-key (kbd "s-b") 'ivy-switch-buffer)
(global-set-key (kbd "s-B") 'switch-to-buffer)
(global-set-key (kbd "s-t") 'projectile-find-file)
(global-set-key (kbd "s-p") 'projectile-find-file)
(global-set-key (kbd "s-{") 'centaur-tabs-backward)
(global-set-key (kbd "s-}") 'centaur-tabs-forward)
(global-set-key (kbd "s-o") 'find-file)
(global-set-key (kbd "s-g") '+default/search-project)
(global-set-key (kbd "s-=") 'doom/increase-font-size)
(global-set-key (kbd "s--") 'doom/decrease-font-size)
(global-set-key (kbd "s-0") 'doom/reset-font-size)
(global-set-key (kbd "s-q") 'save-buffers-kill-terminal)
(global-set-key (kbd "s-v") 'yank)
(global-set-key (kbd "s-c") 'evil-yank)
(global-set-key (kbd "s-a") 'mark-whole-buffer)
(global-set-key (kbd "s-x") 'kill-region)
(global-set-key (kbd "s-w") 'delete-window)
(global-set-key (kbd "s-W") 'delete-frame)
(global-set-key (kbd "s-n") 'make-frame)
(global-set-key (kbd "s-`") 'other-frame)
(global-set-key (kbd "s-z") 'undo)
(global-set-key (kbd "s-s") 'save-buffer)
(global-set-key (kbd "s-,") 'customize)

(add-hook 'markdown-mode-hook
          (lambda ()
            (evil-define-key 'normal markdown-mode-map
              (kbd "{") 'markdown-backward-block
              (kbd "}") 'markdown-forward-block
              )

            (define-key markdown-mode-map [remap backward-paragraph] 'markdown-backward-block)
            (define-key markdown-mode-map [remap forward-paragraph] 'markdown-forward-block)

            (modify-syntax-entry ?* ".")
            (modify-syntax-entry ?_ "w")
            (modify-syntax-entry ?/ ".")

            (custom-set-faces
             '(markdown-code-face ((t (:extend t :family "Source Code Pro"))))
             )
            )
          )

(setq centaur-tabs-height 40)
(setq centaur-tabs-bar-height 43)
(setq centaur-tabs-set-icons t)
(setq centaur-tabs-plain-icons t)

;; Make movement keys work like they should
(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)

; Make horizontal movement cross lines
(setq-default evil-cross-lines t)

;; Kill buffer without closing windows
(defun custom-kill-buffer ()
  "Kill the current buffer"
  (interactive)
  (kill-buffer nil))
(evil-declare-not-repeat 'custom-kill-buffer)
(global-set-key (kbd "s-w") 'custom-kill-buffer)

;; Save buffer but don't muck up evil-repeat
(defun custom-save-buffer ()
  (interactive)
  (save-buffer nil))
(evil-declare-not-repeat 'custom-save-buffer)
(global-set-key (kbd "s-s") 'custom-save-buffer)

(after! recentf
  (add-hook 'buffer-list-update-hook 'recentf-track-opened-file)
  )
