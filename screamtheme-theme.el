;;; screamtheme.el --- A dark theme by Screamlark

;; Title: Screamtheme
;; Version: 2.2.1
;; Author: https://github.com/Maybe707

(deftheme screamtheme "A dark theme by Screamlark")

(custom-theme-set-faces
 'screamtheme
 '(default ((t (:background "#000000" :foreground "#7f6a86"))))
 '(button ((t (:inherit link :weight normal))))
 '(company-tooltip ((t (:background "black" :foreground "#555555"))))
 '(company-tooltip-annotation ((t (:foreground "#ff5555"))))
 '(company-tooltip-common ((t (:foreground "#aa0000"))))
 '(company-tooltip-scrollbar-thumb ((t (:background "#ff5555"))))
 '(company-tooltip-scrollbar-track ((t (:background "#aaaaaa"))))
 '(company-tooltip-selection ((t (:background "#aaaaaa"))))
 '(error ((t (:foreground "#fadb2f" :weight bold))))
 '(font-lock-builtin-face ((t (:foreground "#8e6fbd"))))
 '(font-lock-comment-face ((t (:foreground "gray25"))))
 '(font-lock-constant-face ((t (:foreground "#7c4a8b" :weight bold))))
 '(font-lock-function-name-face ((t (:foreground "#bf9f67"))))
 '(font-lock-keyword-face ((t (:foreground "#aa00aa" :weight bold))))
 '(font-lock-preprocessor-face ((t (:inherit font-lock-builtin-face))))
 '(font-lock-string-face ((t (:foreground "#98971a" :weight bold))))
 '(font-lock-type-face ((t (:foreground "#aa5500"))))
 '(font-lock-variable-name-face ((t (:foreground "#af545d"))))
 '(highlight ((t (:background "gray30"))))
 '(link ((t (:foreground "#478061" :underline nil))))
 '(link-visited ((t (:inherit link :foreground "violet"))))
 '(lsp-face-highlight-textual ((t (:inherit highlight :weight bold))))
 '(lsp-face-semhl-constant ((t (:inherit font-lock-constant-face))))
 '(lsp-face-semhl-number ((t (:inherit font-lock-constant-face))))
 '(lsp-ui-doc-background ((t (:background "gray15"))))
 '(menu ((t (:inverse-video t))))
 '(mode-line ((t (:background "grey20" :foreground "black" :box (:line-width -1 :style released-button)))))
 '(mode-line-inactive ((t (:inherit mode-line :background "black" :foreground "grey20" :box (:line-width -1 :color "grey85") :weight light))))
 '(neo-dir-link-face ((t (:foreground "#5555ff"))))
 '(org-document-info ((t (:foreground "#aa00aa"))))
 '(org-document-title ((t (:foreground "#ff55ff" :weight bold))))
 '(popup-face ((t (:inherit default :background "lightgrey" :foreground "black"))))
 '(region ((t (:extend t :background "#555555"))))
 '(secondary-selection ((t (:extend t :background "#ffff55"))))
 '(tab-bar ((t (:inherit variable-pitch :background "black" :foreground "dark gray"))))
 '(tab-bar-tab ((t (:inherit tab-bar :background "gray25" :underline "magenta"))))
 '(tab-bar-tab-inactive ((t (:inherit tab-bar-tab :background "black"))))
 '(tab-line ((t (:inherit variable-pitch :background "grey85" :foreground "black" :height 0.9))))
 '(tool-bar ((t (:foreground "black" :box (:line-width (1 . 1) :style released-button))))))

(provide-theme 'screamtheme)
