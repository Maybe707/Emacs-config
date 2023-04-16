(eval-when-compile
  (require 'use-package))

(setq redisplay-dont-pause t
  scroll-margin 5
  scroll-step 1
  scroll-conservatively 10000
	scroll-preserve-screen-position 1)

(global-set-key "\C-x\ \C-g" 'recentf-open-files)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Example configuration for Consult
(use-package consult
  :ensure t
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s m" . consult-multi-occur)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element
  )

(use-package lsp-haskell
  :ensure t)

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package company
  :ensure t
  :hook (c++-mode c-mode rust-mode haskell-mode glsl-mode)
;;  :hook (after-init global-company-mode)
  :config
  (setq company-minimum-prefix-length 1
		company-idle-delay 0.01)
  (define-key company-active-map (kbd "C-n") nil)
  (define-key company-active-map (kbd "C-p") nil)
  (define-key company-active-map (kbd "<tab>") #'company-select-next)
  (define-key company-active-map (kbd "<backtab>") #'company-select-previous))

(use-package lsp-ui
  :ensure t)

(use-package lsp-mode
  :ensure t
  :hook (c++-mode c-mode rust-mode haskell-mode haskell-literate-mode)
  :config
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024))
  (setq lsp-idle-delay 0.100)
  (setq lsp-log-io nil)
  (setq lsp-ui-doc-show-with-cursor t))

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  :custom
  (dashboard-center-content t)
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons t))

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package visual-regexp
  :ensure t
  :config
  (define-key global-map (kbd "C-c r") 'vr/replace)
  (define-key global-map (kbd "C-c q") 'vr/query-replace))

(use-package ace-jump-mode
  :ensure t
  :config
  (autoload
	'ace-jump-mode
	"ace-jump-mode"
	"Emacs quick move minor mode"
	t)
  (define-key global-map (kbd "C-c SPC") 'ace-jump-mode))

(use-package rust-mode
  :ensure t
  :mode ("\\.rs\\'" . rust-mode)
  :interpreter ("rust-mode" . rust-mode))

(use-package haskell-mode
  :ensure t
  :mode ("\\.hs\\'" . haskell-mode)
  :interpreter ("haskell-mode" . haskell-mode))

(use-package glsl-mode
  :ensure t)

(use-package slime
  :ensure t
  :custom
  (slime-setup '(slime-asdf
				 slime-fancy
				 slime-indentation)))

(use-package ac-slime
  :ensure t
  :hook (((slime-mode slime-repl-mode) . set-up-slime-ac)
		 ((slime-mode slime-repl-mode) . auto-complete-mode))
  :custom
  (eval-after-load "auto-complete"
	'(add-to-list 'ac-modes 'slime-repl-mode)))

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration
               '(glsl-mode . "glsl"))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("glslls" "--stdin"))
                    :activation-fn (lsp-activate-on "glsl")
                    :server-id 'glslls)))

(use-package tree-sitter
  :ensure t
  :hook ((c++-mode c-mode rust-mode haskell-mode glsl-mode) . tree-sitter-hl-mode)
  :config
  (global-tree-sitter-mode))

(use-package tree-sitter-langs
  :ensure t)

(use-package hl-todo
  :ensure t)

(use-package magit-todos
  :ensure t
  :config
  (magit-todos-mode))

(use-package multiple-cursors
  :ensure t
  :config
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

(use-package dap-mode
  :ensure t
  :config
  (global-hl-todo-mode))

(require 'dap-lldb)
;;(require 'dap-gdb-lldb)
;;(require 'dap-cpptools)

(dap-register-debug-template
  "LLDB::Run My Run"
  (list :type "lldb-vscode"
        :request "launch"
        :name "LLDB::Run"
        :MIMode "lldb"
        :program "/home/cyberdemon/cyberDemonCode/C++/memory/my_bin"
        :cwd "/home/cyberdemon/cyberDemonCode/C++/memory/"))

;; (dap-register-debug-template
;;   "GDB::Run!"
;;   (list :type "gdb"
;;         :request "launch"
;;         :name "GDB::Run"
;;         :target "/home/cyberdemon/cyberDemonCode/C++/algorythms/binarySearch/bin"
;;         :cwd "/home/cyberdemon/cyberDemonCode/C++/algorythms/binarySearch/"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(c-default-style
   '((c-mode . "cc-mode")
	 (c++-mode . "cc-mode")
	 (java-mode . "java")
	 (awk-mode . "awk")
	 (other . "gnu")))
 '(compile-command
   "make -f MakefileLin clean && bear -- make -j20 -f MakefileLin")
 '(custom-enabled-themes '(screamtheme))
 '(custom-safe-themes
   '("7c93765917dc71f7a9a0f29bfc4bccbb51b031e8860de74b504494177ce44ad4" "49ed373a7ca624ecb51e3b6dc71b7844dfbb5139db104ffc09e5f389b313e8bf" "4d13b6f5ae531c0c2b1149049a38a8e01534a6c777f515a47cd6286469182606" "c71d123149c9fbfe3f94cdb68011a6309fb0b06884075f8cff64dc26cea3c7e2" "a13556751177a7fccf60ff93f6be0c1bf696c0d362763c332e4dedf35afbe292" "7a3394b280a110e830bed2ae8d058d12048e4b2a59c9b09d6a35e5a3857a8d08" "fce807530ccb5225239aa14a813445731362c0ead24e274f3d809149e5c826a5" "5640fa2bafae20d4590cbbf94aaa4b67d9e2f91f559192d1bad2b45f8deb7f08" "b9d4a60f9c1e029a23ed61f8839b810374e185fb4588d62b212c98660c730e39" "171d1ae90e46978eb9c342be6658d937a83aaa45997b1d7af7657546cae5985b" "78e6be576f4a526d212d5f9a8798e5706990216e9be10174e3f3b015b8662e27" "5a04c3d580e08f5fc8b3ead2ed66e2f0e5d93643542eec414f0836b971806ba9" "79586dc4eb374231af28bbc36ba0880ed8e270249b07f814b0e6555bdcb71fab" "f6cdb429a64db06d3db965871b45ed1c666fdce2d3e2c4b810868e4cf4244c92" "27079d43cd3cee72ff51b9298411ef72b966d4abdcacaf15150193548203030f" default))
 '(display-line-numbers nil)
 '(display-line-numbers-type t)
 '(global-display-line-numbers-mode t)
 '(inferior-lisp-program "sbcl" t)
 '(lsp-haskell-server-path "haskell-language-server-wrapper")
 '(magit-todos-insert-after '(bottom) nil nil "Changed by setter of obsolete option `magit-todos-insert-at'")
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(multiple-cursors magit-todos atom-one-dark-theme monokai-theme idea-darkula-theme darcula-theme foggy-night-theme glsl-mode dap-mode ac-slime slime haskell-mode lsp-haskell tree-sitter-langs tree-sitter rust-mode ace-jump-mode visual-regexp all-the-icons dashboard orderless vertico flycheck lsp-ui eglot company lsp-mode consult use-package))
 '(recentf-mode t)
 '(scroll-bar-mode nil)
 '(tab-bar-select-tab-modifiers nil)
 '(tab-width 4)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal :family "Jet Brains Mono Nerd Font")))))

