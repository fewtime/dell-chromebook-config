;;; packages.el --- hugo layer packages file for Spacemacs.
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
;; added to `hugo-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `hugo/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `hugo/pre-init-PACKAGE' and/or
;;   `hugo/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst hugo-packages
  '(
    ;; (ox :location built-in)
    ;; (ox-hugo :location built-in)
    ox-hugo-auto-export
    easy-hugo
    )
  )

;; (defun cowlog-hugo/post-init-ox ()
;;   (with-eval-after-load 'ox
;;     (require 'ox-hugo)
;;     (require 'ox-hugo-auto-export)))

;; (defun cowlog-hugo/post-init-ox-hugo()
;;   (with-eval-after-load 'ox-hugo))

(defun hugo/post-init-ox-hugo-auto-export()
  (with-eval-after-load 'ox-hugo
    (require 'ox-hugo-auto-export)))

(defun hugo/init-easy-hugo ()
  (use-package easy-hugo
    ;; :after (helm-ag)
    :ensure t
    :config
    (progn
      (setq hugo-basedir (expand-file-name hugo-dir))
      (setq easy-hugo-basedir hugo-basedir
            ;; easy-hugo-postdir "content/post"
            easy-hugo-url "https://cowlog.com"
            easy-hugo-preview-url "http://127.0.0.1:1313"
            easy-hugo-sshdomain "ovhca"
            easy-hugo-root hugo-basedir
            easy-hugo-previewtime "20")
      (add-hook 'easy-hugo-mode-hook 'cowlog/easy-hugo))))


;;; packages.el ends here
