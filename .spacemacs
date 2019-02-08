;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     auto-completion
     csv
     docker
     elixir
     elm
     emacs-lisp
     erlang
     evil-commentary
     git
     github
     go
     haskell
     html
     idris
     ivy
     javascript
     markdown
     markdown
     osx
     python
     react
     ruby
     ruby-on-rails
     rust
     spell-checking
     sql
     syntax-checking
     typescript
     vimscript
     yaml
   )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(editorconfig stylus-mode haml-mode sonic-pi tabbar)
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(evil-tutor evil-search-highlight-persist)
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update t
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-light
                         spacemacs-dark)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Menlo"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 100000000
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy nil
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native t
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers t
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  ;; Make _ a word character so long_identifier is one word
  (with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol))

  ;; asdf
  (push (expand-file-name "~/.asdf/bin") exec-path)
  (push (expand-file-name "~/.asdf/shims") exec-path)

  ;; Path to my elisp additions
  (add-to-list 'load-path (expand-file-name "~/projects/config/elisp/"))
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  (dotspacemacs/user-init-disable-semantic-completion)
  (dotspacemacs/user-init-tabbar)
  (dotspacemacs/user-init-fix-m-backspace)
  (dotspacemacs/user-init-evil-move-region)
  (dotspacemacs/user-init-window-size)
  (dotspacemacs/user-init-spelling)
  (dotspacemacs/user-init-editorconfig)
  (dotspacemacs/user-fix-evil-visual)
  (dotspacemacs/user-fix-large-file-handling)
  (dotspacemacs/user-init-osx)
  (dotspacemacs/user-init-elixir)
  (dotspacemacs/user-init-js)
  (dotspacemacs/user-init-elixir-max-line-length)
  (dotspacemacs/user-init-sonic-pi)
  (dotspacemacs/user-init-add-buffer-switches-to-recentf)
  )

