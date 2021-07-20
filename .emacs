(require 'package)
(add-to-list 'package-archives '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/"))
(package-initialize)
;; ensure use-package is installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package-ensure)
(setq use-package-always-ensure t)


;; GENERAL ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun i3-push-todo ()
  (interactive)
  (kill-line)
  (shell-command (concat "echo '" "<span font-weight=\"bold\" color=\"#FFC0CB\">TODO</span> " (current-kill 0) "' > ~/.config/i3blocks/blocklets/todo.txt"))
  (yank)
  (shell-command "pkill -RTMIN+12 i3blocks"))


(defun i3-clear-todo ()
  (interactive)
  (shell-command "echo \"\" > ~/.config/i3blocks/blocklets/todo.txt")
  (shell-command "pkill -RTMIN+12 i3blocks"))


;; UI TWEAKS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'doom-modeline)
;; (setq doom-modeline-height 15)
;; (doom-modeline-mode 1)

;; (defun transparency (value)
;;    "Sets the transparency of the frame window. 0=transparent/100=opaque"
;;    (interactive "nTransparency Value 0 - 100 opaque:")
;;    (set-frame-parameter (selected-frame) 'alpha value))

;; (transparency 88)

;; activate neotree

(use-package magit)

(use-package zencoding-mode
  :hook sgml-mode)

(use-package yaml-mode)

(use-package neotree
  :config
  (add-to-list 'load-path "~/.config/neotree")
  (global-set-key (kbd "M-p") 'neotree-toggle))



(use-package all-the-icons
  :config (add-to-list 'all-the-icons-icon-alist
	       '("\\.tsx$"
		 all-the-icons-alltheicon "react"
		 :height 1.0
		 :face all-the-icons-blue)))


(setq neo-window-fixed-size nil
      neo-theme (if (display-graphic-p) 'icons 'arrow))

(use-package diredfl
  :ensure t
  :hook
  (dired-mode . diredfl-mode)
  :config (setq dired-listing-switches "-alh"))


(use-package all-the-icons-dired
  :ensure t
  :hook
  (dired-mode . all-the-icons-dired-mode))

(use-package rainbow-mode
  :ensure t
  :hook '(prog-mode help-mode))


;; scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))
      mouse-wheel-scroll-amount '(1 0.1)
      mouse-wheel-progressive-speed nil
      mouse-wheel-follow-mouse 't
      scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1) 

;; set global fontsize
(set-face-attribute 'default nil :height 108)

(set-frame-font "iosevka-10")
;; (set-frame-font "firacode-10")
;; (set-frame-font "officecodepro-10")
(recentf-mode 1)

(setq recentf-max-saved-items 100
      inhibit-startup-message t
      ring-bell-function 'ignore
      initial-major-mode 'org-mode
      initial-scratch-message "";; no splash screen
      inhibit-splash-screen t
      echo-keystrokes 0.1;;echo every keystroke      
      doc-view-resolution 200
      make-backup-files nil
      ispell-local-dictionary "de_DE"
      cperl-invalid-face 'default
      lsp-rust-server 'rust-analyzer
)

(setq-default
 frame-title-format "emacs:%f"
 x-stretch-cursor t;; make cursor tabsized when on a tab
 )


;; revert when files are changed outside of emacs
(global-auto-revert-mode 1)

;; switch buffers using shift and arrow keys
(windmove-default-keybindings)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
;; (show-trailing-whitespace t)
(set-default 'cursor-type 'box)
(column-number-mode)
(ido-mode)
(show-paren-mode)

(use-package rainbow-delimiters
  :config (rainbow-delimiters-mode)
  :hook clojure-mode)

(global-hl-line-mode -1)

(use-package winner
  :config (winner-mode t))

(use-package nlinum
  :config (nlinum-mode t))

(use-package electric-operator
  :config (electric-pair-mode 1))

;(ac-config-default)

(fset 'yes-or-no-p 'y-or-n-p)

(use-package doom-themes
  :config
  (load-theme 'doom-tomorrow-night)
  )

(use-package solidity-mode)

(use-package dockerfile-mode)
(use-package docker-compose-mode)


;; ORG-MODE -------------------------------------------------------------------
(setq org-columns-default-format "%50ITEM(Task) %10CLOCKSUM %16TIMESTAMP_IA")

(use-package org-bullets
  :ensure t
  :custom
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))



(setq org-latex-to-pdf-process
      '("pdflatex %f" "biber %b" "pdflatex %f" "pdflatex %f"))

(setq org-agenda-files
      '("~/privat/agenda"
	;; "~/git/org/client1"
	;"~/git/client2"
	))


;; DIRED SHORTCUTS ------------------------------------------------------------
(defun bewerbung ()
  (interactive)
  (dired "/home/marius/privat/Dokumente/templates/Bewerbung"))

(defun brs ()
  (interactive)
  (dired "/home/marius/privat/studium/master_info/SS21"))

(defun ml ()
  (interactive)
  (dired "~/privat/machine_learning"))

(defun ctf ()
  (interactive)
  (dired "~/ctf"))

(defun clj ()
  (interactive)
  (dired "~/privat/clojure"))

(defun web ()
  (interactive)
  (dired "~/privat/web"))

(defun dl ()
  (interactive)
  (dired "~/Downloads"))


;; C-q C-u is the key bindings similar to Vz Editor.
;; (add-to-list 'load-path "~/.emacs.d/evil")
;; (require 'evil)
;; (evil-mode 1)


(global-unset-key (kbd "C-q"))

(add-to-list 'auto-mode-alist '("\\.xtx\\'" . latex-mode))

;(setq powerline-default-separator 'arrow-fade)
(require 'iso-transl)
(use-package helm
  :ensure t
  :config
  (global-set-key (kbd "M-x") 'helm-M-x))

(global-set-key (kbd "<dead-circumflex>") "^")
(global-set-key (kbd "<dead-acute>") "`")
(global-set-key (kbd "ł") "λ")

(put 'downcase-region 'disabled nil)

;; GENERAL PROGRAMMING SETTINGS -------------------------------------------------

(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  (lsp-rust-analyzer-server-display-inlay-hints t)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :ensure
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable nil))



(use-package flycheck
  :ensure t
  ;:init (global-flycheck-mode)
  ;;:hook (lsp-mode . flycheck-mode)
  )


(use-package yasnippet
  :ensure
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (add-hook 'text-mode-hook 'yas-minor-mode))

(use-package company
  :ensure
  ;; :custom
  ;; (company-idle-delay 0.5) ;; how long to wait until popup
  ;; (company-begin-commands nil) ;; uncomment to disable popup
  :hook (alchemist-mode)
  :bind
  (:map company-active-map
	("C-n". company-select-next)
	("C-p". company-select-previous)
	("M-<". company-select-first)
	("M->". company-select-last))
  (:map company-mode-map
        ("<tab>". tab-indent-or-complete)
        ("TAB". tab-indent-or-complete)))

(defun company-yasnippet-or-completion ()
  (interactive)
  (or (do-yas-expand)
      (company-complete-common)))

(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
        (backward-char 1)
        (if (looking-at "::") t nil)))))

(defun do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)))

(defun tab-indent-or-complete ()
  (interactive)
  (if (minibufferp)
      (minibuffer-complete)
    (if (or (not yas/minor-mode)
            (null (do-yas-expand)))
        (if (check-expansion)
            (company-complete-common)
          (indent-for-tab-command)))))


;; (use-package company-box
;;   :ensure t
;;   :hook (company-mode . company-box-mode)
;;   :config
;;   (setq company-box-show-single-candidate t)
;;   ;; (setq x-gtk-resize-child-frames 'hide)  ;; This solves the variable scrollbar width. This is probably related to Wayland

;;   (add-to-list
;;    'company-box-frame-parameters
;;    '(font . "Iosevka Aile-18")
;;    )
;;   )

;; Syntax checker

;; PYTHON ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (elpy-enable)
(use-package ein)
;; JAVASCRIPT ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (add-hook 'js2-mode-hook #'js2-imenu-extras-mode)
;; (setq js2-strict-missing-semi-warning nil)

(use-package js2-refactor
  :ensure t
  :hook js2-mode
  :config
  (js2r-add-keybindings-with-prefix "C-c C-m")
  (define-key js2-mode-map (kbd "C-k") #'js2r-kill)
  )




(use-package xref-js2
  :ensure t)
 
;;(use-package )
;; Typescript ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package tide
  :config
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
  ;; formats the buffer before saving
  (add-hook 'before-save-hook 'tide-format-before-save)
  (add-hook 'typescript-mode-hook #'setup-tide-mode))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  ;; (company-mode +1)
  )

;; aligns annotation to the right hand side
;; (setq company-tooltip-align-annotations t)


;; ELIXIR ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package alchemist
  :hook elixir-mode)

(use-package elixir-mode)


;; C/C++ ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package irony
  :hook (c++-mode c-mode objc-mode))

;; COMMON LISP ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq inferior-lisp-program "/usr/bin/clisp")
(setq slime-contribs '(slime-fancy))

;; CLOJURE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package clojure-mode)

