;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)

;; == lsp ==
(package! rainbow-delimiters)
(package! zenity-color-picker)
(package! yasnippet)
(package! web-completion-data)
(package! visual-fill-column)
(package! spinner)
(package! s)
(package! real-auto-save)
(package! pyenv)
(package! python-cell)
(package! pos-tip)
(package! popup)
(package! pkg-info)
(package! pcache)
(package! pandoc)
(package! pandoc-mode)
(package! mips-mode)
(package! lv)
(package! java-imports)
(package! irony)
(package! irony-eldoc)
(package! imenu-list)
(package! hydra)
(package! ht)
(package! highlight-indentation)
(package! gemini-mode)
(package! fzf)
(package! flymake)
(package! flymake-quickdef)
(package! flycheck)
(package! flycheck-irony)
(package! f)
(package! epl)
(package! elpy)
(package! dash)
(package! auctex)
(package! bind-key)
(package! auto-complete)
(package! arduino-mode)
(package! vterm-toggle)
(package! 2048-game)
(package! ebib)
(package! rtags)
(package! platformio-mode)
(package! vue-mode)
(package! org-ros)
(package! org-sticky-header)
(package! org-tree-slide)
(package! osc)
(package! sonic-pi)
(package! omnisharp)
(package! nerd-icons)
(package! lsp-haskell)
(package! eglot)
(package! lsp-ui)
(package! flx-ido)
(package! powerline)
(package! copilot)
(package! prisma-mode :recipe (:host github :repo "pimeys/emacs-prisma-mode" :branch "main"))
(package! eslint-fix)
(package! gptel)
(package! copilot-chat)
(package! ellama)
(package! graphql-mode)
(package! lsp-tailwindcss :recipe (:host github :repo "merrickluo/lsp-tailwindcss"))
(package! exec-path-from-shell)
(package! rainboe-csv-mode :recipe (:host github :repo "emacs-vs/rainbow-csv" :branch "master"))
(package! org-wc)
(package! scss-mode)
(package! less-css-mode)
(unpin! org-roam)
(package! code-cells)
