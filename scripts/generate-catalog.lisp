(require :asdf)

(unless (find-package :opusmodus)
  (defpackage :opusmodus (:use :cl)))

(load "src/Csound.lisp")
(load "src/CsoundInstrumentsLib.lisp")

(opusmodus::generate-instrument-catalog "docs/INSTRUMENTS.md")
(format t "~&Generated docs/INSTRUMENTS.md~%")