(use-package paredit
  :hook (clojure-mode common-lisp-mode))

(use-package cider
  :ensure t
  :bind-keymap ("C-c 3" . spit-scad)
  :config
  (setq org-babel-clojure-backend 'cider)
  (setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))"))


(defun spit-scad ()
  (interactive)
  (cider-interactive-eval
   (format
    "(require 'scad-clj.scad)
    (spit \"repl.scad\"
	  (scad-clj.scad/write-scad %s))"
    (cider-last-sexp))))

;; (define-key cider-mode-map
;;   (kbd "C-c 3") 'spit-scad)

;; RUST ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package toml-mode :ensure)
;; Add keybindings for interacting with Cargo
;(use-package cargo
;  :hook (rust-mode . cargo-minor-mode))


(use-package rustic
  :ensure
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  ;; uncomment for less flashiness
  ;; (setq lsp-eldoc-hook nil)
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;; (setq lsp-signature-auto-activate nil)

  ;; comment to disable rustfmt on save
  (setq rustic-format-on-save t)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(defun rk/rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm
  (setq-local buffer-save-without-query t))



;; (use-package flycheck-rust
;;   :config (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))


;; OCTAVE  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (autoload 'octave-mode "octave-mode" nil t)
;; (setq auto-mode-alist
;;       (cons '("\\.m$" . octave-mode) auto-mode-alist))

;; (require 'ac-octave)

;; (defun ac-octave-mode-setup ()
;;   (setq ac-sources '(ac-complete-octave)))

;; (add-hook 'octave-mode-hook
;;           '(lambda () (ac-octave-mode-setup)))







(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#21272e" "#e74c3c" "#53df83" "#ECBE7B" "#56b5c2" "#FFB8D1" "#56b6c2" "#f8f8f0"])
 '(custom-safe-themes
   '("95d0ed21bb0e919be7687a25ad59a1c2c8df78cbe98c9e369d44e65bfd65b167" "7b3d184d2955990e4df1162aeff6bfb4e1c3e822368f0359e15e2974235d9fa8" "54cf3f8314ce89c4d7e20ae52f7ff0739efb458f4326a2ca075bf34bc0b4f499" "8f5a7a9a3c510ef9cbb88e600c0b4c53cdcdb502cfe3eb50040b7e13c6f4e78e" "f4876796ef5ee9c82b125a096a590c9891cec31320569fc6ff602ff99ed73dca" "b5fff23b86b3fd2dd2cc86aa3b27ee91513adaefeaa75adc8af35a45ffb6c499" "5b809c3eae60da2af8a8cfba4e9e04b4d608cb49584cb5998f6e4a1c87c057c4" "0fe24de6d37ea5a7724c56f0bb01efcbb3fe999a6e461ec1392f3c3b105cc5ac" "d74c5485d42ca4b7f3092e50db687600d0e16006d8fa335c69cf4f379dbd0eee" "f94110b35f558e4c015b2c680f150bf8a19799d775f8352c957d9d1054b0a210" "5379937b99998e0510bd37ae072c7f57e26da7a11e9fb7bced8b94ccc766c804" "76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" "f2927d7d87e8207fa9a0a003c0f222d45c948845de162c885bf6ad2a255babfd" "75b8719c741c6d7afa290e0bb394d809f0cc62045b93e1d66cd646907f8e6d43" "e3c64e88fec56f86b49dcdc5a831e96782baf14b09397d4057156b17062a8848" "c4bdbbd52c8e07112d1bfd00fee22bf0f25e727e95623ecb20c4fa098b74c1bd" "0a41da554c41c9169bdaba5745468608706c9046231bbbc0d155af1a12f32271" "4bca89c1004e24981c840d3a32755bf859a6910c65b829d9441814000cf6c3d0" "fd22c8c803f2dac71db953b93df6560b6b058cb931ac12f688def67f08c10640" "e27556a94bd02099248b888555a6458d897e8a7919fd64278d1f1e8784448941" "3df5335c36b40e417fec0392532c1b82b79114a05d5ade62cfe3de63a59bc5c6" "ca70827910547eb99368db50ac94556bbd194b7e8311cfbdbdcad8da65e803be" "990e24b406787568c592db2b853aa65ecc2dcd08146c0d22293259d400174e37" "e1ef2d5b8091f4953fe17b4ca3dd143d476c106e221d92ded38614266cea3c8b" "6b80b5b0762a814c62ce858e9d72745a05dd5fc66f821a1c5023b4f2a76bc910" "6c3b5f4391572c4176908bb30eddc1718344b8eaff50e162e36f271f6de015ca" "0e2a7e1e632dd38a8e0227d2227cb8849f877dd878afb8219cb6bcdd02068a52" "7d708f0168f54b90fc91692811263c995bebb9f68b8b7525d0e2200da9bc903c" "c83c095dd01cde64b631fb0fe5980587deec3834dc55144a6e78ff91ebc80b19" "4f01c1df1d203787560a67c1b295423174fd49934deb5e6789abd1e61dba9552" "a3bdcbd7c991abd07e48ad32f71e6219d55694056c0c15b4144f370175273d16" "c086fe46209696a2d01752c0216ed72fd6faeabaaaa40db9fc1518abebaf700d" "be9645aaa8c11f76a10bcf36aaf83f54f4587ced1b9b679b55639c87404e2499" "d5a878172795c45441efcd84b20a14f553e7e96366a163f742b95d65a3f55d71" "2c49d6ac8c0bf19648c9d2eabec9b246d46cb94d83713eaae4f26b49a8183fc4" "cae81b048b8bccb7308cdcb4a91e085b3c959401e74a0f125e7c5b173b916bf9" "01cf34eca93938925143f402c2e6141f03abb341f27d1c2dba3d50af9357ce70" "0685ffa6c9f1324721659a9cd5a8931f4bb64efae9ce43a3dba3801e9412b4d8" "ff3c57a5049010a76de8949ddb629d29e2ced42b06098e046def291989a4104a" "56d10d2b60685d112dd54f4ba68a173c102eacc2a6048d417998249085383da1" default))
 '(fci-rule-color "#2c313a")
 '(jdee-db-active-breakpoint-face-colors (cons "#10151a" "#e74c3c"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#10151a" "#53df83"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#10151a" "#737c8c"))
 '(objed-cursor-color "#e74c3c")
 '(package-selected-packages
   '(docker-compose-mode dockerfile-mode ein solidity-mode yaml-mode zencoding-mode magit olivetti diredfl rustic toml-mode cider ob-clojure paredit clojure irony alchemist tide xref-js2 js2-refactor company yasnippet flycheck lsp-ui lsp-mode helm org-bullets doom-themes electric-operator nlinum rainbow-delimiters all-the-icons neotree use-package))
 '(pdf-view-midnight-colors (cons "#f8f8f0" "#21272e"))
 '(rustic-ansi-faces
   ["#21272e" "#e74c3c" "#53df83" "#ECBE7B" "#56b5c2" "#FFB8D1" "#56b6c2" "#f8f8f0"])
 '(vc-annotate-background "#21272e")
 '(vc-annotate-color-map
   (list
    (cons 20 "#53df83")
    (cons 40 "#86d480")
    (cons 60 "#b9c97d")
    (cons 80 "#ECBE7B")
    (cons 100 "#ea9866")
    (cons 120 "#e87251")
    (cons 140 "#e74c3c")
    (cons 160 "#ef706d")
    (cons 180 "#f7939f")
    (cons 200 "#FFB8D1")
    (cons 220 "#f7949f")
    (cons 240 "#ef706d")
    (cons 260 "#e74c3c")
    (cons 280 "#ca5850")
    (cons 300 "#ad6464")
    (cons 320 "#907078")
    (cons 340 "#2c313a")
    (cons 360 "#2c313a")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
