;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they load
;; in. Remember to run 'doom sync' after modifying it!

;; NOTE Press 'SPC h d h' (or 'C-h d h' for non-vim users) to access Doom's
;;      documentation. There you'll find a "Module Index" link where you'll find
;;      a comprehensive list of Doom's modules and what flags they support.

;; NOTE Move your cursor over a module's name (or its flags) and press 'K' (or
;;      'C-c c k' for non-vim users) to view its documentation. This works on
;;      flags as well (those symbols that start with a plus).
;;
;;      Alternatively, press 'gd' (or 'C-c c d') on a module to browse its
;;      directory (for easy access to its source code).

;; == GLOBAL ==
(setq frame-inhibit-implied-resize nil)
(setq package-check-signature nil)
(with-eval-after-load 'org
  (setq org-directory "~/org"))
;; Configure `LANG`, otherwise ispell.el cannot find a 'default
;; dictionary' even though multiple dictionaries will be configured
;; in next line.
(setenv "LANG" "en_US.UTF-8")
(custom-set-variables
 '(org-directory "~/org")
 '(org-agenda-files (list org-directory)))
(eval-after-load 'treemacs
  '(treemacs-project-follow-mode))
(advice-add 'json-parse-buffer :around
              (lambda (orig &rest rest)
                (save-excursion
                  (while (re-search-forward "\\\\u0000" nil t)
                    (replace-match "")))
                (apply orig rest)))

;; == org ==
(setq org-sticky-header-full-path 'full)
(add-hook
 'org-mode-hook
 (lambda ()
   (org-sticky-header-mode)
   (setq org-image-actual-width nil)
   (setq org-pretty-entities t)))

(add-hook
 'org-tree-slide-mode
 (lambda ()
   (org-display-inline-images)))


;; (use-package nerd-icons)
;; (setq inhibit-compacting-font-caches t)
;;(setq doom-modeline-icon nil)

;; == HASKELL ==
(add-hook
 'haskell-mode
 '(add-to-list 'company-backends 'company-ghci))

;; == MAIL ==
(add-hook 'mail-mode-hook 'flyspell-mode)
(add-hook 'mail-mode-hook 'flycheck-mode)
(add-hook 'mail-mode-hook 'turn-on-auto-fill)

; open mail-mode when emacs is invoked by mutt
(add-to-list 'auto-mode-alist '("/.tmpmail" . mail-mode))

;; == Docker ==
(add-to-list 'auto-mode-alist '("dockerfile" . dockerfile-mode))

;; == RSS ==
;; (setq rmh-elfeed-org-files '("~/org/elfeed.org"))

;; == Twitter ==
(setq twittering-allow-insecure-server-cert t)

;; == Ispell ==
(add-hook
 'flyspell-mode-hook
 (lambda ()
   ;; Configure `LANG`, otherwise ispell.el cannot find a 'default
   ;; dictionary' even though multiple dictionaries will be configured
   ;; in next line.
   ;; (setenv "LANG" "en_US.UTF-8")
   (setq ispell-program-name "hunspell") ;;
   ;; Configure English and Portuguese.
   (setq ispell-dictionary "en_US") ;;
   ;; (ispell-change-dictionary "en_US")
   ;; ispell-set-spellchecker-params has to be called
   ;; before ispell-hunspell-add-multi-dic will work
   (ispell-set-spellchecker-params) ;;
   (ispell-hunspell-add-multi-dic "pt_BR,en_US") ;;
   (defun ispell-get-coding-system () 'utf-8) ;;
   (ispell-change-dictionary "pt_BR,en_US")
   ;; (setq ispell-alternate-dictionary "pt_BR,en_US")
   (setq ispell-alternate-dictionary "en_US")
   (setq ispell-personal-dictionary "~/.hunspell_personal")))
   ;; (setq company-ispell-dictionary (file-truename "/usr/share/dict/words"))
   ;; (add-to-list 'company-backends 'company-ispell)



;; == imenu ==
(setq imenu-list-auto-resize t)
(setq imenu-list-idle-update-delay 0.5)
;; (add-hook 'prog-mode-hook 'imenu-list-minor-mode)

;; == rainbow-delimiters ==
;(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; == vterm ==
(add-hook 'vterm-mode-hook
          (lambda ()
            (buffer-face-set :font-family "American Typewriter")
            (buffer-face-mode t)))
(setq vterm-ignore-blink-cursor nil)
(global-set-key (kbd "C-'") '+vterm/toggle)

;; == PlatformIO ==
(add-to-list 'auto-mode-alist '("\\.ino$" . arduino-mode))
(add-hook 'c++-mode-hook 'platformio-conditionally-enable)

;; == irony-mode ==
;; (use-package irony
;;   :defer t
;;   :init
;;   (add-hook 'c++-mode-hook 'irony-mode)
;;   (add-hook 'c++-mode-hook 'platformio-conditionally-enable)
;;   (add-hook 'c-mode-hook 'irony-mode)
;;   (add-hook 'objc-mode-hook 'irony-mode)
;;   :config
;;   ;; replace the `completion-at-point' and `complete-symbol' bindings in
;;   ;; irony-mode's buffers by irony-mode's function
;;   ;;(defun my-irony-mode-hook ()
;;   ;;   (define-key irony-mode-map [remap completion-at-point]
;;   ;;   'irony-completion-at-point-async)
;;   ;;   (define-key irony-mode-map [remap complete-symbol]
;;   ;;   'irony-completion-at-point-async))
;;   ;;(add-hook 'irony-mode-hook 'my-irony-mode-hook)
;;   (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
;; )

;; == company-mode ==
(with-eval-after-load 'company
  '(add-hook 'prog-mode-hook #'company-quickhelp-mode)
  '(add-to-list 'company-backends 'company-irony)
  '(add-to-list 'company-backends 'company-lsp)
  '(add-to-list 'company-backends 'company-irony-c-headers))

;; (eval-after-load 'company
;;   '(add-to-list 'company-backends 'company-yasnippet))

;; (eval-after-load 'company
;;   '(yas-global-mode 1))

;; == company-quickhelp-mode ==
(add-hook 'python-mode-hook 'elpy-enable)
;;(use-package company-quickhelp
;;  :defer t
;;  :init
;;  (add-hook 'prog-mode-hook 'company-quickhelp-mode))
;; (setq elpy-rpc-virtualenv-path 'system)

;; == Python ==
(after! dap-mode
  (setq dap-python-debugger 'debugpy))
;; (after! elpy-mode
;;   (setq! elpy-rpc-ignored-buffer-size 110000))
;; (setq! elpy-rpc-ignored-buffer-size 110000)
(setq! elpy-rpc-ignored-buffer-size 999999)

;; == HELM ==
;;(use-package helm
;;  :ensure t
;;  :config
  ;; (helm-mode 1)
;;  (setq! helm-recentf-fuzzy-match t))
  ;; (define-key global-map [remap recentf-open-files] #'helm-recentf)
  ;; (define-key global-map [remap +default/search-project] #'+helm/project-search-from-cwd)
  ;; (define-key global-map [remap find-file] #'helm-find-files)
  ;; (define-key global-map [remap execute-extended-command] #'helm-M-x)
  ;; (define-key global-map [remap switch-to-buffer] #'helm-mini)
  ;; :bind
  ;; ([remap find-file] . #'helm-find-files)
  ;; ("SPC f r" . helm-recentf-fuzzy-match)
  ;; ("C-<next>" . centaur-tabs-forward)
  ;; ("C-{" . centaur-tabs-backward)
  ;; ("C-}" . centaur-tabs-forward)
(setq! helm-recentf-fuzzy-match t)
(define-key global-map [remap recentf-open-files] #'helm-recentf)
(define-key global-map [remap +default/search-project] #'+helm/project-search)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)
;; (after! helm-mode
;;   )

;; == flycheck ==
;; (use-package flycheck
;;   :defer t
;;   :config
;;   (setq flycheck-clang-language-standard "c++17")
;;   (setq flycheck-gcc-language-standard "c++17"))

;; (add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++17")))
;; (add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-language-standard "c++17")))
;; (add-hook 'c-mode-hook (lambda () (setq flycheck-gcc-language-standard "c17")))
;; (add-hook 'c-mode-hook (lambda () (setq flycheck-clang-language-standard "c17")))

;; (use-package flycheck-clang-analyzer
;;   :defer t
;;   :after flycheck
;;   :config
;;   (setq flycheck-clang-language-standard "c++17")
;;   (setq flycheck-gcc-language-standard "c++17")
;;   (flycheck-clang-analyzer-setup))

;; Latex
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

;; == Text mode ==
(defun set-completion-dictionary (choice)
  "Select dictionary for word suggestion"
  (interactive
   (list
    (completing-read "Choose: "
                     '(("pt-br" . "pt-br") ("usa" . "usa")) nil t)))
  (message "Selected dictionary: /usr/share/dict/%s" choice)
  (setq company-ispell-dictionary (file-truename (concat "/usr/share/dict/" choice))))


;; (defun disable-ispell-portuguese ()
;;   (interactive)
;;   (setq-local company-ispell-dictionary nil))

;; (defun toggle-company-ispell ()
;;   (interactive)
;;   (cond
;;    ((memq 'company-ispell company-backends)
;;     (setq company-backends (delete 'company-ispell company-backends))
;;     (message "company-ispell disabled"))
;;    (t
;;     (add-to-list 'company-backends 'company-ispell)
;;     (message "company-ispell enabled"))))

;; (defun initIspellComplete()
;;     (setq company-backends (delete 'company-ispell company-backends)))

;; (add-hook 'text-mode-hook 'initIspellComplete)
;; (add-hook 'markdown-mode-hook 'initIspellComplete)
;; (add-hook 'org-mode-hook 'initIspellComplete)

;; == Markdown mode ==
;; (add-hook 'markdown-mode-hook 'markdown-live-preview-mode)

;; Multi pane navigation controls
;; (global-set-key (kbd "C-x <up>") 'windmove-up)
;; (global-set-key (kbd "C-x <down>") 'windmove-down)
;; (global-set-key (kbd "C-x <left>") 'windmove-left)
;; (global-set-key (kbd "C-x <right>") 'windmove-right)

;; Java
;; (add-hook 'java-mode-hook
;;         (lambda ()
;;                 (meghanada-mode t)
;;                 (flycheck-mode +1)
;;                 (setq c-basic-offset 4)))
;; (setq meghanada-java-path "/usr/bin/java")
(setenv "JAVA_HOME"  "/usr/lib/jvm/java-8-openjdk/jre")
(setq lsp-java-java-path "$JAVA_HOME/bin/java")

;; Org mode ;;
(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("IEEEtran" "\\documentclass[11pt]{IEEEtran}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))


;; Custom hooks ;;
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-b") 'treemacs)
(global-set-key (kbd "C-/") 'comment-line)

(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-Z"))
(global-set-key (kbd "C-z") 'undo-fu-only-undo)
(global-set-key (kbd "C-Z") 'undo-fu-only-redo)
(global-set-key (kbd "C-f") 'isearch-complete)
(add-hook 'kill-emacs-hook 'garbage-collect)

;; Buffer preferences ;;
(global-subword-mode 1)
(setq mouse-drag-and-drop-region t)
(setq line-move-visual t)

(doom! :input
       ;;chinese
       ;;japanese
       ;;layout            ; auie,ctsrnm is the superior home row

       :completion
       (company +childframe)           ; the ultimate code completion backend
       (helm +fuzzy +icons)              ; the *other* search engine for love and life
       (vertico +icons)
       ;;ido               ; the other *other* search engine...
       ;; ivy               ; a search engine for love and life

       :ui
       deft              ; notational velocity for Emacs
       (emoji +github + unicode)
       doom              ; what makes DOOM look the way it does
       doom-dashboard    ; a nifty splash screen for Emacs
       doom-quit         ; DOOM quit-message prompts when you quit Emacs
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       ;;hydra
       indent-guides     ; highlighted indent columns
       ;; ligatures         ; ligatures and symbols to make your code pretty again
       ;;minimap           ; show a map of the code on the side
       modeline          ; snazzy, Atom-inspired modeline, plus API
       nav-flash         ; blink cursor line after big motions
       ;; neotree           ; a project drawer, like NERDTree for vim
       ophints           ; highlight the region an operation acts on
       (popup +all)   ; tame sudden yet inevitable temporary windows
       tabs              ; a tab bar for Emacs
       treemacs          ; a project drawer, like neotree but cooler
       unicode           ; extended unicode support for various languages
       (vc-gutter +pretty)         ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       window-select     ; visually switch windows
       workspaces        ; tab emulation, persistence & separate workspaces
       ;;zen               ; distraction-free coding or writing

       :editor
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       fold              ; (nigh) universal code folding
       format  ; automated prettiness
       ;;god               ; run Emacs commands without modifier keys
       ;;lispy             ; vim for lisp, for people who don't like vim
       multiple-cursors  ; editing in many places at once
       ;;objed             ; text object editing for the innocent
       parinfer          ; turn lisp into python, sort of
       rotate-text       ; cycle region at point between text candidates
       snippets          ; my elves. They type so I don't have to
       ;;word-wrap         ; soft wrapping with language-aware indent

       :emacs
       (dired +icons)             ; making dired pretty [functional]
       electric          ; smarter, keyword-based electric-indent
       (ibuffer +icons)         ; interactive buffer management
       undo              ; persistent, smarter undo for your inevitable mistakes
       vc                ; version-control and Emacs, sitting in a tree

       :term
       ;;eshell            ; the elisp shell that works everywhere
       ;;shell             ; simple shell REPL for Emacs
       ;;term              ; basic terminal emulator for Emacs
       vterm             ; the best terminal emulation in Emacs

       :checkers
       (syntax +childframe)              ; tasing you for every semicolon you forget
       (spell +flyspell +hunspell +everywhere)             ; tasing you for misspelling mispelling
       grammar           ; tasing grammar mistake every you make

       :tools
       ;;ansible
       (debugger +lsp)          ; FIXME stepping through code, to help you add bugs
       direnv
       (docker +lsp)
       editorconfig      ; let someone else argue about tabs vs spaces
       ein               ; tame Jupyter notebooks with emacs
       (eval +overlay)     ; run code, run (also, repls)
       ;;gist              ; interacting with github gists
       (lookup +dictionary)              ; navigate your code and its documentation
       (lsp +peek)
       (magit +forge)             ; a git porcelain for Emacs
       make              ; run make tasks from Emacs
       pass              ; password manager for nerds
       pdf               ; pdf enhancements
       ;;prodigy           ; FIXME managing external services & code builders
       ;;taskrunner        ; taskrunner for all your projects
       terraform         ; infrastructure as code
       ;;tmux              ; an API for interacting with tmux
       upload            ; map local to remote projects via ssh/ftp

       :os
       (:if IS-MAC macos)  ; improve compatibility with macOS
       ;;tty               ; improve the terminal Emacs experience

       :lang
       ;;agda              ; types of types of types of types...
       (cc +lsp)                ; C/C++/Obj-C madness
       ;;clojure           ; java with a lisp
       ;;common-lisp       ; if you've seen one lisp, you've seen them all
       ;;coq               ; proofs-as-programs
       ;;crystal           ; ruby at the speed of c
       ;; csharp            ; unity, .NET, and mono shenanigans
       data              ; config/data formats
       ;;(dart +flutter)   ; paint ui and not much else
       ;;elixir            ; erlang done right
       ;;elm               ; care for a cup of TEA?
       (emacs-lisp +lsp)        ; drown in parentheses
       ;;erlang            ; an elegant language for a more civilized age
       (ess +lsp)               ; emacs speaks statistics
       ;;faust             ; dsp, but you get to keep your soul
       ;;fsharp            ; ML stands for Microsoft's Language
       ;;fstar             ; (dependent) types and (monadic) effects and Z3
       ;;gdscript          ; the language you waited for
       (go +lsp)         ; the hipster dialect
       (haskell +lsp)  ; a language that's lazier than I am
       ;;hy                ; readability of scheme w/ speed of python
       ;;idris             ; a language you can depend on
       (json +lsp)              ; At least it ain't XML
       ;; (java +meghanada) ; the poster child for carpal tunnel syndrome
       (java +lsp) ; the poster child for carpal tunnel syndrome
       (javascript +lsp)        ; all(hope(abandon(ye(who(enter(here))))))
       ;;julia             ; a better, faster MATLAB
       ;;kotlin            ; a better, slicker Java(Script)
       (latex +lsp)             ; writing papers in Emacs has never been so fun
       ;;lean
       ;;factor
       ;;ledger            ; an accounting system in Emacs
       ;;lua               ; one-based indices? one-based indices
       (markdown +grip)          ; writing docs for people to ignore
       ;;nim               ; python + lisp at the speed of c
       ;;nix               ; I hereby declare "nix geht mehr!"
       ;;ocaml             ; an objective camel
       (org +pandoc +pretty +gnuplot +dragndrop +gnuplot +journal +jupyter +noter +present +roam2)               ; organize your plain life in plain text
       ;; php               ; perl's insecure younger brother
       ;; plantuml          ; diagrams for confusing people more
       ;;purescript        ; javascript, but functional
       (python +lsp +pyenv)            ; beautiful is better than ugly
       (qt +lsp)                ; the 'cutest' gui framework ever
       ;;racket            ; a DSL for DSLs
       ;;raku              ; the artist formerly known as perl6
       rest              ; Emacs as a REST client
       rst               ; ReST in peace
       ;; (ruby +rails)     ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       (rust +lsp)              ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       ;;scala             ; java, but good
       ;;scheme            ; a fully conniving family of lisps
       (sh +lsp)                ; she sells {ba,z,fi}sh shells on the C xor
       ;;sml
       ;;solidity          ; do you need a blockchain? No.
       ;;swift             ; who asked for emoji variables?
       ;;terra             ; Earth and Moon in alignment for performance.
       (web +lsp)               ; the tubes
       yaml              ; JSON, but readable

       :email
       ;;(mu4e +gmail)
       ;;notmuch
       ;;(wanderlust +gmail)

       :app
       calendar
       ;;irc               ; how neckbeards socialize
       (rss +org)        ; emacs as an RSS reader
       ;; twitter           ; twitter client https://twitter.com/vnought

       :config
       ;;literate
       (default +bindings +smartparens))
