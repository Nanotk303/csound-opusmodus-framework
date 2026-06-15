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
