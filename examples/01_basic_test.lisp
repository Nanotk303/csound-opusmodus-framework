(in-package :opusmodus)

(load "../src/Csound.lisp")
(load "../src/CsoundInstrumentsLib.lisp")

(def-csound-score
  :file "test.csd"
  :instruments '("sinedrone")
  :fx '("plateau1" "output")

  :score-headers '("f 0 30")

  :events
  (list
   (cs-event "sinedrone"
     :start '(0 5 10)
     :dur 8
     :amp -24
     :midi '(48 55 60)
     :pan1 0.2
     :pan2 0.8))

  :play nil)

(render-last-score :open t)
