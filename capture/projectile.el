;;; projectile.el --- screencasts for projectile.mx  -*- lexical-binding: t; -*-

(load (expand-file-name "prelude.el" (getenv "GIF_DIR")))

(defvar pj-scratch (file-name-as-directory (getenv "PJ_SCRATCH")))
(defvar pj-acme (expand-file-name "acme-billing/" pj-scratch))
(defvar pj-projects
  (append (mapcar (lambda (d) (file-name-as-directory (expand-file-name d "~/projects/")))
                  '("cider" "cider-nrepl" "orchard" "clojure-mode" "clojure-ts-mode"
                    "inf-clojure" "clj-refactor.el" "projectile" "crux" "flycheck" "neocaml"))
          (list pj-acme)))

;; The demo repos' .dir-locals.el would stop everything with a safety prompt.
(setq enable-local-variables nil)

;; A prompt nobody answers looks exactly like a hang, so name it in the log.
(dolist (fn '(y-or-n-p yes-or-no-p))
  (advice-add fn :before (lambda (prompt &rest _) (gif-log "PROMPT %s: %s" fn prompt))))

;; The demos browse real repositories; make sure nothing typed can change them.
(add-hook 'find-file-hook
          (lambda ()
            (when (string-prefix-p (expand-file-name "~/projects/") buffer-file-name)
              (read-only-mode 1))))
(setq compilation-ask-about-save nil)

(defun pj-select (prefix)
  "Select the window whose buffer name starts with PREFIX."
  (lambda ()
    (when-let* ((w (seq-find (lambda (w) (string-prefix-p prefix (buffer-name (window-buffer w))))
                             (window-list))))
      (select-window w))))

;; Keep Projectile's state files out of the real ~/.emacs.d.
(setq user-emacs-directory (expand-file-name "emacs.d/" pj-scratch))

(defun pj-open (file)
  (switch-to-buffer (find-file-noselect file))
  (delete-other-windows)
  (goto-char (point-min)))

(defun pj-await (&optional secs)
  (lambda ()
    (let ((end (+ (float-time) (or secs 0.8))))
      (while (< (float-time) end)
        (accept-process-output nil 0.1)))))

(defun pj-segment (name setup)
  (lambda ()
    (setq gif-name name gif-seq 0)
    (ignore-errors (abort-recursive-edit))
    (delete-other-windows)
    (funcall setup)
    (setq keycast--this-command-keys nil
          keycast--this-command-desc nil)
    (message nil)))

(defun pj-quiet () (lambda () (message nil)))

(defun pj-steps ()
  (append
   ;; switching projects, then a file in the new one
   (list (pj-segment "switch-project"
                     (lambda () (pj-open (expand-file-name "~/projects/cider/lisp/cider.el"))))
         120
         "s-p p" 110)
   (gif-typing "orch" 2 14)
   (list 110 "RET" (pj-await 1.5) 110)
   (gif-typing "insp" 2 14)
   (list 130 "RET" (pj-await 0.8) (pj-quiet) 260)

   ;; finding a file
   (list (pj-segment "find-file"
                     (lambda () (pj-open (expand-file-name "~/projects/cider/lisp/cider.el"))))
         110
         "s-p f" (pj-await 1) 100)
   (gif-typing "repl test" 2 14)
   (list 140 "RET" (pj-await 0.8) (pj-quiet) 240)

   ;; searching
   (list (pj-segment "search"
                     (lambda () (pj-open (expand-file-name "~/projects/cider/lisp/cider.el"))))
         110
         "s-p s s" 90)
   (gif-typing "cider-jack-in-clj" 4 12)
   (list 90 "RET" (pj-await 2.5) (pj-quiet) 220
         (pj-select "*grep")
         "n" (pj-await 0.5) 120 "n" (pj-await 0.5) 200)

   ;; running the tests
   (list (pj-segment "test"
                     (lambda ()
                       (let ((default-directory pj-acme))
                         (call-process "go" nil nil nil "clean" "-testcache"))
                       (pj-open (expand-file-name "invoice/invoice.go" pj-acme))))
         110
         "s-p c t" 170
         "RET" (pj-await 3) (pj-quiet) 320)

   ;; stills: the dispatch menu, the dashboard, sibling projects, replace preview
   (list (pj-segment "dispatch"
                     (lambda ()
                       (set-frame-size nil 124 24)
                       (pj-open (expand-file-name "~/projects/cider/lisp/cider.el"))))
         "s-p m" (pj-await 1) 100
         (lambda () (ignore-errors (transient-quit-all)) (set-frame-size nil 92 24)))
   (list (pj-segment "dashboard"
                     (lambda ()
                       (pj-open (expand-file-name "~/projects/cider/lisp/cider.el"))
                       (projectile-project-files (projectile-project-root))))
         "s-p P" (pj-await 3)
         (lambda () (when-let* ((w (get-buffer-window "*projectile-dashboard*")))
                      (select-window w) (delete-other-windows)))
         (pj-quiet) 100)
   (list (pj-segment "siblings"
                     (lambda () (pj-open (expand-file-name "~/projects/cider/lisp/cider.el"))))
         "s-p n p" (pj-await 1.5) 100
         "C-g" 20)
   (list (pj-segment "replace"
                     (lambda ()
                       (pj-open (expand-file-name "invoice/invoice.go" pj-acme))
                       (re-search-forward "func (inv Invoice) Subtotal")
                       (backward-word)))
         "s-p R" 60
         "RET" 60)
   (gif-typing "NetAmount" 9 10)
   (list "RET" (pj-await 2) (pj-quiet) 100)))

(condition-case err
    (progn
      (add-to-list 'load-path (expand-file-name (or (getenv "PROJECTILE_DIR") "~/projects/projectile")))
      (setq gif-packages (append gif-packages '("marginalia-*"))
            native-comp-async-report-warnings-errors 'silent
            confirm-kill-processes nil
            gif-frame-size '(92 . 24))
      (gif-setup)
      (when (require 'marginalia nil t) (marginalia-mode 1))
      (add-to-list 'exec-path "/opt/homebrew/bin")
      (require 'projectile)
      (setq projectile-known-projects pj-projects
            projectile-known-projects-file (expand-file-name "projectile-bookmarks.eld" user-emacs-directory)
            projectile-cache-file (expand-file-name "projectile.cache" user-emacs-directory)
            projectile-auto-discover nil
            compilation-scroll-output t
            projectile-enable-caching t
            projectile-project-groups
            `(("clojure-emacs" . ,(mapcar (lambda (d) (expand-file-name d "~/projects/"))
                                          '("cider" "cider-nrepl" "orchard" "clojure-mode"
                                            "clojure-ts-mode" "inf-clojure" "clj-refactor.el")))))
      (projectile-mode 1)
      (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
      (setq keycast-substitute-alist
            '((projectile-switch-project "s-p p" t)
              (projectile-find-file "s-p f" t)
              (projectile-search "s-p s s" t)
              (projectile-test-project "s-p c t" t)
              (projectile-dispatch "s-p m" t)
              (projectile-dashboard "s-p P" t)
              (projectile-switch-sibling-project "s-p n p" t)
              (projectile-replace "s-p r" t)
              (projectile-replace-review "s-p R" t)
              (vertico-exit "RET" t)
              (exit-minibuffer "RET" t)
              (self-insert-command nil nil)))
      (run-with-timer 1 nil (lambda () (apply #'gif-script (pj-steps))))
      (run-with-timer 240 nil (lambda () (gif-log "TIMEOUT") (kill-emacs))))
  (error (gif-log "ERROR: %S" err) (kill-emacs)))
