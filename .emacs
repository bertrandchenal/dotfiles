
(defun autocompile nil
  "compile itself if ~/.emacs"
  (interactive)
  (require 'bytecomp)
  (if (string= (buffer-file-name) (expand-file-name (concat
default-directory ".emacs")))
      (byte-compile-file (buffer-file-name))))
(add-hook 'after-save-hook 'autocompile)

(setq inhibit-startup-message t)
(setq require-final-newline nil)
(setq ispell-local-dictionary "english")

; include local path
(setenv "PATH" (concat (getenv "PATH") ":/home/bch/.local/bin"))
(setq exec-path (append exec-path '("/home/bch/.local/bin")))

;; forbid tabs
(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(setq-default tab-width 4)
(setq tab-stop-list (number-sequence 4 120 4))

;; leave ''' on his own line for python docstring
(setq python-fill-docstring-style 'symmetric)



;;  preserve line pos on page scroll:
(setq scroll-preserve-screen-position t)

;; auto-complete of code set to be case sensitive
(setq dabbrev-case-fold-search nil)

;; disable blinking cursor inside urxvt
(blink-cursor-mode 0)
;; disable blinking cursor inside urxvt
;;(setq visible-cursor nil)

;; whitespace
(add-hook 'python-mode-hook 'whitespace-mode)
(add-hook 'javascript-mode-hook 'whitespace-mode)
(setq whitespace-style (quote (face trailing lines space-before-tab space-after-tab ab-mark)))
(setq whitespace-line-column 88)

;; Nim
(add-hook 'nim-mode-hook 'nimsuggest-mode)


;; This makes the buffer scroll by only a single line when the up or
;; down cursor keys push the cursor (tool-bar-mode) outside the
;; buffer.
(setq scroll-step 1)

;;(setq truncate-partial-width-windows nil)

;; Put column number into modeline
(column-number-mode 1)

(setq mouse-yank-at-point t)
; shift fleche pour se deplacer
(global-set-key [S-left] 'windmove-left)          ; move to left windnow
(global-set-key [S-right] 'windmove-right)        ; move to right window
(global-set-key [S-up] 'windmove-up)              ; move to upper window
(global-set-key [<select>] 'windmove-up)          ; move to upper window
(global-set-key [S-down] 'windmove-down)          ; move to downer window

(global-set-key (kbd "C--")  'undo)

;;http://lists.gnu.org/archive/html/help-gnu-emacs/2011-05/msg00174.html
(define-key global-map (kbd "<select>") 'windmove-up)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(electric-indent-mode -1)

(setq read-file-name-completion-ignore-case t)


(global-set-key "\C-x\C-b" 'electric-buffer-list)
(global-set-key "\C-cd" 'ispell-change-dictionary)
(global-set-key "\C-cg" 'gofmt)

(defun pdb ()
  (interactive)
  (insert "import pdb;pdb.set_trace()"))
(global-set-key "\C-cp" 'pdb)

;; on regroupe les fichiers bu ds un meme endroit :
(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/"))))

;; opposite of fill-paragraph    
(defun unfill-paragraph ()
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))
(define-key global-map "\M-Q" 'unfill-paragraph)


;integration du copy-paste
(defun copy-from-x ()
  (interactive)
  (shell-command-on-region (region-beginning) (region-end) "xsel -i -b"))

(defun paste-to-x ()
  (interactive)
    (insert (shell-command-to-string "xsel -o -b"))
)
(define-key global-map "\C-cv" 'paste-to-x)
(define-key global-map "\C-cc" 'copy-from-x)


(fset 'yes-or-no-p 'y-or-n-p)


(defun delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun backward-delete-word (arg)
  "Delete characters backward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (delete-word (- arg)))

(global-set-key (read-kbd-macro "<M-DEL>") 'backward-delete-word)
(global-set-key [(meta d)] 'delete-word)


(global-set-key "\M-i" 'indent-rigidly)

;; (defun unindent ()
;;   (interactive)
;;   (save-excursion
;;     (back-to-indentation)
;;     (if (>= (current-column) 4)
;;         (backward-delete-char
;;          (if (= (% (current-column) 4) 0)
;;              4 (% (current-column) 4))
;;          )
;;       )
;;     )
;;   )
;; (global-set-key "\M-I" 'unindent)
;; (defun indent-to-stop ()
;;   (interactive)
;;   (save-excursion
;;     (back-to-indentation)
;;     ;; (tab-to-tab-stop)
;;     (if (= (% (current-column) 4) 0)
;;         (string-insert-rectangle (point) (point) "    ")
;;       (string-insert-rectangle (point) (point) (make-string (- 4(% (current-column) 4)) ? ))
;;       )
;;     )
;;   )
;; (global-set-key "\M-i" 'indent-to-stop)

(defun insert-date ()
   (interactive)
   (insert (format-time-string "%Y-%m-%d")))
(global-set-key "\C-cT" `insert-date)
(defun insert-time ()
   (interactive)
   (insert (format-time-string "%H:%M ")))
(global-set-key "\C-ct" `insert-time)


;; add melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


;; checking
(require 'flycheck-pyflakes)
(add-hook 'python-mode-hook 'flycheck-mode)

;; custom themes
;; (load-theme 'dark-laptop)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   '("cdc2a7ba4ecf0910f13ba207cce7080b58d9ed2234032113b8846a4e44597e41" "b4fd44f653c69fb95d3f34f071b223ae705bb691fb9abaf2ffca3351e92aa374" "400994f0731b2109b519af2f2d1f022e7ced630a78890543526b9342a3b04cf1" "1f38fb71e55e5ec5f14a39d03ca7d7a416123d3f0847745c7bade053ca58f043" "f66abed5139c808607639e5a5a3b5b50b9db91febeae06f11484a15a92bde442" "dd4628d6c2d1f84ad7908c859797b24cc6239dfe7d71b3363ccdd2b88963f336" "7edd4f9a4f52c1511e6f249892d49c3e6d296ac11b36170e19f050c4767dd243" "258990b523e649ff9a0f27cb70ea8415d13b93f6e75a6178f77b947767b67160" "8150ded55351553f9d143c58338ebbc582611adc8a51946ca467bd6fa35a1075" "1dacaddeba04ac1d1a2c6c8100952283b63c4b5279f3d58fb76a4f5dd8936a2c" default))
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(crystal-mode nim-mode janet-mode zig-mode rust-mode color-theme-modern base16-theme minsk-theme modus-vivendi-theme downplay-mode jinja2-mode blacken grayscale-theme goose-theme rainbow-delimiters slack cython-mode typescript-mode flymake-go flycheck-pyflakes markdown-mode lua-mode go-mode yaml-mode tangotango-theme sublime-themes magit greymatters-theme green-phosphor-theme grandshell-theme firebelly-theme color-theme-sanityinc-solarized caroline-theme busybee-theme badger-theme arjen-grey-theme apropospriate-theme ample-theme janet-mode))
 '(tool-bar-mode nil)
 '(whitespace-line-column 110))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(downplay-face ((t (:foreground "light gray"))))
 '(flycheck-error ((t (:underline "gray30"))))
 '(flycheck-fringe-error ((t (:foreground "white"))))
 '(whitespace-line ((t (:foreground "violet")))))