(defun dotspacemacs/user-init-disable-semantic-completion ()
  (eval-after-load 'semantic
    (add-hook 'semantic-mode-hook
              (lambda ()
                (dolist (x (default-value 'completion-at-point-functions))
                  (when (string-prefix-p "semantic-" (symbol-name x))
                    (remove-hook 'completion-at-point-functions x))))))
  )

(defun dotspacemacs/user-init-tabbar ()
  (require 'tabbar)
  (tabbar-mode)

  (defun string/ends-with (string suffix)
    "Return t if STRING ends with SUFFIX."
    (and (string-match (rx-to-string `(: ,suffix eos) t)
                       string)
         t))

  (defun tabbar-buffer-groups ()
    (list
     (cond
      ((string-equal "*" (substring (buffer-name) 0 1))
       "Emacs"
       )
      ((string-equal " *" (substring (buffer-name) 0 2))
       "Emacs"
       )
      ((member (file-name-nondirectory (buffer-file-name)) '("tags" "TAGS"))
       "Emacs"
       )
      (t
       "User"
       )
      )))

  (setq tabbar-buffer-groups-function 'tabbar-buffer-groups)
  )

(defun dotspacemacs/user-init-add-buffer-switches-to-recentf ()
  (require 'recentf-mode)

  (defun switched-buffer ()
    (recentf-track-opened-file)
    )

  (add-hook 'buffer-list-update-hook 'switched-buffer)
  )

(defun dotspacemacs/user-init-fix-m-backspace ()
  "From https://www.emacswiki.org/emacs/BackwardDeleteWord"

  (defun delete-word (arg)
    "Delete characters forward until encountering the end of a word.
With argument, do this that many times."
    (interactive "p")
    (if (use-region-p)
        (delete-region (region-beginning) (region-end))
      (delete-region (point) (progn (forward-word arg) (point)))))

  (defun backward-delete-word (arg)
    "Delete characters backward until encountering the end of a word.
With argument, do this that many times."
    (interactive "p")
    (delete-word (- arg)))

  (global-set-key (read-kbd-macro "<M-DEL>") 'backward-delete-word))

(defun dotspacemacs/user-init-elixir-max-line-length ()
  (add-hook 'elixir-mode-hook
            (lambda ()
              (set-fill-column 120))))

(defun dotspacemacs/user-init-evil-move-region ()
  ;; M-{hjkl} to move blocks of text around
  (require 'evil-move-region)
  (evil-move-region-default-bindings)
  )

(defun dotspacemacs/user-init-window-size ()
  (if (window-system)
      (set-frame-size (selected-frame) 100 50))
  )

(defun dotspacemacs/user-init-spelling ()
  ;; Use aspell since ispell on OSX homebrew doesn't have non-American spelling
  (setq-default ispell-program-name "aspell")
  )

(defun dotspacemacs/user-init-editorconfig ()
  ;; Set indentation and other preferences based on project .editorconfig file
  (require 'editorconfig)
  (editorconfig-mode 1)
  )

(defun dotspacemacs/user-fix-evil-visual ()
  ;; Fix problem copying and pasting with evil visual mode
  (fset 'evil-visual-update-x-selection 'ignore)
  )

(defun dotspacemacs/user-fix-large-file-handling ()
  ;; Stop asking me about fundamental mode when opening any file inside a
  ;; project that has a large TAGS file
  (defun spacemacs/check-large-file ()
    (when (> (buffer-size) (* 1024 1024))
      (setq buffer-read-only t)
      (buffer-disable-undo)
      (fundamental-mode)))
  (add-hook 'find-file-hook 'spacemacs/check-large-file)
  (add-to-list 'auto-mode-alist '("TAGS" . fundamental-mode))
  )

(defun dotspacemacs/user-init-elixir ()
  ;; Elixir mode on atypical elixir files
  (add-to-list 'auto-mode-alist '("mix\\.lock\\'" . elixir-mode))
  )

(defun dotspacemacs/user-init-osx ()
  ;; OS X Apple button based shortcuts: recent, buffers, project files, close,
  ;; previous buffer, next buffer
  (global-set-key (kbd "s-r") 'counsel-recentf)
  (global-set-key (kbd "s-b") 'ivy-switch-buffer)
  (global-set-key (kbd "s-t") 'counsel-projectile)
  (global-set-key (kbd "s-p") 'counsel-git)
  (global-set-key (kbd "s-{") 'tabbar-backward)
  (global-set-key (kbd "s-}") 'tabbar-forward)
  (global-set-key (kbd "s-o") 'counsel-find-file)
  (global-set-key (kbd "s-V") 'counsel-show-kill-ring)
  (global-set-key (kbd "s-g") 'counsel-git-grep)

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
  )

(defun dotspacemacs/user-init-js ()
  ;; Format JS code via :'<,'>prettier
  (require 'prettier-js)

  ;; Flow/JSX flychecker
  (dotspacemacs/user-init-js-flow)
  )

(defun dotspacemacs/user-init-js-flow ()
  (require 'flow-jsx-mode)
  (add-to-list 'auto-mode-alist '("\\.flow\\'" . flow-jsx-mode))

  ;; flycheck flowtype
  (require 'f)
  (require 'json)
  (require 'flycheck)
  (defun flycheck-parse-flow (output checker buffer)
    (let ((json-array-type 'list))
      (let ((o (json-read-from-string output)))
        (mapcar #'(lambda (errp)
                    (let ((err (cadr (assoc 'message errp)))
                          (err2 (cadr (cdr (assoc 'message errp)))))
                      (flycheck-error-new
                       :line (cdr (assoc 'line err))
                       :column (cdr (assoc 'start err))
                       :level 'error
                       :message (concat (cdr (assoc 'descr err)) ". " (cdr (assoc 'descr err2)))
                       :filename (f-relative
                                  (cdr (assoc 'path err))
                                  (f-dirname (file-truename
                                              (buffer-file-name))))
                       :buffer buffer
                       :checker checker)))
                (cdr (assoc 'errors o))))))

  (flycheck-define-checker javascript-flow
    "Static type checking using Flow."
    :command ("flow" "--json" source-original)
    :error-parser flycheck-parse-flow
    :modes js2-mode react-mode)
  (add-to-list 'flycheck-checkers 'javascript-flow)
  )

(defun dotspacemacs/user-init-sonic-pi ()
  (require 'sonic-pi)

  (setq sonic-pi-path "/Applications/Sonic Pi.app/app")
  (setq sonic-pi-server-bin             "server/ruby/bin/sonic-pi-server.rb")
  (setq sonic-pi-compile-extensions-bin "server/ruby/bin/compile-extensions.rb")
  (setq sonic-pi-ruby-bin               "server/native/ruby/bin/ruby")
  (defun sonic-pi-server-cmd () (format "%s/%s %s/%s" sonic-pi-path sonic-pi-ruby-bin sonic-pi-path sonic-pi-server-bin))

  (add-hook 'sonic-pi-mode-hook
            (lambda ()

              (add-hook 'after-save-hook 'sonic-pi-send-buffer nil t)

              (define-key ruby-mode-map (kbd "<s-return>") 'sonic-pi-send-buffer)
              (define-key ruby-mode-map (kbd "s-.") 'sonic-pi-stop-all)

              (sonic-pi-connect)

              (load-theme 'spacemacs-dark)
              ))
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(compilation-message-face (quote default))
 '(create-lockfiles nil)
 '(css-indent-offset 2)
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(delete-selection-mode t)
 '(evil-ex-search-persistent-highlight nil)
 '(evil-surround-pairs-alist
   (quote
    ((40 "( " . " )")
     (91 "[ " . " ]")
     (123 "{ " . " }")
     (41 "(" . ")")
     (93 "[" . "]")
     (125 "{" . "}")
     (35 "#{" . "}")
     (98 "(" . ")")
     (66 "{" . "}")
     (62 "<" . ">")
     (116 . evil-surround-read-tag)
     (60 . evil-surround-read-tag)
     (102 . evil-surround-function)
     (37 "%{" . "}"))))
 '(evil-want-C-i-jump t)
 '(evil-want-Y-yank-to-eol nil)
 '(exec-path-from-shell-check-startup-files nil)
 '(flycheck-disabled-checkers (quote (rust rust-cargo)))
 '(flycheck-elixir-credo-strict t)
 '(flyspell-persistent-highlight nil)
 '(global-linum-mode t)
 '(global-vi-tilde-fringe-mode nil)
 '(helm-adaptive-sort-by-frequent-recent-usage nil)
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#49483E" . 0)
     ("#67930F" . 20)
     ("#349B8D" . 30)
     ("#21889B" . 50)
     ("#968B26" . 60)
     ("#A45E0A" . 70)
     ("#A41F99" . 85)
     ("#49483E" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(js-indent-level 2)
 '(js2-mode-show-parse-errors t)
 '(js2-mode-show-strict-warnings nil)
 '(js2-strict-missing-semi-warning nil)
 '(large-file-warning-threshold 1000000000)
 '(magit-diff-use-overlays nil)
 '(mouse-wheel-scroll-amount (quote (1 ((shift) . 1) ((control)))))
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(ns-pop-up-frames nil)
 '(package-selected-packages
   (quote
    (toml-mode racer flycheck-rust cargo rust-mode wgrep smex ivy-hydra flyspell-correct-ivy counsel-projectile counsel swiper ivy osc sonic-pi counsel-dash xpm csv-mode ghub let-alist dockerfile-mode docker tablist docker-tramp protobuf-mode tide typescript-mode vimrc-mode dactyl-mode projectile-rails inflections feature-mode erlang magit-gh-pulls github-search github-clone github-browse-file gist gh marshal logito pcache ht macrostep helm-company helm-c-yasnippet fuzzy elisp-slime-nav company-web web-completion-data company-tern dash-functional company-statistics company-go company-cabal company-anaconda auto-yasnippet auto-compile packed ac-ispell auto-complete sql-indent flycheck-credo evil-tutor idris-mode prop-menu winum powerline pcre2el spinner hydra parent-mode projectile request flx smartparens iedit anzu evil goto-chg undo-tree highlight diminish bind-map bind-key s dash pkg-info epl helm avy helm-core popup async hide-comnt intero hlint-refactor hindent helm-hoogle haskell-snippets flycheck-haskell company-ghci company-ghc ghc haskell-mode cmm-mode flycheck-elm elm-mode ess go-guru go-eldoc go-mode utop tuareg caml ocp-indent merlin yapfify pyvenv pytest pyenv-mode py-isort pip-requirements live-py-mode hy-mode helm-pydoc cython-mode anaconda-mode pythonic sws-mode ob-elixir org minitest markdown-mode json-snatcher json-reformat yasnippet multiple-cursors js2-mode haml-mode gitignore-mode pos-tip flycheck magit magit-popup git-commit with-editor inf-ruby company elixir-mode zenburn-theme monokai-theme livid-mode skewer-mode dumb-jump uuidgen toc-org rake pug-mode osx-dictionary org-plus-contrib org-bullets simple-httpd link-hint git-link flyspell-correct-helm flyspell-correct flycheck-mix eyebrowse evil-visual-mark-mode evil-unimpaired evil-ediff f column-enforce-mode yaml-mode ws-butler window-numbering which-key web-mode web-beautify volatile-highlights vi-tilde-fringe use-package tern tagedit stylus-mode spacemacs-theme spaceline solarized-theme smooth-scrolling smeargle slim-mode scss-mode sass-mode rvm ruby-tools ruby-test-mode ruby-end rubocop rspec-mode robe reveal-in-osx-finder restart-emacs rbenv rainbow-delimiters quelpa popwin persp-mode pbcopy paradox page-break-lines osx-trash orgit open-junk-file neotree move-text mmm-mode markdown-toc magit-gitflow lorem-ipsum linum-relative leuven-theme less-css-mode launchctl json-mode js2-refactor js-doc jade-mode info+ indent-guide ido-vertical-mode hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-gitignore helm-flyspell helm-flx helm-descbinds helm-css-scss helm-ag google-translate golden-ratio gitconfig-mode gitattributes-mode git-timemachine git-messenger gh-md flycheck-pos-tip flx-ido fill-column-indicator fancy-battery expand-region exec-path-from-shell evil-visualstar evil-surround evil-numbers evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-commentary evil-args evil-anzu eval-sexp-fu emmet-mode editorconfig define-word coffee-mode clean-aindent-mode chruby bundler buffer-move bracketed-paste auto-highlight-symbol auto-dictionary alchemist aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line)))
 '(paradox-github-token t)
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" "node_modules")))
 '(projectile-globally-ignored-files (quote ("TAGS" "tags" ".tern-port")))
 '(projectile-use-git-grep t)
 '(recentf-exclude
   (quote
    ("COMMIT_EDITMSG\\'" "/Users/greg/.emacs.d/elpa" "/Users/greg/.emacs.d/.cache/" "TAGS")))
 '(ring-bell-function (quote ignore))
 '(ruby-insert-encoding-magic-comment nil)
 '(rust-format-on-save t)
 '(sh-basic-offset 2)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(tabbar-background-color "#e1dfd7")
 '(tabbar-separator (quote (" ")))
 '(tabbar-use-images nil)
 '(tags-add-tables nil)
 '(tags-case-fold-search nil)
 '(tags-revert-without-query t)
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(tooltip-delay 0.1)
 '(tooltip-short-delay 0)
 '(typescript-indent-level 2)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3")
 '(vc-follow-symlinks t)
 '(volatile-highlights-mode nil)
 '(web-mode-code-indent-offset 2)
 '(web-mode-markup-indent-offset 2)
 '(weechat-color-list
   (unspecified "#272822" "#49483E" "#A20C41" "#F92672" "#67930F" "#A6E22E" "#968B26" "#E6DB74" "#21889B" "#66D9EF" "#A41F99" "#FD5FF0" "#349B8D" "#A1EFE4" "#F8F8F2" "#F8F8F0"))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tabbar-button ((t (:inherit tabbar-default :box nil))))
 '(tabbar-default ((t (:background "#e1dfd7" :foreground "#3a81c3"))))
 '(tabbar-modified ((t (:inherit tabbar-default :foreground "green3"))))
 '(tabbar-selected ((t (:inherit tabbar-default :background "#fbf8ef" :foreground "blue" :weight normal))))
 '(tabbar-selected-modified ((t (:inherit tabbar-selected :foreground "green3"))))
 '(tabbar-unselected ((t (:inherit tabbar-default :background "#e1dfd7" :slant normal :weight light)))))

