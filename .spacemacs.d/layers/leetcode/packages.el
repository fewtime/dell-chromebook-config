;;; packages.el --- leetcode layer packages file for Spacemacs.
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
;; added to `leetcode-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `leetcode/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `leetcode/pre-init-PACKAGE' and/or
;;   `leetcode/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst leetcode-packages
  '(dash
    request
    request-deferred
    graphql
    spinner
    (leetcode :location (recipe
                         :fetcher github
                         :repo "kaiwk/leetcode.el"))))

(defun leetcode/init-leetcode ()
  (use-package leetcode
    :defer
    :init
    (spacemacs/set-leader-keys
      "alr" 'leetcode
      "als" 'leetcode-submit
      "alt" 'leetcode-try
      )
    )
  )

(defun leetcode/post-init-dash ()
  )

(defun leetcode/post-init-request ()
  )

(defun leetcode/post-init-request-deferred ()
  )

(defun leetcode/post-init-graphql ()
  )

(defun leetcode/post-init-spinner ()
  )

;;; packages.el ends here
