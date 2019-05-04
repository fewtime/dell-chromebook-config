(defvar org-agenda-dir ""
  "gtd org files location")

(defvar deft-dir ""
  "deft org files locaiton")

(if (spacemacs/system-is-mswindows)
    (setq
     org-agenda-dir "f:/.org/gtd"
     deft-dir "f:/.org/deft")
  (setq
   org-agenda-dir "~/.org/gtd"
   deft-dir "~/.org/deft"))
