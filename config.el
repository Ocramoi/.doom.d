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

;; == environment ==
(use-package doom-themes :ensure t :defer t
  :config
  (setcdr (assoc 'gnus-group-news-low-empty doom-themes-base-faces)
          '(:inherit 'gnus-group-mail-1-empty :weight 'normal)))

;; == LSP ==
(setq lsp-headerline-breadcrumb-enable t)
(setq lsp-lens-enable t)
(setq lsp-file-watch-ignored-directories '("[/\\\\]\\.git\\'" "[/\\\\]\\.github\\'" "[/\\\\]node_modules\\'"))

;;      == web ==
(add-hook 'vue-mode-hook #'lsp!)

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
  (setq org-roam-v2-ack t))

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

;; == citar ==
(use-package citar-org
  :after oc
  :custom
  (org-cite-insert-processor 'citar)
  (org-cite-follow-processor 'citar)
  (org-cite-activate-processor 'citar))

(use-package citar-org-roam
  :after (citar org-roam)
  :config (citar-org-roam-mode))

;; == dap ==
(require 'cl-lib)
(require 'subr-x)

(defconst +dap/custom-keys
  '(:dap-test-dll :dap-sdk-prefix :dap-test-filter :dap-repo :dap-project-dir :dap-profile)
  "Internal metadata keys stripped before sending DAP requests to adapters.")

(defconst +dap/csharp-ignored-scan-dirs
  '(".git" ".github" ".vs" ".idea" ".agent" ".agents" ".claude" "bin" "obj" "node_modules" "wwwroot" "Logs")
  "Directory names skipped when scanning workspaces for `.csproj' files.")

(defvar +dap/registered-csharp-roots nil
  "Alist of `(EXPANDED-ROOT-DIR . REPO-SYMBOL)' registered via `+dap/register-csharp-repo!'.")

(defun +dap/dotnet-sdk-roots ()
  "Candidate directories containing installed .NET SDK versions across OSes."
  (let ((dotnet-bin (executable-find "dotnet")))
    (delq nil
          (delete-dups
           (list (when dotnet-bin
                   (expand-file-name "sdk" (file-name-directory (file-truename dotnet-bin))))
                 "/usr/share/dotnet/sdk"
                 "/usr/local/share/dotnet/sdk"
                 "/opt/homebrew/opt/dotnet/libexec/sdk"
                 (expand-file-name "~/.dotnet/sdk"))))))

(defun +dap/find-dotnet-sdk-dir (major-prefix)
  "Return the latest installed .NET SDK path matching MAJOR-PREFIX (e.g. \"9.0.\")."
  (cl-loop for sdk-root in (+dap/dotnet-sdk-roots)
           when (file-directory-p sdk-root)
           for matches = (sort (directory-files sdk-root t (concat "^" (regexp-quote major-prefix)))
                               #'string-version-lessp)
           when matches return (car (last matches))))

(defun +dap/tfm-to-sdk-prefix (tfm)
  "Derive major.minor SDK prefix (e.g. \"3.1.\" or \"9.0.\") from TFM."
  (when (and tfm (string-match "^\\(?:netcoreapp\\|net\\)\\([0-9]+\\.[0-9]+\\)" tfm))
    (concat (match-string 1 tfm) ".")))

(defun +dap/dotnet-build-cmd (csproj sdk-prefix)
  "Build command for CSPROJ pinned to matching SDK-PREFIX when installed."
  (let ((sdk-dir (and sdk-prefix (+dap/find-dotnet-sdk-dir sdk-prefix))))
    (if (and sdk-dir (file-exists-p (expand-file-name "MSBuild.dll" sdk-dir)))
        (format "DOTNET_MSBUILD_SDK_RESOLVER_SDKS_DIR=%s dotnet %s %s -restore -p:Configuration=Debug -v:m -nologo"
                (shell-quote-argument (expand-file-name "Sdks" sdk-dir))
                (shell-quote-argument (expand-file-name "MSBuild.dll" sdk-dir))
                (shell-quote-argument csproj))
      (format "dotnet build %s -c Debug -v m --nologo"
              (shell-quote-argument csproj)))))

(defun +dap/parse-jsonc-file (file)
  "Parse JSON-with-comments (JSONC) FILE (handling UTF-8 BOM and trailing commas)."
  (when (file-readable-p file)
    (condition-case nil
        (with-temp-buffer
          (insert-file-contents file)
          (let* ((raw (buffer-string))
                 (s1 (replace-regexp-in-string "\\`\uFEFF" "" raw))
                 (s2 (replace-regexp-in-string
                      "\\(\"\\(?:\\\\.\\|[^\"\\\\]\\)*\"\\)\\|//[^\n\r]*\\|/\\*\\(?:.\\|\n\\)*?\\*/"
                      (lambda (m) (or (match-string 1 m) ""))
                      s1 t t))
                 (s3 (replace-regexp-in-string ",\\(\\s-*[}\\]]\\)" "\\1" s2)))
            (json-parse-string s3 :object-type 'alist :array-type 'list)))
      (error nil))))

(defun +dap/parse-csproj (csproj)
  "Inspect CSPROJ and return metadata plist (:kind :tfm :sdk-prefix :assembly :test-runner),
or nil if CSPROJ is a non-runnable Class Library."
  (when (file-readable-p csproj)
    (with-temp-buffer
      (insert-file-contents csproj)
      (let* ((case-fold-search t)
             (is-test (save-excursion
                        (or (re-search-forward
                             "Include=\"\\(?:Microsoft\\.NET\\.Test\\.Sdk\\|xunit\\|MSTest\\.TestAdapter\\|NUnit\\)" nil t)
                            (re-search-forward "<IsTestProject>\\s-*true\\s-*</IsTestProject>" nil t))))
             (is-web (save-excursion
                       (re-search-forward
                        "<Project[^>]*Sdk=\"Microsoft\\.NET\\.Sdk\\.\\(?:Web\\|Worker\\)\"" nil t)))
             (is-exe (save-excursion
                       (re-search-forward
                        "<OutputType>\\s-*\\(?:Win\\)?Exe\\s-*</OutputType>" nil t)))
             (kind (cond (is-test 'test)
                         (is-web  'web)
                         (is-exe  'console)
                         (t       nil))))
        (when kind
          (let* ((tfm (save-excursion
                        (when (re-search-forward "<TargetFrameworks?>\\([^<]+\\)</TargetFrameworks?>" nil t)
                          (car (last (split-string (string-trim (match-string 1)) ";" t "\\s-+"))))))
                 (asm (or (save-excursion
                            (when (re-search-forward "<AssemblyName>\\([^<]+\\)</AssemblyName>" nil t)
                              (string-trim (match-string 1))))
                          (file-name-base csproj)))
                 (runner (when (eq kind 'test)
                           (cond ((save-excursion (re-search-forward "Include=\"xunit" nil t)) "xUnit")
                                 ((save-excursion (re-search-forward "Include=\"MSTest" nil t)) "MSTest")
                                 ((save-excursion (re-search-forward "Include=\"NUnit" nil t)) "NUnit")
                                 (t "Test")))))
            (list :kind kind
                  :tfm tfm
                  :sdk-prefix (+dap/tfm-to-sdk-prefix tfm)
                  :assembly asm
                  :test-runner runner)))))))

(defun +dap/parse-launch-profiles (proj-dir kind)
  "Read `Properties/launchSettings.json' in PROJ-DIR and return runnable Project profiles."
  (let* ((ls-file (expand-file-name "Properties/launchSettings.json" proj-dir))
         (data (+dap/parse-jsonc-file ls-file))
         (profiles (alist-get 'profiles data))
         result)
    (dolist (entry profiles)
      (let* ((prof-name (symbol-name (car entry)))
             (prof (cdr entry))
             (cmd-name (alist-get 'commandName prof)))
        (when (equal cmd-name "Project")
          (let ((app-url (alist-get 'applicationUrl prof))
                (cmd-args (alist-get 'commandLineArgs prof))
                (env-alist (alist-get 'environmentVariables prof))
                (env-plist nil))
            (dolist (kv env-alist)
              (setq env-plist
                    (plist-put env-plist
                               (intern (concat ":" (symbol-name (car kv))))
                               (format "%s" (cdr kv)))))
            (when (and (stringp app-url) (not (string-empty-p app-url))
                       (not (plist-member env-plist :ASPNETCORE_URLS)))
              (setq env-plist (plist-put env-plist :ASPNETCORE_URLS app-url)))
            (when (and (eq kind 'web)
                       (not (plist-member env-plist :ASPNETCORE_ENVIRONMENT)))
              (setq env-plist (plist-put env-plist :ASPNETCORE_ENVIRONMENT "Development")))
            (push (list :profile prof-name
                        :env env-plist
                        :urls (plist-get env-plist :ASPNETCORE_URLS)
                        :args (if (and (stringp cmd-args) (not (string-empty-p cmd-args)))
                                  (vconcat (split-string-and-unquote cmd-args))
                                []))
                  result)))))
    (or (nreverse result)
        (list (list :profile (file-name-nondirectory (directory-file-name proj-dir))
                    :env (when (eq kind 'web) (list :ASPNETCORE_ENVIRONMENT "Development"))
                    :urls nil
                    :args [])))))

(defun +dap/format-ports-label (urls)
  "Turn \"https://localhost:9001;http://localhost:9101\" into \":9001 / :9101\"."
  (when (and (stringp urls) (not (string-empty-p urls)))
    (let ((ports nil)
          (start 0))
      (while (string-match ":\\([0-9]+\\)" urls start)
        (let ((p (concat ":" (match-string 1 urls))))
          (unless (member p ports) (push p ports)))
        (setq start (match-end 0)))
      (when ports
        (string-join (nreverse ports) " / ")))))

(defun +dap/merge-plists (base override)
  "Return a new plist with keys from OVERRIDE merged on top of BASE."
  (let ((out (copy-sequence base))
        (rest override))
    (while rest
      (setq out (plist-put out (pop rest) (pop rest))))
    out))

(cl-defun +dap/build-csharp-templates (path &key name prefix repo cwd urls args env profile sdk tfm mode)
  "Build `(TEMPLATE-NAME . CONFIG-PLIST)' entries from PATH (`.csproj' or project dir)."
  (let* ((expanded (expand-file-name path))
         (csproj (if (string-suffix-p ".csproj" expanded t)
                     expanded
                   (car (directory-files expanded t "\\.csproj\\'"))))
         (proj-dir-clean (and csproj (directory-file-name (file-name-directory csproj))))
         (proj-name (and proj-dir-clean (file-name-nondirectory proj-dir-clean)))
         (meta (and csproj (+dap/parse-csproj csproj))))
    (when (and csproj meta)
      (let* ((kind (or mode (plist-get meta :kind)))
             (use-tfm (or tfm (plist-get meta :tfm) "net9.0"))
             (use-sdk (or sdk (plist-get meta :sdk-prefix)))
             (asm (plist-get meta :assembly))
             (dll (expand-file-name (format "bin/Debug/%s/%s.dll" use-tfm asm) proj-dir-clean))
             (resolved-cwd (if cwd
                               (expand-file-name cwd proj-dir-clean)
                             proj-dir-clean))
             (build-cmd (+dap/dotnet-build-cmd csproj use-sdk)))
        (if (eq kind 'test)
            (let ((tpl-name (or name
                                (format "%s%s (%s)"
                                        (if prefix (concat prefix " :: Test :: ") "")
                                        proj-name
                                        (or (plist-get meta :test-runner) "Test")))))
              (list
               (cons tpl-name
                     (list :type "coreclr"
                           :request "attach"
                           :mode "test"
                           :name tpl-name
                           :cwd resolved-cwd
                           :dap-test-dll dll
                           :dap-sdk-prefix use-sdk
                           :dap-compilation build-cmd
                           :dap-compilation-dir proj-dir-clean
                           :dap-repo repo
                           :dap-project-dir proj-dir-clean
                           :dap-profile proj-name))))
          (let* ((all-profiles (+dap/parse-launch-profiles proj-dir-clean kind))
                 (selected-profiles
                  (if profile
                      (or (cl-remove-if-not
                           (lambda (p) (equal (plist-get p :profile) profile))
                           all-profiles)
                          (list (car all-profiles)))
                    all-profiles)))
            (mapcar
             (lambda (prof)
               (let* ((prof-name (plist-get prof :profile))
                      (merged-env (+dap/merge-plists (plist-get prof :env) env))
                      (final-env (if urls
                                     (plist-put (copy-sequence merged-env) :ASPNETCORE_URLS urls)
                                   merged-env))
                      (ports-str (+dap/format-ports-label (plist-get final-env :ASPNETCORE_URLS)))
                      (sub-prof (and (not (string-equal-ignore-case prof-name proj-name))
                                     (format " [%s]" prof-name)))
                      (tpl-name
                       (or name
                           (format "%s%s%s%s"
                                   (if prefix (concat prefix " :: ") "")
                                   proj-name
                                   (or sub-prof "")
                                   (cond (ports-str (format " (%s)" ports-str))
                                         ((eq kind 'console) " (Console)")
                                         (t ""))))))
                 (cons tpl-name
                       (list :type "coreclr"
                             :request "launch"
                             :mode "launch"
                             :name tpl-name
                             :program dll
                             :cwd resolved-cwd
                             :args (or args (plist-get prof :args) [])
                             :stopAtEntry :json-false
                             :env final-env
                             :dap-compilation build-cmd
                             :dap-compilation-dir proj-dir-clean
                             :dap-repo repo
                             :dap-project-dir proj-dir-clean
                             :dap-profile prof-name))))
             selected-profiles)))))))

(defun dap-csharp! (path &rest args)
  "Concise 1-liner to register (or override) a C# project in `dap-mode'.
PATH can be a project directory or `.csproj' path.
Optional keyword ARGS: `:name', `:prefix', `:repo', `:cwd', `:urls', `:args',
`:env', `:profile', `:sdk', `:tfm', `:mode'.

Examples:
  (dap-csharp! \"~/Projects/MyApp/src/MyApi\")
  (dap-csharp! \"~/Projects/MyApp/src/MyApi\" :urls \"http://localhost:5050\" :env '(:FOO \"bar\"))"
  (dolist (entry (reverse (apply #'+dap/build-csharp-templates path args)))
    (let ((pdir (plist-get (cdr entry) :dap-project-dir))
          (prof (plist-get (cdr entry) :dap-profile)))
      (setq dap-debug-template-configurations
            (cl-remove-if
             (lambda (existing)
               (or (equal (car existing) (car entry))
                   (and pdir prof
                        (equal (plist-get (cdr existing) :dap-project-dir) pdir)
                        (equal (plist-get (cdr existing) :dap-profile) prof))))
             dap-debug-template-configurations))
      (dap-register-debug-template (car entry) (cdr entry)))))

(defun +dap/find-csproj-files (root)
  "Fast recursive `.csproj' finder under ROOT skipping `bin', `obj', `.git', etc."
  (let ((expanded-root (expand-file-name root)))
    (when (file-directory-p expanded-root)
      (sort
       (directory-files-recursively
        expanded-root "\\.csproj\\'" nil
        (lambda (subdir)
          (not (member (file-name-nondirectory (directory-file-name subdir))
                       +dap/csharp-ignored-scan-dirs))))
       #'string<))))

(cl-defun +dap/register-csharp-repo! (root &key prefix repo)
  "Auto-discover and register all runnable Web/Console/Test `.csproj' projects in ROOT."
  (let* ((expanded-root (directory-file-name (expand-file-name root)))
         (repo-sym (or repo (intern (file-name-nondirectory expanded-root))))
         (csprojs (+dap/find-csproj-files expanded-root))
         web-or-console
         tests)
    (setf (alist-get expanded-root +dap/registered-csharp-roots nil nil #'file-equal-p) repo-sym)
    (dolist (csproj csprojs)
      (dolist (tpl (+dap/build-csharp-templates csproj :prefix prefix :repo repo-sym))
        (if (equal (plist-get (cdr tpl) :mode) "test")
            (push tpl tests)
          (push tpl web-or-console))))
    (dolist (tpl tests)
      (dap-register-debug-template (car tpl) (cdr tpl)))
    (dolist (tpl web-or-console)
      (dap-register-debug-template (car tpl) (cdr tpl)))))

(defun +dap/csharp-workspace-auto-provider ()
  "Dynamic `dap-mode' provider: auto-discovers runnable `.csproj' projects in the
current C# workspace when not already pre-registered via `+dap/register-csharp-repo!'."
  (when (featurep 'dap-netcore)
    (let ((ws-root (or (and (fboundp 'lsp-workspace-root) (lsp-workspace-root))
                       (and (fboundp 'projectile-project-root)
                            (let (projectile-require-project-root)
                              (projectile-project-root))))))
      (when (and ws-root
                 (file-directory-p ws-root)
                 (not (cl-some (lambda (pair) (file-equal-p ws-root (car pair)))
                               +dap/registered-csharp-roots)))
        (let ((prefix (file-name-nondirectory (directory-file-name ws-root)))
              (known-dirs (mapcar (lambda (e) (plist-get (cdr e) :dap-project-dir))
                                  dap-debug-template-configurations))
              discovered)
          (dolist (csproj (+dap/find-csproj-files ws-root))
            (let ((pdir (directory-file-name (file-name-directory csproj))))
              (unless (member pdir known-dirs)
                (dolist (tpl (+dap/build-csharp-templates csproj :prefix prefix))
                  (push tpl discovered)))))
          (nreverse discovered))))))

(defun +dap/read-dotnet-pid ()
  "Interactively select a running .NET process and return its PID as an integer."
  (let* ((raw-lines (and (executable-find "ps") (process-lines "ps" "-eo" "pid=,args=")))
         (candidates
          (delq nil
                (mapcar
                 (lambda (line)
                   (when (and (string-match "^\\s-*\\([0-9]+\\)\\s-+\\(.+\\)$" line)
                              (let ((cmd (match-string 2 line)))
                                (and (string-match-p "dotnet\\|\\.dll\\b" cmd)
                                     (not (string-match-p
                                           "csharp-ls\\|netcoredbg\\|MSBuild\\.dll\\|VBCSCompiler\\|omnisharp"
                                           cmd)))))
                     (cons (format "%s — %s" (match-string 1 line) (match-string 2 line))
                           (string-to-number (match-string 1 line)))))
                 raw-lines))))
    (if candidates
        (let* ((choice (completing-read "Attach netcoredbg to process: "
                                        (mapcar #'car candidates) nil nil))
               (matched (assoc choice candidates)))
          (if matched
              (cdr matched)
            (string-to-number choice)))
      (string-to-number (read-string "Enter .NET process PID manually: ")))))

(defun +dap/vstest-startup-fn (launch-args)
  "Launch VSTest with `VSTEST_HOST_DEBUG=1' and populate `:processId' on LAUNCH-ARGS."
  (let* ((test-dll (plist-get launch-args :dap-test-dll))
         (sdk-prefix (plist-get launch-args :dap-sdk-prefix))
         (test-filter (plist-get launch-args :dap-test-filter))
         (cwd (or (plist-get launch-args :cwd) default-directory))
         (sdk-dir (and sdk-prefix (+dap/find-dotnet-sdk-dir sdk-prefix)))
         (vstest-dll (and sdk-dir (expand-file-name "vstest.console.dll" sdk-dir)))
         (buf-name (format "*dap-vstest: %s*" (or (plist-get launch-args :name) "dotnet-test")))
         (buf (get-buffer-create buf-name))
         (default-directory cwd)
         (process-environment (cons "VSTEST_HOST_DEBUG=1" (copy-sequence process-environment)))
         (cmd (append (if (and vstest-dll (file-exists-p vstest-dll))
                          (list "dotnet" vstest-dll test-dll)
                        (list "dotnet" "test" "--no-build" test-dll))
                      (when (and test-filter (not (string-empty-p test-filter)))
                        (list (format "--TestCaseFilter:%s" test-filter)))))
         proc
         pid)
    (unless (and test-dll (file-exists-p test-dll))
      (user-error "Test assembly not found: %s" test-dll))
    (with-current-buffer buf
      (let ((inhibit-read-only t))
        (erase-buffer)
        (insert (format "Running: %s\n\n" (string-join cmd " ")))))
    (setq proc (apply #'start-process "dap-vstest" buf cmd))
    (let ((deadline (+ (float-time) 20.0)))
      (while (and (not pid)
                  (process-live-p proc)
                  (< (float-time) deadline))
        (accept-process-output proc 0.1)
        (with-current-buffer buf
          (save-excursion
            (goto-char (point-min))
            (when (re-search-forward "Process Id:\\s-*\\([0-9]+\\)" nil t)
              (setq pid (string-to-number (match-string 1))))))))
    (unless pid
      (display-buffer buf)
      (when (process-live-p proc)
        (delete-process proc))
      (user-error "Timed out waiting for VSTest debug host PID (see %s)" buf-name))
    (plist-put launch-args :mode "attach")
    (plist-put launch-args :request "attach")
    (plist-put launch-args :processId pid)
    (message "Attached netcoredbg to VSTest testhost (PID %d)" pid)))

(defun +dap/csharp-method-at-point ()
  "Best-effort extraction of the enclosing C# method name at point."
  (save-excursion
    (end-of-line)
    (when (re-search-backward
           "\\b\\(?:public\\|private\\|protected\\|internal\\)\\s-+\\(?:static\\s-+\\)?\\(?:async\\s-+\\)?[A-Za-z0-9_<>,?\\[\\]]+\\s-+\\([A-Za-z_][A-Za-z0-9_]*\\)\\s-*("
           nil t)
      (match-string-no-properties 1))))

(defun +dap/attach-dotnet-process ()
  "Pick a running .NET process and attach `netcoredbg' via `dap-mode'."
  (interactive)
  (require 'dap-mode)
  (require 'dap-netcore)
  (let ((pid (+dap/read-dotnet-pid)))
    (dap-debug (list :type "coreclr"
                     :request "attach"
                     :mode "attach"
                     :name (format ".NET :: Attach (PID %d)" pid)
                     :processId pid))))

(defun +dap/debug-dotnet-test-filtered ()
  "Select a .NET test project, prompt for an optional VSTest filter, and debug."
  (interactive)
  (require 'dap-mode)
  (require 'dap-netcore)
  (let* ((buf-dir (expand-file-name (or (and buffer-file-name (file-name-directory buffer-file-name))
                                        default-directory)))
         (all-configs (append (+dap/csharp-workspace-auto-provider)
                              dap-debug-template-configurations))
         (test-templates
          (cl-remove-if-not
           (lambda (entry) (equal (plist-get (cdr entry) :mode) "test"))
           all-configs))
         (_ (unless test-templates
              (user-error "No .NET test projects found in current workspace or registered repos")))
         (matching-current
          (cl-find-if
           (lambda (entry)
             (let ((pdir (plist-get (cdr entry) :dap-project-dir)))
               (and pdir (string-prefix-p (file-name-as-directory pdir)
                                          (file-name-as-directory buf-dir)))))
           test-templates))
         (selected-name
          (completing-read "Test project to debug: "
                           (mapcar #'car test-templates)
                           nil t nil nil
                           (car matching-current)))
         (conf (copy-tree (cdr (assoc selected-name test-templates))))
         (default-filter (+dap/csharp-method-at-point))
         (filter (read-string
                  (if default-filter
                      (format "VSTest filter (default %s, empty for all): " default-filter)
                    "VSTest filter (e.g. FullyQualifiedName~MyTest, empty for all): ")
                  nil nil default-filter)))
    (unless (string-empty-p filter)
      (plist-put conf :dap-test-filter filter)
      (plist-put conf :name (format "%s [%s]" selected-name filter)))
    (dap-debug conf)))

(defun +dap/debug-current-project ()
  "Smart project debugger across languages:
- Inside a known/discovered runnable C# project: launches its DAP config directly.
- Inside a C# Class Library in a multi-project repo: prompts only among that repo's hosts/tests.
- In any other language (Python, Go, Rust, C/C++, JS/TS, Java, etc.): invokes `dap-debug'."
  (interactive)
  (require 'dap-mode)
  (when (derived-mode-p 'csharp-mode 'csharp-ts-mode)
    (require 'dap-netcore))
  (let* ((buf-dir (file-name-as-directory
                   (expand-file-name (or (and buffer-file-name (file-name-directory buffer-file-name))
                                         default-directory))))
         (auto-configs (+dap/csharp-workspace-auto-provider))
         (all-configs (append auto-configs dap-debug-template-configurations))
         (direct-match
          (cl-find-if
           (lambda (entry)
             (let ((pdir (plist-get (cdr entry) :dap-project-dir)))
               (and pdir (string-prefix-p (file-name-as-directory pdir) buf-dir))))
           all-configs))
         (registered-repo
          (cl-find-if
           (lambda (pair) (string-prefix-p (file-name-as-directory (car pair)) buf-dir))
           +dap/registered-csharp-roots)))
    (cond
     (direct-match
      (dap-debug (copy-tree (cdr direct-match))))
     (registered-repo
      (let* ((candidates (cl-remove-if-not
                          (lambda (e) (eq (plist-get (cdr e) :dap-repo) (cdr registered-repo)))
                          dap-debug-template-configurations))
             (choice (completing-read "Library project — select host/test to debug: "
                                      (mapcar #'car candidates) nil t)))
        (dap-debug (copy-tree (cdr (assoc choice candidates))))))
     ((= (length auto-configs) 1)
      (dap-debug (copy-tree (cdar auto-configs))))
     (auto-configs
      (let ((choice (completing-read "Select workspace C# target to debug: "
                                     (mapcar #'car auto-configs) nil t)))
        (dap-debug (copy-tree (cdr (assoc choice auto-configs))))))
     (t
      (call-interactively #'dap-debug)))))

(use-package! dap-mode
  :defer t
  :init
  ;; Ensure user-local debuggers & language servers (`~/.local/bin`, `~/.dotnet/tools`,
  ;; `~/go/bin`, `~/.cargo/bin`) are visible in GUI / daemon Emacs sessions.
  (dolist (dir (list (expand-file-name "~/.local/bin")
                     (expand-file-name "~/.dotnet/tools")
                     (expand-file-name "~/go/bin")
                     (expand-file-name "~/.cargo/bin")))
    (when (file-directory-p dir)
      (add-to-list 'exec-path dir)
      (unless (member dir (parse-colon-path (getenv "PATH")))
        (setenv "PATH" (concat dir path-separator (getenv "PATH"))))))

  ;; Lazily activate language-specific DAP adapters only when visiting those modes
  ;; so `SPC d d' stays uncluttered and works out of the box across languages.
  (cl-flet ((+dap-lazy-adapter (hooks features)
              (dolist (h hooks)
                (add-hook h (lambda ()
                              (after! dap-mode
                                (dolist (feat features)
                                  (require feat nil t))))))))
    (+dap-lazy-adapter '(csharp-mode-hook csharp-ts-mode-hook) '(dap-netcore))
    (+dap-lazy-adapter '(python-mode-hook python-ts-mode-hook) '(dap-python))
    (+dap-lazy-adapter '(go-mode-hook go-ts-mode-hook) '(dap-dlv-go))
    (+dap-lazy-adapter '(rust-mode-hook rust-ts-mode-hook rustic-mode-hook
                         c-mode-hook c-ts-mode-hook c++-mode-hook c++-ts-mode-hook)
                       '(dap-codelldb dap-gdb))
    (+dap-lazy-adapter '(js-mode-hook js-ts-mode-hook typescript-mode-hook
                         typescript-ts-mode-hook web-mode-hook)
                       '(dap-node dap-chrome))
    (+dap-lazy-adapter '(ruby-mode-hook ruby-ts-mode-hook) '(dap-ruby)))

  (map! :leader
        (:prefix ("o" . "open")
         :desc "Start DAP debugger" "d" #'dap-debug)
        (:prefix ("d" . "dap debugger")
         :desc "Debug template"             "d" #'dap-debug
         :desc "Debug current project"      "p" #'+dap/debug-current-project
         :desc "Debug last"                 "l" #'dap-debug-last
         :desc "Debug recent"               "r" #'dap-debug-recent
         :desc "Restart session"            "R" #'dap-debug-restart
         :desc "Attach to .NET process"     "a" #'+dap/attach-dotnet-process
         :desc "Debug .NET test (filtered)" "t" #'+dap/debug-dotnet-test-filtered
         :desc "DAP Hydra"                  "h" #'dap-hydra
         :desc "Continue"                   "c" #'dap-continue
         :desc "Next (step over)"           "n" #'dap-next
         :desc "Step in"                    "i" #'dap-step-in
         :desc "Step in"                    "s" #'dap-step-in
         :desc "Step out"                   "o" #'dap-step-out
         :desc "Toggle breakpoint"          "b" #'dap-breakpoint-toggle
         :desc "Delete all breakpoints"     "B" #'dap-breakpoint-delete-all
         :desc "Breakpoint condition"       "C" #'dap-breakpoint-condition
         :desc "Breakpoint log message"     "L" #'dap-breakpoint-log-message
         :desc "Eval thing at point"        "e" #'dap-eval-thing-at-point
         :desc "Eval expression"            "E" #'dap-eval
         :desc "Watch add expression"       "w" #'dap-ui-expressions-add
         :desc "DAP UI REPL"                "u" #'dap-ui-repl
         :desc "DAP UI locals"              "v" #'dap-ui-locals
         :desc "DAP UI sessions"            "S" #'dap-ui-sessions
         :desc "Disconnect / quit"          "q" #'dap-disconnect
         :desc "Delete all sessions"        "Q" #'dap-delete-all-sessions
         :desc "Dape (fallback)"            "D" #'dape))
  :config
  (require 'dap-ui)
  (require 'dap-mouse)
  (require 'dap-hydra)
  (setq dap-auto-configure-features
        (append '(sessions locals breakpoints expressions)
                (when (display-graphic-p) '(tooltip)))
        dap-debug-compilation-keep nil)
  (dap-auto-configure-mode 1)

  (after! dap-python
    (setq dap-python-debugger 'debugpy))

  (defadvice! +dap/cleanup-custom-keys-a (args)
    :filter-return #'dap--cleanup-arguments
    (dolist (k +dap/custom-keys)
      (setq args (dap--plist-delete args k)))
    args))

;;     == dap-netcore (generic C# / .NET) ==
(use-package! dap-netcore
  :defer t
  :custom
  (dap-netcore-install-dir (expand-file-name "~/.local/share"))
  :config
  (defadvice! +dap/netcore-populate-args-a (orig-fn conf)
    :around #'dap-netcore--populate-args
    (pcase (plist-get conf :mode)
      ("test"
       (dap--put-if-absent conf :dap-server-path
                           (list (dap-netcore--debugger-locate-or-install) "--interpreter=vscode"))
       (plist-put conf :startup-function #'+dap/vstest-startup-fn)
       conf)
      ("attach-picker"
       (let ((pid (+dap/read-dotnet-pid)))
         (plist-put conf :mode "attach")
         (plist-put conf :processId pid)
         (funcall orig-fn conf)))
      (_
       (funcall orig-fn conf))))

  ;; Auto-discover runnable `.csproj' targets in any C# workspace you open:
  (setq dap-launch-configuration-providers
        (cl-adjoin #'+dap/csharp-workspace-auto-provider
                   dap-launch-configuration-providers))

  (dap-register-debug-template
   ".NET :: Attach to Running Process"
   (list :type "coreclr"
         :request "attach"
         :mode "attach-picker"
         :name ".NET :: Attach")))

;; Load machine-local WeMov DAP config only if present (gitignored on shared repo):
(load! "wemov-dap" nil t)
