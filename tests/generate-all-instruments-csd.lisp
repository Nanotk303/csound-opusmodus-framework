(require :asdf)

(unless (find-package :opusmodus)
  (defpackage :opusmodus (:use :cl)))

(load "src/Csound.lisp")
(load "src/CsoundInstrumentsLib.lisp")

(let ((instruments
       (loop for name in (opusmodus::list-csound-instruments)
             for definition = (opusmodus::find-csound-instrument name)
             when (eq (opusmodus::csound-instrument-type definition)
                      :instrument)
               collect name)))
  (opusmodus::def-csound-score
   :file "/tmp/csound-framework-all.csd"
   :instruments instruments
   :fx (append
        (loop for name in (opusmodus::list-csound-instruments)
              when (eq (opusmodus::csound-instrument-type
                        (opusmodus::find-csound-instrument name)) :fx)
                collect name)
        '("output"))
   :score-headers '("f 0 1")
   :events nil
   :play nil))
