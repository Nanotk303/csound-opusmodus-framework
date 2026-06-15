(require :asdf)

(unless (find-package :opusmodus)
  (defpackage :opusmodus (:use :cl)))

(load "src/Csound.lisp")
(load "src/CsoundInstrumentsLib.lisp")

(opusmodus::def-csound-score
 :file "/tmp/csound-framework-audio-smoke.csd"
 :cs-options "-d -m0"
 :instruments '("sinedrone" "vco2pad1" "analog1" "fm1" "noisewhite")
 :fx '("output")
 :score-headers '("f 0 7")
 :events
 (list
  (opusmodus::cs-events "sinedrone" :start 0 :dur 1 :freq 220)
  (opusmodus::cs-events "vco2pad1" :start 1.2 :dur 1 :freq 220)
  (opusmodus::cs-events "analog1" :start 2.4 :dur 1 :freq 220)
  (opusmodus::cs-events "fm1" :start 3.6 :dur 1 :freq 220)
  (opusmodus::cs-events "noisewhite" :start 4.8 :dur 1))
 :play nil)
