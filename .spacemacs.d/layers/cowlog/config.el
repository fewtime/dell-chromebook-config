(defvar org-agenda-dir ""
  "gtd org files location")

(defvar deft-dir ""
  "deft org files locaiton")

(defvar brain-dir ""
  "brain org files location")

(defvar root-dir ""
  "org root files location")

(defvar hugo-dir ""
  "hugo files location")

(if (spacemacs/system-is-mswindows)
    (setq
     root-dir "f:/.org"
     org-agenda-dir "f:/.org/gtd"
     deft-dir "f:/.org/deft"
     brain-dir "f:/.org/brain"
     org-id-locations-file-path "f:/.org/.org-id-locations"
     org-ditaa-dir "f:/.org/jar/ditaa.jar"
     org-plantuml-dir "f:/.org/jar/plantuml.jar"
     hugo-dir "~/Dropbox/blog"
     )
  (setq
   root-dir "~/.org"
   org-agenda-dir "~/.org/gtd"
   deft-dir "~/.org/deft"
   brain-dir "~/.org/brain"
   org-id-locations-file-path "~/.org/.org-id-locations"
   org-ditaa-dir "~/.org/jar/ditaa.jar"
   org-plantuml-dir "~/.org/jar/plantuml.jar"
   hugo-dir "~/Dropbox/blog"
   ))
