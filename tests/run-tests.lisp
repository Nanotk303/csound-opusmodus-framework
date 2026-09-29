(require :asdf)

(unless (find-package :opusmodus)
  (defpackage :opusmodus (:use :cl)))

(load "src/Csound.lisp")
(load "src/CsoundInstrumentsLib.lisp")

(in-package :opusmodus)

(defun check (condition message)
  (unless condition
    (error "Test failed: ~A" message)))

(check (= 77 (length (list-csound-instruments)))
       "unexpected number of registered instruments")

(maphash
 (lambda (name instrument)
   (declare (ignore name))
   (dolist (pfield (csound-instrument-pfields instrument))
     (let ((key (%keywordify pfield)))
       (check (or (%plist-key-present-p
                   (csound-instrument-defaults instrument) key)
                  (member pfield (csound-instrument-required instrument)))
              (format nil "~A has no default or required marker for ~A"
                      (csound-instrument-name instrument) pfield)))))
 *csound-library*)

(let* ((event (cs-events "sinedrone" :start 0 :dur 1))
       (line (render-csound-event event)))
  (check (not (search "NIL" line)) "default rendering emitted NIL")
  (check (search "-24 440 0.5 0.5" line)
         "sinedrone defaults were not rendered"))

(let* ((event (cs-events "sinedrone" :start 0 :dur 1 :midi 69))
       (line (render-csound-event event)))
  (check (search "440.0" line) "legacy :midi alias was not converted to Hz"))

(let ((raised nil))
  (handler-case
      (cs-events "samplerraw" :start 0 :dur 1)
    (error () (setf raised t)))
  (check raised "missing required :file was accepted"))

(let ((raised nil))
  (handler-case
      (cs-events "sinedrone" :start 0 :dur 1 :pan1 1.5)
    (error () (setf raised t)))
  (check raised "out-of-range pan was accepted"))

(let ((raised nil))
  (handler-case
      (cs-events "sinedrone" :start 0 :dur 1 :freq 0)
    (error () (setf raised t)))
  (check raised "non-positive frequency was accepted"))

(let ((catalog (generate-instrument-catalog)))
  (check (search "`sinedrone`" catalog) "catalog omitted sinedrone")
  (check (search "deprecie, sans effet" catalog)
         "catalog omitted deprecated parameter status"))

(format t "~&All framework tests passed.~%")

;; Published documentation must be exactly reproducible from this library.
(check (string= (generate-instrument-catalog)
                (uiop:read-file-string "docs/INSTRUMENTS.md"))
       "published catalogue differs from the source; regenerate it")

(dolist (case '((detunehz "Hz" nil) (detune "cents" nil)
                (lpfq "Q" nil) (panmode "selecteur 0/1/2" nil)
                (prate "ratio" nil)
                (xfade "fraction de duree" "synthwaveformvibrato")
                (xfade "seconds" "mincer3")))
  (check (string= (csound-pfield-unit (first case) (third case))
                  (second case))
         (format nil "wrong unit for ~A" case)))

;; Metadata consumed by editors must expose every declared score parameter.
(dolist (name (csound-emacs-instrument-names))
  (let* ((instrument (find-csound-instrument name))
         (fields (csound-instrument-pfields instrument))
         (metadata (csound-emacs-metadata name)))
    (check (= (+ 2 (length fields)) (length (getf metadata :parameters)))
           (format nil "incomplete editor parameters for ~A" name))
    (check (= (length fields) (length (remove-duplicates fields)))
           (format nil "duplicate parameter in ~A" name))
    (loop for (key value) on (csound-instrument-defaults instrument) by #'cddr
          do (check (member key fields :key #'%keywordify)
                    (format nil "undeclared default ~A in ~A" key name)))
    (dolist (field (append (csound-instrument-required instrument)
                          (csound-instrument-deprecated instrument)))
      (check (member field fields)
             (format nil "undeclared metadata field ~A in ~A" field name)))))

;; Several instruments share this table; render it once, before any instrument.
(let* ((a (find-csound-instrument "sinedrone"))
       (b (find-csound-instrument "sineunitenvelope")))
  (check (string= (render-csound-globals (list a b a))
                  (render-csound-globals (list a b)))
         "global declarations were duplicated")
  (check (not (search "ftgen" (render-csound-instrument a :include-globals nil)))
         "instrument still embeds shared global tables"))

(format t "~&Catalogue, metadata and shared-global checks passed.~%")
