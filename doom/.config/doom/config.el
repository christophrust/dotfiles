;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Christoph Rust")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 11 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 11))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(global-set-key [f8] 'neotree-toggle)
(global-set-key [f5] '+fold/toggle)

(set-popup-rule! "^\\*R:" :ignore t)

(setq magic-mode-alist nil)

(after! ESS-mode
  (define-key ess-mode-map (kbd "<C-return>") 'ess-eval-region-or-line-and-step)
  (add-hook 'ess-mode-hook 'visual-line-mode)
  (defun ess-r-devtools-document-rust-package (&optional arg)
    "Interface for `rextendr::document()'.
With prefix ARG ask for extra arguments."
    (interactive "P")
    (ess-r-package-eval-linewise
     "rextendr::document(%s)\n" "Documenting %s" arg
     '("" (read-string "Arguments: "))))
  (map! "C-c C-w C-r" #'ess-r-devtools-document-rust-package)
  )

(after! c-mode
  (setq c-default-style "linux"
        c-basic-offset 4)
)
(after! rust-mode
  (setq rustic-analyzer-command '("~/.cargo/bin/rust-analyzer"))
)

(setq global-visual-line-mode t)
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; mu4e configuration
(after! mu4e
  (set-email-account!
   "gmail"
   '((mu4e-sent-folder       . "/gmail/Sent")
     (mu4e-trash-folder      . "/gmail/Trash")
     (mu4e-drafts-folder     . "/gmail/Drafts")
     (smtpmail-smtp-user     . "christoph.g.rust@gmail.com")
     (user-mail-address      . "christoph.g.rust@gmail.com")
     (mu4e-index-cleanup     . nil))
   t)
  (set-email-account!
   "ireen"
   '((mu4e-sent-folder       . "/ireen/Sent")
     (mu4e-trash-folder      . "/ireen/Trash")
     (mu4e-drafts-folder     . "/ireen/Drafts")
     (smtpmail-smtp-user     . "cr@ireen24.com")
     (user-mail-address      . "cr@ireen24.com")
     (mu4e-index-cleanup     . nil))
   t)
  (set-email-account!
   "ai-automatica"
   '((mu4e-sent-folder       . "/ai-automatica/Sent")
     (mu4e-trash-folder      . "/ai-automatica/Trash")
     (mu4e-drafts-folder     . "/ai-automatica/Drafts")
     (smtpmail-smtp-user     . "christoph.rust@ai-automatica.com")
     (user-mail-address      . "christoph.rust@ai-automatica.com")
     (mu4e-index-cleanup     . t))
   t)
  ;; (set-email-account!
  ;;  "ai-automatica.com2"
  ;;  '((mu4e-sent-folder       . "/ai-automatica/Sent")
  ;;    (mu4e-trash-folder      . "/ai-automatica/Trash")
  ;;    (mu4e-drafts-folder     . "/ai-automatica/Drafts")
  ;;    (smtpmail-smtp-user     . "christoph.rust@ai-automatica.com")
  ;;    (user-mail-address      . "rust@ai-automatica.com")
  ;;    (mu4e-index-cleanup     . t))
  ;;  t)
  (set-email-account!
   "ur"
   '((mu4e-sent-folder       . "/ur/Sent Items")
     (mu4e-trash-folder      . "/ur/Trash")
     (mu4e-drafts-folder     . "/ur/Work In Progress")
     (smtpmail-smtp-user     . "christoph.rust@ur.de")
     (user-mail-address      . "christoph.rust@ur.de")
     (mu4e-index-cleanup     . t))
   t)
  (set-email-account!
   "wu"
   '((mu4e-sent-folder       . "/wu/Sent")
     (mu4e-trash-folder      . "/wu/Trash")
     (mu4e-drafts-folder     . "/wu/Drafts")
     (smtpmail-smtp-user     . "christoph.rust@wu.ac.at")
     (user-mail-address      . "christoph.rust@wu.ac.at")
     (mu4e-index-cleanup     . t))
   t)

  (setq sendmail-program (executable-find "msmtp")
        send-mail-function #'smtpmail-send-it
        message-sendmail-f-is-evil t
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-send-mail-function #'message-send-mail-with-sendmail)

  (setq mu4e-get-mail-command "mbsync all"
        ;; get emails and index every 30 minutes
        ;; mu4e-update-interval nil
        ;; send emails with format=flowed
        mu4e-compose-format-flowed t
        ;; more sensible date format
        mu4e-headers-date-format "%d.%m.%y")
  )

;; active Babel languages
(org-babel-do-load-languages
   'org-babel-load-languages
    '((R . t)
         (emacs-lisp . nil)))
