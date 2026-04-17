(in-package :opusmodus)

;; ------------------------------------------------------------
;; VCO2 pad demo
;; ------------------------------------------------------------

(load "src/Csound.lisp")
(load "src/CsoundInstrumentsLib.lisp")

(init-seed 90210)

(def-csound-score
  :file "/Users/stephaneboussuge/ComposingWorkspace/CSound/VCO2Pad_Demo.csd"
  :instruments '("vco2pad1")
  :fx '("plateau1" "output")

  :score-headers
  '("f 0 46"
    "f1 0 8192 10 1 1 0.8 0.6 0.4 0.2")

  :events
  (list
   (cs-event "vco2pad1"
             :start   '(0 8 16 24)
             :dur     '(12)
             :amp     '(-24 -23 -22 -24)
             :freq    '(110 146.83 196 246.94)
             :atk     '(1.5)
             :rel     '(2.5)
             :detune  '(0.35)
             :bright  '(0.55)
             :vibdepth '(0.15)
             :vibrate '(4.5)
             :submix  '(0.2)
             :pan1    '(0.15 0.25 0.65 0.75)
             :pan2    '(0.85 0.75 0.35 0.25)))

  :play nil)

(render-last-score :open t)
