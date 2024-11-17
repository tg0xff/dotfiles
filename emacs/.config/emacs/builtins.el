;; -*- lexical-binding: t -*-

(keymap-global-set "<leader> w" 'whitespace-mode)
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
(add-hook 'prog-mode-hook 'electric-pair-local-mode)

(use-package info
  :ensure nil
  :defer t
  :preface
  (when (eq system-type 'gnu/linux)
    (with-eval-after-load 'info (progn
                                  (add-to-list 'Info-directory-list "/usr/share/info")
                                  (add-to-list 'Info-directory-list "/usr/local/share/info")))))

(use-package dired
  :ensure nil
  :hook (dired-mode . dired-hide-details-mode)
  :custom
  (dired-listing-switches "-lv --almost-all --group-directories-first --human-readable --classify --time-style long-iso")
  (dired-kill-when-opening-new-dired-buffer t))

(use-package ediff
  :ensure nil
  :custom
  (ediff-split-window-function 'split-window-horizontally)
  (ediff-window-setup-function 'ediff-setup-windows-plain))

;; https://orgmode.org/
;; https://git.savannah.gnu.org/cgit/emacs/org-mode.git
(use-package org
  :ensure nil
  :hook
  (org-mode . variable-pitch-mode)
  (org-todo-repeat . org-reset-checkbox-state-subtree)
  (after-init . my/open-all-org-files)
  :bind
  (("<leader> o a" . org-agenda)
   ("<leader> o c" . my/org-capture-default)
   ("<leader> o l" . org-store-link)
   :map org-mode-map
   ("<leader> . m" . my/org-sort-media)
   ("<leader> . t" . my/org-sort-todo))
  :custom
  (org-directory `,(expand-file-name "Documents/org" my/home-directory))
  (org-agenda-files `(,org-directory))
  (org-capture-templates '(("d" "default"
                            entry (file "inbox.org")
                            "* TODO %?")))
  (org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAIT(w)" "|" "DONE(d)")))
  (org-agenda-tags-column 0)
  (org-agenda-span 'day)
  (org-M-RET-may-split-line nil)
  (org-ellipsis "   […]")
  (org-tags-column 0)
  (org-log-done 'time)
  (org-preview-latex-image-directory `,(expand-file-name "org-latex-preview" temporary-file-directory))
  (org-image-actual-width '(400))
  (org-agenda-custom-commands '(("n" todo "NEXT"
                                 ((org-agenda-sorting-strategy '(category-up priority-down))))
                                ("c" tags "+@casa")
                                ("j" tags "+@trabajo")
                                ("d" tags "+@tienda")))
  (org-tag-alist '(("@casa" . ?c)
                   ("@trabajo" . ?t)
                   ("@tienda" . ?d)))
  :init
  (defun my/org-capture-default ()
    (interactive)
    (org-capture nil "d"))
  (defun my/open-all-org-files ()
    (interactive)
    (find-file (concat org-directory "/*.org") t))
  (defun my/org-sort-media ()
    (interactive)
    (org-sort-entries nil ?a)
    (org-sort-entries nil ?p)
    (org-sort-entries nil ?o))
  (defun my/org-sort-todo ()
    (interactive)
    (org-sort-entries nil ?p)
    (org-sort-entries nil ?o)))
