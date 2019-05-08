;;; packages.el --- cowlog-org layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author:  <cowlog@archlinux>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `cowlog-org-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `cowlog-org/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `cowlog-org/pre-init-PACKAGE' and/or
;;   `cowlog-org/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst cowlog-org-packages
  '(
    (org :location built-in)
    org-pomodoro
    org-clock-convenience
    deft
    )
  )

(defun cowlog-org/post-init-org ()
  (with-eval-after-load 'org
    (progn

      (require 'org-compat)
      (require 'org)
      (require 'org-habit)


      ;; 加密文章
      ;; "http://coldnew.github.io/blog/2013/07/13_5b094.html"
      ;; org-mode 設定
      (require 'org-crypt)

      ;; 當被加密的部份要存入硬碟時，自動加密回去
      (org-crypt-use-before-save-magic)

      ;; 設定要加密的 tag 標籤為 SECRET
      (setq org-crypt-tag-matcher "SECRET")

      ;; 避免 secret 這個 tag 被子項目繼承 造成重複加密
      ;; (但是子項目還是會被加密喔)
      (setq org-tags-exclude-from-inheritance (quote ("SECRET")))

      ;; 用於加密的 GPG 金鑰
      ;; 可以設定任何 ID 或是設成 nil 來使用對稱式加密 (symmetric encryption)
      (setq org-crypt-key nil)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;       ;; Org clock
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

      ;; Save clock data and notes in the LOGBOOK drawer
      (setq org-clock-into-drawer t)
      ;; Removes clocked tasks with 0:00 duration
      (setq org-clock-out-remove-zero-time-clocks t) ;; Show the clocked-in task - if any - in the header line

      (setq org-plantuml-jar-path
            (expand-file-name "~/.spacemacs.d/plantuml.jar"))
      (setq org-ditaa-jar-path "~/.spacemacs.d/ditaa.jar")

      ;; org-babel
      (org-babel-do-load-languages
       'org-babel-load-languages
       '((perl . t)
         (ruby . t)
         (shell . t)
         (dot . t)
         (js . t)
         (latex .t)
         (python . t)
         (emacs-lisp . t)
         (plantuml . t)
         (C . t)
         (ditaa . t)))

      ;; GTD 方案
      ;; https://emacs.cafe/emacs/orgmode/gtd/2017/06/30/orgmode-gtd.html
      ;; https://github.com/zilongshanren/spacemacs-private/blob/develop/layers/zilongshanren-org/packages.el
      ;; https://github.com/jethrokuan/.emacs.d/blob/master/config.org#org-mode-for-gtd
      ;; define the refile targets
      (setq org-agenda-file-inbox (expand-file-name "inbox.org" org-agenda-dir))
      (setq org-agenda-file-someday (expand-file-name "someday.org" org-agenda-dir))
      (setq org-agenda-file-next (expand-file-name "next.org" org-agenda-dir))
      (setq org-agenda-file-projects (expand-file-name "projects.org" org-agenda-dir))
      (setq org-agenda-file-reading (expand-file-name "reading.org" org-agenda-dir))
      ;; (setq org-agenda-file-journal (expand-file-name "journal.org" org-agenda-dir))
      ;; (setq org-agenda-file-code-snippet (expand-file-name "snippet.org" org-agenda-dir))
      ;; (setq org-default-notes-file (expand-file-name "inbox.org" org-agenda-dir))
      (setq org-agenda-files (list org-agenda-dir))

      (setq deft-file-capture (expand-file-name "capture.org" deft-dir))

      ;; Collecting
      (setq org-capture-templates
            `(("i" "Todo [inbox]" entry (file+headline org-agenda-file-inbox "Task")
               "* TODO [#B] %i%? \n %U")
              ("t" "Tickler" entry (file+headline org-agenda-file-inbox "Tickler")
               "* %i%? \n %U")
              ("s" "snippet" entry (file deft-file-capture)
               "* Snippet %<%Y-%m-%d %H:%M>\n%?")))

      ;; Processing
      ;; Org Agenda Inbox View
      (setq cowlog/org-agenda-inbox-view
            `("i" "Inbox" todo ""
              ((org-agenda-files '("~/.org/gtd/inbox.org")))))
      (add-to-list 'org-agenda-custom-commands `,cowlog/org-agenda-inbox-view)
      ;; Org Agenda Someday View
      (setq cowlog/org-agenda-someday-view
            `("s" "Someday" todo ""
              ((org-agenda-files '("~/.org/gtd/someday.org")))))
      (add-to-list 'org-agenda-custom-commands `,cowlog/org-agenda-someday-view)
      ;; Org Agenda Reading view
      (setq cowlog/org-agenda-reading-view
            `("r" "reading" todo ""
              ((org-agenda-files '("~/.org/gtd/reading.org")))))
      (add-to-list 'org-agenda-custom-commands `,cowlog/org-agenda-reading-view)

      ;; Org TODO Keywords
      (setq org-todo-keywords
            '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")))

      (setq org-log-done 'time)
      (setq org-log-into-drawer t)
      (setq org-log-state-notes-insert-after-drawers nil)

      ;; The process
      ;; Clarifying
      (setq org-tag-alist (quote (("@errand" . ?e)
                                  ("@office" . ?o)
                                  ("@home" . ?h)
                                  ("@school" . ?s)
                                  (:newline)
                                  ("SECRET" . ?S)
                                  ("WAITING" . ?w)
                                  ("HOLD" . ?H)
                                  ("CANCELLED" . ?c))))

      (setq org-fast-tag-selection-single-key nil)

      ;; Organizing
      ;; https://github.com/syl20bnr/spacemacs/issues/3094
      (setq org-refile-use-outline-path 'file
            org-outline-path-complete-in-steps nil)
      (setq org-refile-allow-creating-parent-nodes 'confirm)
      (setq org-refile-targets '((org-agenda-file-next :level . 0)
                                 (org-agenda-file-someday :maxlevel . 1)
                                 (org-agenda-file-reading :level . 1)
                                 (org-agenda-file-projects :maxlevel . 1)))

      (setq org-agenda-bulk-custom-functions `((,cowlog/org-agenda-bulk-process-key cowlog/org-agenda-process-inbox-item)))

      (with-eval-after-load 'org-agenda
        (define-key org-agenda-mode-map (kbd "i") 'org-agenda-clock-in)
        (define-key org-agenda-mode-map (kbd "r") 'cowlog/org-process-inbox)
        (define-key org-agenda-mode-map (kbd "R") 'org-agenda-refile)
        (define-key org-agenda-mode-map (kbd "c") 'cowlog/org-inbox-capture)
        (spacemacs/set-leader-keys-for-major-mode 'org-agenda-mode-map
          "." 'spacemacs/org-agenda-transient-state/body))

      ;; Clocking in
      (add-hook 'org-clock-in-hook 'cowlog/set-todo-state-next 'append)
      ;; post-init-org-clock-convenience

      ;; Reviewing
      ;; Custom agenda Commands
      (setq org-agenda-block-separator nil)
      (setq org-agenda-start-with-log-mode t)

      (setq cowlog/org-agenda-priority-view
            `("p" "Priority"
              (
               (tags-todo "+PRIORITY=\"A\""
                     ((org-agenda-overriding-header "重要且紧急的任务")
                      (org-agenda-files '("~/.org/gtd/someday.org"
                                          "~/.org/gtd/projects.org"
                                          "~/.org/gtd/next.org"))
                      ))
               (tags-todo "-Weekly-Monthly-Daily+PRIORITY=\"B\""
                          ((org-agenda-overriding-header "重要且不紧急的任务")
                           (org-agenda-files '("~/.org/gtd/someday.org"
                                               "~/.org/gtd/projects.org"
                                               "~/.org/gtd/next.org"))
                           ))
               (tags-todo "+PRIORITY=\"C\""
                          ((org-agenda-overriding-header "不重要且紧急的任务")
                           (org-agenda-files '("~/.org/gtd/someday.org"
                                               "~/.org/gtd/projects.org"
                                               "~/.org/gtd/next.org"))
                           ))
               nil)))
      (add-to-list 'org-agenda-custom-commands `,cowlog/org-agenda-priority-view)

      (setq cowlog/org-agenda-todo-view
            `(" " "Agenda"
              ((agenda ""
                       ((org-agenda-span 'day)
                        (org-deadline-warning-days 365)))
               (todo "TODO"
                     ((org-agenda-overriding-header "To Refile")
                      (org-agenda-files '("~/.org/gtd/inbox.org"))))
               (todo "NEXT"
                     ((org-agenda-overriding-header "In Progress")
                      (org-agenda-files '("~/.org/gtd/someday.org"
                                          "~/.org/gtd/projects.org"
                                          "~/.org/gtd/next.org"))
                      ;; (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled))
                      ))
               (todo "TODO"
                     ((org-agenda-overriding-header "Projects")
                      (org-agenda-files '("~/.org/gtd/projects.org"))
                      ;; (org-agenda-skip-function #'cowlog/org-agenda-skip-all-siblings-but-first)
                      ))
               (todo "TODO"
                     ((org-agenda-overriding-header "One-off Tasks")
                      (org-agenda-files '("~/.org/gtd/next.org"))
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled))))
               nil)))

      (add-to-list 'org-agenda-custom-commands `,cowlog/org-agenda-todo-view)


      (setq org-columns-default-format "%40ITEM(Task) %Effort(EE){:} %CLOCKSUM(Time Spent) %SCHEDULED(Scheduled) %DEADLINE(Deadline)")

      ;; Doing
      ;; cowlog-org/init-org-pomodoro

      )))

;; Clocking in
(defun cowlog-org/init-org-clock-convenience ()
  :init
  (use-package
    org-clock-convenience

    :config
    (progn
      (with-eval-after-load 'org-agenda
        (define-key org-agenda-mode-map (kbd "<S-up>") 'org-clock-convenience-timestamp-up)
        (define-key org-agenda-mode-map (kbd "<S-down>") 'org-clock-convenience-timestamp-down)
        (define-key org-agenda-mode-map (kbd "o") 'org-clock-convenience-fill-gap)
        (define-key org-agenda-mode-map (kbd "e") 'org-clock-convenience-fill-gap-both)
        (spacemacs/set-leader-keys-for-major-mode 'org-agenda-mode-map
          "." 'spacemacs/org-agenda-transient-state/body)))))

;; Doing
(defun cowlog-org/post-init-org-pomodoro ()
  (with-eval-after-load 'org
    (progn
      (with-eval-after-load 'org-agenda
        (define-key org-agenda-mode-map (kbd "I") 'org-pomodoro)))))


;;; packages.el ends here
