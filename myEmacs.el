(setq-default indent-tabs-mode nil)

;; some nice key bindings I find useful.
(global-set-key "\M-m" 'mark-whole-buffer)
(global-set-key "\M-b" 'rename-buffer)

;; IDO mode
(require 'ido)
    (ido-mode t)
`(ido-mode (quote both) nil (ido))

(defun my-show-tabs ()
  (interactive)
  (let ((i 0) (disptab make-display-table)))
    (while (&lt; i 32)
      (or (= i ?\n)
          (aset disptab i (vector ?^ (+ i 64))))
      (setq i (1+ i)))
    (aset disptab 127 (vector ?^ ??))
    (setq buffer-display-table disptab)))
 
(defun my-hide-tabs ()
  (interactive)
  (let ((i 0) (disptab make-display-table)))
    (while (&lt; i 32)
      (or (= i ?\n) (= i ?\t)
          (aset disptab i (vector ?^ (+ i 64))))
      (setq i (1+ i)))
    (aset disptab 127 (vector ?^ ??))
    (setq buffer-display-table disptab)))

(setq c-basic-indent 2)
(setq tab-width 4)
(setq indent-tabs-mode nil)

(setq c-default-style "linux"
      c-basic-offset 4)

;; load initialize for cua-mode and etc. after site-start in linux
;;(if (not (equal (getenv "HOSTTYPE") "sparc"))
(cua-mode t)

;; =================================================================
;; Load
;; =================================================================
(load "~/emacs-portable/xcscope.el" nil t t)
(add-hook 'c-mode-common-hook
	  '(lambda ()
	    (require 'xcscope)))

(load "~/emacs-portable/linum.el" nil t t)
(require 'linum)
(global-linum-mode t)

;; font related
;;(set-default-font "DejaVu Sans Mono-14")
;;(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-14"))



;; =================================================================
;; Saving Emacs Sessions - Useful when you have a bunch of source
;; files open and you don't want to go and manually open each
;; one, especially when they are in various directories. Page 377
;; of the GNU Emacs Manual says: "The first time you save the state
;; of the Emacs session, you must do it manually, with the command
;; M-x desktop-save. Once you have dome that, exiting Emacs will
;; save the state again -- not only the present Emacs session, but
;; also subsequent sessions. You can also save the state at any
;; time, without exiting Emacs, by typing M-x desktop-save again.
;; =================================================================


;; This maps edit keys to standard Windows keystokes. It requires the
;;(cua-mode t)


;; This maparacters in shell-mode
(add-hook 'shell-mode-hook 
          'ansi-color-for-comint-mode-on) 


;;set the default file path
(setq default-directory "~/")
(add-to-list 'load-path "~/")


;; Haskell Mode
(load "~/emacs-portable/haskell/haskell-site-file")

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
   ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
   (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
   ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
   
;;(setq haskell-program-name "C:\Program Files\Haskell Platform\2011.4.0.0\bin")
;;==============================================================================

;; make verilog file .v
;;(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
;;(setq auto-mode-alist (cons  '("\\.v\\'" . verilog-mode) auto-mode-alist))

;; make .l_bashrc shell-script file
(setq auto-mode-alist (cons '("\\.l_bashrc" . shell-script-mode) auto-mode-alist))
;; make .pt or *.synopsys_pt.setup a .tcl file
;(setq auto-mode-alist (cons '("\\.pt\\'" . tcl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".*\\.pt$" . tcl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".*\\.synopsys_..\\.setup$" . tcl-mode) auto-mode-alist))
;; make *.synopsys_dc.setup a .scr file

;; make vflist vfl files a .c file
;(setq auto-mode-alist (cons '("vfl\\(ist\\|_*\\)" . c-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("vfl_.+" . c-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("vflist$" . c-mode) auto-mode-alist))

(desktop-read)

;; Info
(load "info")

;; A nice buffer handling
(load "msb")

;; =================================================================
;; Behavior of emacs
;; =================================================================
;; command history length
(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(case-fold-search t)
 '(comint-completion-autolist nil)
 '(comint-completion-fignore (quote ("~" "#" "%" ".o")))
 '(comint-input-ignoredups (quote t))
 '(comint-input-ring-size 500 t)
 '(current-language-environment "UTF-8")
 '(default-input-method "rfc1345")
 '(global-font-lock-mode t nil (font-lock))
 '(history-length 500 t)
 '(next-line-add-newlines nil)
 '(scroll-bar-mode (quote right))
 '(shell-completion-fignore (quote ("~" "#" "%" ".o")))
 '(transient-mark-mode t))
;; '(line-number-display-limit 400000000))

;; shell/comint Completion


;(partial-completion-mode)

;; No new line due to cursor move

(put 'narrow-to-region 'disabled nil)
(auto-compression-mode)

;; No too many #*, *~ files
(setq make-backup-files nil)

;; Make the % key jump to the matching {}[]() if on another, like VI
(global-set-key "%" 'match-paren)      
  
(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

;; Suppress echoing when a subprocess asks for a password
(defcustom comint-password-prompt-regexp
  "\\(\\([Oo]ld \\|[Nn]ew \\|Kerberos \\|'s \\|login \\|^CVS \\|^\\)\
[Pp]assword\\( (again)\\)?\\|pass phrase\\|Enter passphrase\\)\
\\( for [^@ \t\n]+@[^@ \t\n]+\\)?:\\s *\\'"
  "*Regexp matching prompts for passwords in the inferior process.
This is used by `comint-watch-for-password-prompt'."
  :type 'regexp
  :group 'comint)

(add-hook 'comint-output-filter-functions
  'comint-watch-for-password-prompt)

;; Let the emacsclient can be runed
;(setenv "IN_EMACS" "in_emacs")
;(load "resume")
;(add-hook 'suspend-hook 'resume-suspend-hook)
;(add-hook 'suspend-resume-hook 'resume-process-args)
;(server-start)

;; =================================================================
;; Out Look of emacs
;; =================================================================

;; Show clock in status bar
;; Comment out first line if you prefer to show time in 12 hour format
(setq display-time-24hr-format t)
(setq display-time-day-and-date nil)
(display-time)

;; Display the current column number on mode line
(column-number-mode t)

;; Set sub-mouse-menu min number
(setq mouse-buffer-menu-mode-mult 2)

;; Don't display menu bar. Type M-x menu-bar-mode to display it
(menu-bar-mode '-1)
;; Don't display tool bar. Type M-x tool-bar-mode to display it
(if (not (equal (getenv "HOSTTYPE") "sparc"))
    (tool-bar-mode '-1))

;; Scroll bar place
(custom-set-variables '(scroll-bar-mode (quote left)))

;; Make temp buffer size min
(temp-buffer-resize-mode '1)

;; =================================================================
;; Color setting.
;; Color is also inferenced by .Xdefault and emacs command option
;; =================================================================

;; Set global font lock mode
;;(global-font-lock-mode '1)
;(global-font-lock-mode t)

;; Set foreground and background. black or dimgrey may be choosed
(set-foreground-color "white")
(set-background-color "Gray22")
;(set-background-color "CornflowerBlue")
;(set-background-color "DarkSlateBlue")
;(set-background-color "MidnightBlue")
;(set-background-color "Black")

;; Set the mouse and cursor color
(set-mouse-color "yellow")
(set-cursor-color "red")

;; Set manual face color
(set-face-foreground 'info-xref "cyan")
(set-face-foreground 'info-node "red")

(setq Man-overstrike-face 'info-node)
(setq Man-underline-face 'info-xref)
;(setq Info-directory-list '("/icdev/users/jzhang/Software/tmp/info/"))

;; Set some font face
;(set-face-foreground 'font-lock-comment-face "red")
;(set-face-foreground 'font-lock-comment-face "Coral")
(set-face-foreground 'font-lock-comment-face "OrangeRed")
;(set-face-foreground 'font-lock-string-face "CadetBlue1")
;(set-face-foreground 'font-lock-variable-name-face "yellow")
;(set-face-foreground 'font-lock-function-name-face "CadetBlue1")

;; =================================================================
;; Key Binding
;; =================================================================

;; Book mark 1
(global-set-key [f1] 'bookmark-jump-default1)
(defun bookmark-jump-default1 (pos)
  "Set a default bookmark 1 default-bookmark1 at current position"
  (interactive "d")
  (bookmark-jump "default-bookmark1")
  (bookmark-set "default-bookmark1"))

(global-set-key [C-f1] 'bookmark-set-default1)
(defun bookmark-set-default1 (pos)
  "Jump to the default bookmark 1 default-bookmark1"
  (interactive "d")
  (bookmark-set "default-bookmark1"))

;; Book mark 2
(global-set-key [f2] 'bookmark-jump-default2)
(defun bookmark-jump-default2 (pos)
  "Set a default bookmark 2 default-bookmark2 at current position"
  (interactive "d")
  (bookmark-jump "default-bookmark2")
  (bookmark-set "default-bookmark2"))

(global-set-key [C-f2] 'bookmark-set-default2)
(defun bookmark-set-default2 (pos)
  "Jump to the default bookmark 2 default-bookmark2"
  (interactive "d")
  (bookmark-set "default-bookmark2"))

(global-set-key [S-f2] 'bookmark-jump)
(global-set-key [S-C-f2] 'bookmark-set)

;; Set the word search keys
(define-key global-map [f3] 'isearch-forward)
(define-key isearch-mode-map [f3] 'isearch-repeat-forward)
(define-key global-map [C-f3] 'isearch-forward-regexp)
(define-key global-map [S-f3] 'isearch-backward)
(define-key isearch-mode-map [S-f3] 'isearch-repeat-backward)
(define-key global-map [C-S-f3] 'isearch-backward-regexp)

;; Kill buffer/emacs
(global-set-key [C-f4] 'kill-this-buffer)
(global-set-key [M-f4] 'save-buffers-kill-emacs)

;; Alternative copy/paste
(global-set-key [f4] 'copy-to-register-t)
(defun copy-to-register-t (start end)
  "Copy the selected region into a default register, t"
  (interactive "r")
  (copy-to-register t start end)
  (if transient-mark-mode (setq deactivate-mark t)))

(global-set-key [S-f4] 'insert-register-t)
(defun insert-register-t (pos)
  "Insert the contents of default register, t, into current position"
  (interactive "d")
  (insert-register t 1))

;; Go to line
(global-set-key [f5] 'goto-line)

;; Switch windows/buffers
(global-set-key [f6] 'other-window)
(global-set-key [C-f6] 'switch-to-buffer)
(global-set-key [S-f6] 'buffer-menu)

;; Search previour/next issued commend
(global-set-key [S-f7] 'comint-next-matching-input-from-input)
(global-set-key [f7] 'comint-previous-matching-input-from-input)

;; Replace
(global-set-key [f9] 'query-replace)
(global-set-key [C-f9] 'query-replace-regexp)
(global-set-key [S-f9] 'query-replace-reg-t)

(defun query-replace-reg-t (to-string)
  (interactive (let (to)
		 (setq to (read-from-minibuffer
			   (format "Query-replace \"%s\" with: "
				   (get-register t))
			   nil nil nil
			   query-replace-to-history-variable nil t))
		 (list to)))
  (perform-replace (get-register t) to-string t nil nil))

(global-set-key [f10] 'replace-string)
(global-set-key [C-f10] 'replace-string-regexp)
(global-set-key [S-f10] 'replace-string-reg-t)

(defun replace-string-reg-t (to-string)
  (interactive (let (to)
		 (setq to (read-from-minibuffer
			   (format "Replace \"%s\" with: "
				   (get-register t))
			   nil nil nil
			   query-replace-to-history-variable nil t))
		 (list to)))
  (perform-replace (get-register t) to-string nil nil nil))

;; Split/combine windows
(global-set-key [f11] 'delete-other-windows)
(global-set-key [S-f11] 'delete-window)
(global-set-key [f12] 'split-window-vertically)
(global-set-key [S-f12] 'split-window-horizontally)

;; Mouse operation
(global-set-key [mouse-3] 'mouse-buffer-menu)

;; Common MSWIN like keys
(global-set-key "\C-o" 'find-file)
(global-set-key "\C-s" 'save-buffer)
(global-set-key "\C-p" 'pwd)
(global-set-key [C-backspace] 'backward-kill-word)
(global-set-key [C-delete] 'kill-word)
(global-set-key [delete] 'delete-char)
(global-set-key "\C-d" 'kill-whole-line)
(defun kill-whole-line ()
  "Kill the whole line the cursor located"
  (interactive)
  (beginning-of-line nil)
  (kill-line nil)
  (kill-line nil))

;; verilog module assistant command and supported functions
;(global-set-key "\M-i" 'convert-list-to-instance)
;(global-set-key "\M-l" 'convert-declaration-to-list)
;(global-set-key "\M-d" 'convert-list-to-declaration)

(defun convert-list-to-instance (start end)
  "Convert port list selected to module instance"
  (interactive "r")
  (shell-command-on-region start end "/icdev/local/bin/pl_mi"))

(defun convert-declaration-to-list (start end)
  "Convert port declaration selected to port list"
  (interactive "r")
  (shell-command-on-region start end "/icdev/local/bin/pd_pl"))

(defun convert-list-to-declaration (start end)
  "Convert port list selected to port declaration"
  (interactive "r")
  (shell-command-on-region start end "/icdev/local/bin/pl_pd"))

;; =================================================================
;; Shell
;; =================================================================

;(shell)
;(rename-buffer "shell-2")
(shell)
(rename-buffer "shell-1")


;; =================================================================
;; load user local emacs initial file if it exists
;; =================================================================

(load "~/.l_emacs" t t t)
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )

;; =================================================================
;; Auto Insertion of Headers
;; =================================================================

(load "~/emacs-portable/header2.el" nil t t)

(require 'header2)

(autoload 'auto-update-file-header "header2")
(add-hook 'write-file-hooks 'auto-update-file-header)

(defvar project-name "wirelessT")

(setq header-copyright-notice "
   (c) 2014 HuaxingVision .Ltd
   Email:huaxingvision@huaxingvision.com
   All copy right reserved by HuaxingVision.

")

(setq header-author "Huaxing")
(setq header-maintainer "Huaxing")
 
(defun wirelessT-mode-config-header ()
  (interactive)

  (make-local-variable 'user-full-name)
  (make-local-variable 'user-mail-address)
  (setq user-full-name "Huaxing")
  (setq user-mail-address "huaxingvision@huaxingvision.com")
  (setq  make-header-hooks '(header-mode-line
                             header-blank
                             ;;header-rcs
                             ;;header-AFS
                             header-file-name
                             header-project-name
                             header-file-description
                             header-creation-date
                             header-author
                             ;;header-author-email
                             header-modification-author
                             header-modification-date
                             header-update-count
                             header-end-line
                             ))

  (setq file-header-update-alist nil)
  (progn
    (register-file-header-action "[ \t]Update Count[ \t]*: "
                                 'update-write-count)
    (register-file-header-action "[ \t]Last Modified By[ \t]*: "
                                 'update-last-modifier)
    (register-file-header-action "[ \t]Last Modified On[ \t]*: "
                                 'update-last-modified-date)
    (register-file-header-action " File            : *\\(.*\\) *$" 'update-file-name)
    ))
 
(global-set-key "\M-h" 'make-header)
 
(defun header-file-name ()
  "Places the buffer's file name and leaves room for a description."
  (insert header-prefix-string "File            : " (buffer-name) "\n")
  (setq return-to (1- (point))))
(defun header-project-name ()
  (insert header-prefix-string "Program/Library : " header-project-name "\n"))
(defun header-file-description()
  (insert header-prefix-string "Description     : \n"))
(defun header-author-email ()
  (insert header-prefix-string "Mail            : " user-mail-address "\n"))
 
(defun header-end-comment ()
  (if comment-end
      (insert  comment-end "\n")))
(defun update-file-name ()
  (beginning-of-line)
  ;; verify that we are looking at a file name for this mode
  (if (looking-at
       (concat (regexp-quote (header-prefix-string)) "File            : *\\(.*\\) *$"))
      (progn
        (goto-char (match-beginning 1))
        (delete-region (match-beginning 1) (match-end 1))
        (insert (file-name-nondirectory (buffer-file-name)) )
        )))


;(autoload 'js2-mode "js2-mode" nil t)
;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(autoload 'javascript-mode "javascript-mode" "JavaScript mode" t)
(setq auto-mode-alist (append '(("\\.js$" . javascript-mode))
    auto-mode-alist))
(setq auto-mode-alist (append '(("\\.julius$" . javascript-mode))
    auto-mode-alist))

(setq auto-mode-alist (append '(("\\.hamlet$" . html-mode))
    auto-mode-alist))

(setq auto-mode-alist (append '(("\\.cassius$" . css-mode))
    auto-mode-alist))
(setq auto-mode-alist (append '(("\\.lucius$" . css-mode))
    auto-mode-alist))

; Associate c-mode with the .js extension
; (setq auto-mode-alist (append '(("\\.js$" . c-mode)) auto-mode-alist))
; (setq auto-mode-alist (append '(("\\.julius$" . c-mode)) auto-mode-alist))