;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Marco Antônio Ribeiro de Toledo"
      user-mail-address "marcoantonioribeirodetoledo@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)
;; (setq doom-font (font-spec :family "MesloLGS NF" :size 14 :weight 'semi-light)
;; (setq doom-font (font-spec :family "MesloLGS NF" :size 14)
;;      doom-variable-pitch-font (font-spec :family "sans" :size 13))
;; (setq doom-font (font-spec :family "MesloLGS NF")
;;       doom-variable-pitch-font (font-spec :family "sans"))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(setq display-line-numbers t)


;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq find-file-visit-truename nil)
(package-initialize)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; == LSP ==
(setq lsp-headerline-breadcrumb-enable t)
(setq lsp-lens-enable t)
(setq lsp-file-watch-ignored-directories '("[/\\\\]\\.git\\'" "[/\\\\]\\.github\\'" "[/\\\\]node_modules\\'"))

;; == copilot ==
;; accept completion from copilot and fallback to company
(use-package! copilot
 :hook (prog-mode . copilot-mode)
 :hook (org-mode . copilot-mode)
 :bind (:map copilot-completion-map
             ("<tab>" . 'copilot-accept-completion)
             ("TAB" . 'copilot-accept-completion)
             ("C-TAB" . 'copilot-accept-completion-by-word)
             ("C-<tab>" . 'copilot-accept-completion-by-word)))

;; == powerline ==
(use-package powerline)

;; == centaur-tabs ==
(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  (setq centaur-tabs-set-modified-marker t
        centaur-tabs-set-bar 'left)
  (centaur-tabs-group-by-projectile-project)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward)
  ("C-{" . centaur-tabs-backward)
  ("C-}" . centaur-tabs-forward))

;; == rest ==
(use-package! restclient-jq
  :after restclient
  :defer t)

;; == ChatGPT ==
(use-package! gptel)

;; == org ==
;;; == org-roam ==
(use-package org-roam
  :custom
  (org-roam-directory (file-truename "~/org/Roam/"))
  :init
  (setq org-roam-completion-everywhere t)
  (setq org-roam-v2-ack t)
  :config
  (org-roam-db-autosync-mode))

;; == ellama ==
;; (use-package! ellama
;;   :bind ("C-c e" . ellama-transient-main-menu)
;;   ;; send last message in chat buffer with C-c C-c
;;   :hook (org-ctrl-c-ctrl-c-final . ellama-chat-send-last-message)
;;   :init (setopt ellama-auto-scroll t)
;;   :config
;;   ;; show ellama context in header line in all buffers
;;   (ellama-context-header-line-global-mode +1)
;;   ;; show ellama session id in header line in all buffers
;;   (ellama-session-header-line-global-mode +1))

;; == projectile ==
(use-package projectile
  :init
  (setq projectile-auto-discover t)
  (setq projectile-auto-cleanup-known-projects t)
  :config
  (projectile-mode +1))
