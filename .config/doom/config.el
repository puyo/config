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

;; ----------------------------------------------------------------------
;; asdf

(push (expand-file-name "~/.asdf/bin") exec-path)
(push (expand-file-name "~/.asdf/shims") exec-path)

;; ----------------------------------------------------------------------
;; OS clipboard interop

(setq select-enable-clipboard t)
(setq select-enable-primary t)

;; ----------------------------------------------------------------------
;; Keep cursor away from margins

(setq scroll-margin 5)

;; ----------------------------------------------------------------------
;; Completion

(setq global-company-mode nil)

;; ----------------------------------------------------------------------
;; Key bindings

(after! evil
  ;; Paste something you deleted multiple times
  (setq evil-kill-on-visual-paste nil)

  (add-to-list 'load-path (expand-file-name "~/projects/config/elisp/"))
  (require 'evil-move-region)
  (evil-move-region-default-bindings)

  (global-set-key (kbd "s-h") 'evil-move-left)
  (global-set-key (kbd "s-j") 'evil-move-down)
  (global-set-key (kbd "s-l") 'evil-move-right)
  (global-set-key (kbd "s-k") 'evil-move-up)

  (global-set-key (kbd "s-,") 'customize)
  (global-set-key (kbd "s--") 'doom/decrease-font-size)
  (global-set-key (kbd "s-/") 'evilnc-comment-operator)
  (global-set-key (kbd "s-0") 'doom/reset-font-size)
  (global-set-key (kbd "s-=") 'doom/increase-font-size)
  (global-set-key (kbd "s-`") 'other-frame)
  (global-set-key (kbd "s-a") 'mark-whole-buffer)
  (global-set-key (kbd "s-b") 'consult-buffer)
  (global-set-key (kbd "s-c") 'evil-yank)
  (global-set-key (kbd "s-g") '+default/search-project)
  (global-set-key (kbd "s-n") 'make-frame)
  (global-set-key (kbd "s-o") 'find-file)
  (global-set-key (kbd "s-p") 'projectile-find-file)
  (global-set-key (kbd "s-q") 'save-buffers-kill-terminal)
  (global-set-key (kbd "s-r") 'consult-recent-file)
  (global-set-key (kbd "s-s") 'save-buffer)
  (global-set-key (kbd "s-t") 'projectile-find-file)
  (global-set-key (kbd "s-v") 'evil-paste-before-cursor-after)
  (global-set-key (kbd "s-w") 'kill-current-buffer)
  (global-set-key (kbd "s-x") 'kill-region)
  (global-set-key (kbd "s-z") 'undo)
  (global-set-key (kbd "s-{") 'centaur-tabs-backward)
  (global-set-key (kbd "s-}") 'centaur-tabs-forward)

  ;; Leave the cursor in the right spot after pasting in insert mode
  (define-key evil-insert-state-map (kbd "s-v") 'clipboard-yank)

  ;; Make movement keys work with wrapped text
  (define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
  (define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
  (define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
  (setq-default evil-cross-lines t) ; horizontal movement crosses lines

  ;; Fix "C-w o" so it actually closes other windows
  (define-key evil-window-map (kbd "o") 'doom/window-maximize-buffer)

  ;; Make "s" in visual mode work like Vim, rather than having to use "S"
  (define-key evil-visual-state-map (kbd "s") 'evil-surround-region)

  ;; SPC TAB to switch back and forth between latest two buffers, like spacemacs
  (map! :leader "TAB" #'evil-switch-to-windows-last-buffer)

  ;; Let emacs' fill-region config do its thing without interference. i.e.
  ;; use the double-space sentence configuration.
  (defadvice! +evil--no-squeeze-on-fill-a (fn &rest args)
    :around '(evil-fill evil-fill-and-move)
    (letf! (defun fill-region (from to &optional justify nosqueeze to-eop)
             (funcall fill-region from to justify nosqueeze to-eop))
      (apply fn args)))
  )

;; ----------------------------------------------------------------------
;; Recent files

(after! recentf
  ;; If I visit a buffer, it should update its recentf status
  (add-hook 'buffer-list-update-hook 'recentf-track-opened-file)
  )

;; ----------------------------------------------------------------------
;; Open files AKA buffers

(after! consult
  ;; Don't preview, it's awful
  (consult-customize consult-buffer :preview-key nil)
  )

;; ----------------------------------------------------------------------
;; Tabs across the top

(after! centaur-tabs
  ;; Consistent height so everything does not move around when the "close" and
  ;; "unsaved" icons swap
  (setq centaur-tabs-height 40)
  (setq centaur-tabs-bar-height 50)
  (setq centaur-tabs-set-bar 'over)

  ;; Don't group tabs except for one to hide all the uncloseable Emacs windows
  (defun centaur-tabs-buffer-groups ()
    (list
     (cond
      ((string-equal "*" (substring (buffer-name) 0 1)) "Emacs")
      ((string-equal "TAGS" (buffer-name)) "Emacs")
      (t "Editing")))
    )
  )

;; ----------------------------------------------------------------------
;; Spelling

(after! ispell
  (setq ispell-personal-dictionary (expand-file-name "~/.aspell.en.pws"))
  )

;; ----------------------------------------------------------------------
;; Typing brackets

(after! smartparens
  ;; Thanks I hate it
  (remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)
  )

;; ----------------------------------------------------------------------
;; TAGS

(after! projectile
  (defun create-tags ()
    "Create tags file."
    (interactive)
    (shell-command (format "ctags -f TAGS -e -R %s" (projectile-project-root)))
    (message "Tags rebuilt")
    )
  )

;; ----------------------------------------------------------------------
;; Auto format code
;;
;; See ~/.config/emacs/.local/straight/repos/emacs-format-all-the-code/format-all.el:124

(after! format
  (setq format-all-formatters
        '(
          ("Elixir" mix-format)
          ("Go" gofmt)
          ("GraphQL" prettier)
          ("HTML+EEX" mix-format)
          ("HTML+ERB" erb-format)
          ("JSON" prettier)
          ("JSON5" prettier)
          ("JSX" prettier)
          ("Markdown" prettier)
          ("Python" black)
          ("R" styler)
          ("Ruby" rubocop)
          ("Rust" rustfmt)
          ("SCSS" prettier)
          ("SQL" sqlformat)
          ("Svelte" prettier)
          ("TSX" prettier)
          ("Terraform" terraform-fmt)
          ("TypeScript" prettier)
          ("YAML" prettier)
          )
        )
  )

;; ----------------------------------------------------------------------
;; Markdown

(after! (:and markdown-mode evil)
  ;; Ensure unicode inside code renders neatly
  (custom-set-faces!
    '(markdown-code-face :family "Source Code Pro")
    )

  (add-hook 'markdown-mode-hook
            (lambda ()
              ;; Don't use different markdowny paragraph text objects, they're buggy)
              (setq-local paragraph-start (default-value 'paragraph-start))
              (setq-local paragraph-separate (default-value 'paragraph-separate))

              (evil-define-key '(normal motion) evil-markdown-mode-map
                "{" 'evil-backward-paragraph
                "}" 'evil-forward-paragraph
                )

              ;; Modify what characters are considered punctuation (.) and words (w)
              (modify-syntax-entry ?* ".")
              (modify-syntax-entry ?/ ".")
              )
            )
  )

;; ----------------------------------------------------------------------
;; Emacs lisp

(after! elisp-mode
  (add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (modify-syntax-entry ?- "w")
              (modify-syntax-entry ?/ "w")
              )
            )
  )

;; ----------------------------------------------------------------------
;; Python

(after! python
  (add-hook! 'python-mode-hook (modify-syntax-entry ?_ "w"))
  )

;; ----------------------------------------------------------------------
;; JavaScript

(after! javascript
  (add-hook! 'js2-mode-hook (modify-syntax-entry ?_ "w"))
  )

;; ----------------------------------------------------------------------
;; Ruby

(after! (:and ruby evil)
  (add-hook 'ruby-mode-hook 'evil-ruby-text-objects-mode)

  ;; Run Ruby commands through bundler
  (add-hook 'ruby-mode-hook
            (lambda ()
              (modify-syntax-entry ?_ "w")
              (setq-local flycheck-command-wrapper-function
                          (lambda (command) (append '("bundle" "exec") command))))
            )

  (setq rubocop-format-on-save t)
  )
