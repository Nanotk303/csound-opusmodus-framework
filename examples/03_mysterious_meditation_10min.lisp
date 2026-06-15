(in-package :opusmodus)

;;; ============================================================
;;; LES SEUILS DU SILENCE
;;; Mysterious and meditative study, approximately 10 minutes
;;; ============================================================

(defvar *mysterious-piece-output*
  "/Users/stephaneboussuge/Csoundscores/Les_Seuils_du_Silence.csd")

(defvar *render-mysterious-piece* t)

(defparameter *mystery-state* 140626)

(defun mystery-random-unit ()
  "Small deterministic generator, independent from the Lisp implementation."
  (setf *mystery-state*
        (mod (+ (* *mystery-state* 1103515245) 12345)
             2147483648))
  (/ *mystery-state* 2147483648.0))

(defun mystery-random-between (minimum maximum)
  (+ minimum (* (- maximum minimum) (mystery-random-unit))))

(defun mystery-random-list (count minimum maximum)
  (loop repeat count
        collect (mystery-random-between minimum maximum)))

(defun mystery-choice (values)
  (nth (floor (* (length values) (mystery-random-unit))) values))

(defun mystery-choice-list (count values)
  (loop repeat count collect (mystery-choice values)))

(defun mystery-times (count start end)
  (sort (mystery-random-list count start end) #'<))

(defun mystery-pan-starts (count)
  (mystery-random-list count 0.08 0.42))

(defun mystery-pan-ends (starts)
  (mapcar (lambda (pan) (- 1 pan)) starts))

(defun mystery-spectrum (fundamental partial-count exponent)
  (loop for partial from 1 to partial-count
        collect (* fundamental (expt partial exponent))))

(setf *mystery-state* 140626)

(defparameter *mystery-duration* 600)
(defparameter *mystery-low-spectrum*
  (mystery-spectrum 36.0 28 0.67))
(defparameter *mystery-high-spectrum*
  (mystery-spectrum 55.0 32 0.61))
(defparameter *mystery-pitch-pool*
  (append *mystery-low-spectrum* *mystery-high-spectrum*))

(defparameter *bowl-file*
  "/Users/stephaneboussuge/Samples/Divers/tibetan-singing-bowl.wav")
(defparameter *ice-stereo-file*
  "/Users/stephaneboussuge/Samples/Divers/IceOutside.wav")
(defparameter *bell-file*
  "/Users/stephaneboussuge/Samples/Divers/ChurchBellC2.aif")
(defparameter *voice-mono-file*
  "/Users/stephaneboussuge/Samples/Divers/adrienMono.wav")

;;; Shared spatial trajectories.
(defparameter *night-pan1* (mystery-pan-starts 22))
(defparameter *pad-pan1* (mystery-pan-starts 20))
(defparameter *vco-pan1* (mystery-pan-starts 26))
(defparameter *noise-pan1* (mystery-pan-starts 13))
(defparameter *bowl-pan1* (mystery-pan-starts 18))
(defparameter *ice-pan1* (mystery-pan-starts 10))

(def-csound-score
 :file *mysterious-piece-output*
 :instruments '("night"
                "pad1"
                "vco2pad1"
                "analog1"
                "fm1"
                "trombone"
                "noisesahenv"
                "mincer2"
                "mincer3"
                "lposcil"
                "samplerreverb")
 :fx '("plateau1" "output")
 :score-headers '("f 0 620"
                  "f1 0 16384 10 1 0.5 0.25 0.125 0.06")
 :events
 (list

  ;; ----------------------------------------------------------
  ;; I. Threshold: slowly appearing harmonic shadows, 0'00-2'20
  ;; ----------------------------------------------------------
  (cs-event "night"
            :start (append '(0 18 42 71)
                           (mystery-times 18 92 550))
            :dur (append '(92 84 105 78)
                         (mystery-random-list 18 46 92))
            :amp (append '(-29 -28 -27 -29)
                         (mystery-random-list 18 -30 -25))
            :freq (append '(36.0 53.87 72.0 91.4)
                          (mystery-choice-list 18 *mystery-low-spectrum*))
            :pan1 *night-pan1*
            :pan2 (mystery-pan-ends *night-pan1*))

  (cs-event "pad1"
            :start (append '(32 63 104)
                           (mystery-times 17 138 560))
            :dur (append '(70 86 58)
                         (mystery-random-list 17 34 68))
            :amp (append '(-27 -28 -26)
                         (mystery-random-list 17 -29 -24))
            :freq (append '(72.0 108.0 144.0)
                          (mystery-choice-list 17 *mystery-low-spectrum*))
            :rise (mystery-random-list 20 7 18)
            :dec (mystery-random-list 20 9 22)
            :wave 1)

  ;; ----------------------------------------------------------
  ;; II. Resonant memory: bowl and distant ice, 1'20-4'20
  ;; ----------------------------------------------------------
  (cs-event "mincer2"
            :start (append '(78 111 146)
                           (mystery-times 15 178 520))
            :dur (mystery-random-list 18 24 52)
            :file *bowl-file*
            :amp (mystery-random-list 18 -31 -23)
            :startpos (mystery-random-list 18 0 48)
            :speed (mystery-random-list 18 0.025 0.18)
            :pitch (mystery-choice-list 18 '(0.5 0.667 0.75 1.0 1.5))
            :lock 1
            :fftsize (mystery-choice-list 18 '(1024 2048 4096))
            :decim 4
            :freeze (mystery-choice-list 18 '(0 0 0 0 1))
            :jitterdepth (mystery-random-list 18 0.0 0.08)
            :jitterrate (mystery-random-list 18 0.15 1.2)
            :att (mystery-random-list 18 3 10)
            :hold (mystery-random-list 18 0 3)
            :dec (mystery-random-list 18 4 12)
            :sus (mystery-random-list 18 0.45 0.82)
            :rel (mystery-random-list 18 5 14)
            :cutoff (mystery-random-list 18 700 4800)
            :res (mystery-random-list 18 0.12 0.58)
            :filttype (mystery-choice-list 18 '(0 0 1))
            :panmode (mystery-choice-list 18 '(0 0 1 2))
            :pan1 *bowl-pan1*
            :pan2 (mystery-pan-ends *bowl-pan1*)
            :panrate (mystery-random-list 18 0.02 0.11)
            :pandepth (mystery-random-list 18 0.15 0.65))

  (cs-event "lposcil"
            :start '(126 214 307 401 493)
            :dur '(38 47 34 51 42)
            :file *ice-stereo-file*
            :amp '(-29 -31 -27 -32 -30)
            :speed '(0.22 0.17 0.31 0.13 0.25)
            :loopstart '(0)
            :loopend '(437000)
            :atk '(8 12 7 15 11)
            :rel '(12 14 10 16 15)
            :pan1 '(0.18 0.74 0.26 0.82 0.35)
            :pan2 '(0.72 0.22 0.78 0.18 0.65))

  ;; ----------------------------------------------------------
  ;; III. Inner constellation: spectral activity, 2'30-7'20
  ;; ----------------------------------------------------------
  (cs-event "vco2pad1"
            :start (mystery-times 26 145 505)
            :dur (mystery-random-list 26 16 38)
            :amp (mystery-random-list 26 -32 -25)
            :freq (mystery-choice-list 26 *mystery-pitch-pool*)
            :atk (mystery-random-list 26 3 11)
            :rel (mystery-random-list 26 5 14)
            :detune (mystery-random-list 26 2 13)
            :bright (mystery-random-list 26 600 4200)
            :vibdepth (mystery-random-list 26 0.0002 0.0025)
            :vibrate (mystery-random-list 26 0.08 0.7)
            :submix (mystery-random-list 26 0.05 0.38)
            :pan1 *vco-pan1*
            :pan2 (mystery-pan-ends *vco-pan1*))

  (cs-event "analog1"
            :start (mystery-times 24 185 465)
            :dur (mystery-random-list 24 7 19)
            :amp (mystery-random-list 24 -34 -27)
            :freq (mystery-choice-list 24 *mystery-high-spectrum*)
            :wave (mystery-choice-list 24 '(0 0 0 2))
            :pw (mystery-random-list 24 0.18 0.72)
            :att (mystery-random-list 24 1.5 6)
            :hold (mystery-random-list 24 0 2)
            :dec (mystery-random-list 24 2 7)
            :sus (mystery-random-list 24 0.35 0.72)
            :rel (mystery-random-list 24 3 9)
            :cutoff (mystery-random-list 24 450 3600)
            :res (mystery-random-list 24 0.5 2.2)
            :filttype (mystery-choice-list 24 '(0 0 1))
            :pan1 (mystery-random-list 24 0.1 0.9)
            :pan2 (mystery-random-list 24 0.1 0.9))

  (cs-event "fm1"
            :start (mystery-times 34 205 455)
            :dur (mystery-random-list 34 3 11)
            :amp (mystery-random-list 34 -37 -29)
            :freq (mystery-choice-list 34 *mystery-high-spectrum*)
            :mod (mystery-choice-list 34 '(0.5 0.667 1.0 1.5 2.0 3.0))
            :index1 (mystery-random-list 34 0.15 4.5)
            :index2 (mystery-random-list 34 0.05 2.0)
            :rise (mystery-random-list 34 0.5 4.0)
            :dec (mystery-random-list 34 1.0 5.0)
            :pan1 (mystery-random-list 34 0.05 0.95)
            :pan2 (mystery-random-list 34 0.05 0.95))

  (cs-event "trombone"
            :start '(232 267 301 349 388 426)
            :dur '(19 24 17 28 21 26)
            :amp '(-32 -34 -31 -35 -33 -36)
            :note1 '(55 82 61 110 73 98)
            :note2 '(82 61 98 73 55 49))

  ;; ----------------------------------------------------------
  ;; IV. Frozen centre: fragmented mono voice and noise, 4'20-8'40
  ;; ----------------------------------------------------------
  (cs-event "mincer3"
            :start (append '(258 292 336)
                           (mystery-times 7 370 515))
            :dur (mystery-random-list 10 38 72)
            :file *voice-mono-file*
            :amp (mystery-random-list 10 -34 -25)
            :startpos (mystery-random-list 10 0 1.3)
            :speed (mystery-random-list 10 0.015 0.16)
            :pitch (mystery-choice-list 10 '(0.5 0.75 1.0 1.25 1.5))
            :lock 1
            :fftsize (mystery-choice-list 10 '(2048 4096))
            :decim 4
            :freeze (mystery-choice-list 10 '(0 0 1))
            :jitterdepth (mystery-random-list 10 0.0 0.12)
            :jitterrate (mystery-random-list 10 0.08 0.7)
            :looplen (mystery-random-list 10 0.25 1.2)
            :xfade (mystery-random-list 10 0.04 0.18)
            :att (mystery-random-list 10 6 16)
            :hold (mystery-random-list 10 0 4)
            :dec (mystery-random-list 10 5 13)
            :sus (mystery-random-list 10 0.45 0.8)
            :rel (mystery-random-list 10 8 18)
            :cutoff (mystery-random-list 10 550 5200)
            :res (mystery-random-list 10 0.1 0.65)
            :filttype (mystery-choice-list 10 '(0 1 2))
            :panmode (mystery-choice-list 10 '(0 1 2))
            :pan1 *ice-pan1*
            :pan2 (mystery-pan-ends *ice-pan1*)
            :panrate (mystery-random-list 10 0.015 0.09)
            :pandepth (mystery-random-list 10 0.2 0.75))

  (cs-event "noisesahenv"
            :start (append '(244 281 322)
                           (mystery-times 10 360 535))
            :dur (mystery-random-list 13 22 54)
            :amp (mystery-random-list 13 -42 -32)
            :pan1 *noise-pan1*
            :pan2 (mystery-pan-ends *noise-pan1*)
            :sustain (mystery-random-list 13 0.52 0.86)
            :center (mystery-random-list 13 0.3 0.7)
            :lpf1 (mystery-random-list 13 900 6800)
            :lpf2 (mystery-random-list 13 300 3200)
            :lpfq (mystery-random-list 13 1.0 3.5)
            :hpf1 (mystery-random-list 13 30 420)
            :hpf2 (mystery-random-list 13 80 900)
            :rate1lo (mystery-random-list 13 0.08 0.7)
            :rate1hi (mystery-random-list 13 1.0 7.0)
            :rate2lo (mystery-random-list 13 0.12 0.9)
            :rate2hi (mystery-random-list 13 1.5 9.0)
            :rate3 (mystery-random-list 13 0.04 0.4))

  ;; ----------------------------------------------------------
  ;; V. Distant bells and disappearance, 7'20-10'00
  ;; ----------------------------------------------------------
  (cs-event "samplerreverb"
            :start '(36 119 176 263 341 409 472 521 557 579)
            :dur '(12 15 11 18 14 19 13 17 12 10)
            :file *bell-file*
            :amp '(-31 -34 -35 -32 -36 -34 -37 -36 -39 -41)
            :pan1 '(0.18 0.78 0.31 0.66 0.12 0.84 0.42 0.73 0.24 0.58)
            :pan2 '(0.72 0.22 0.69 0.34 0.88 0.16 0.58 0.27 0.76 0.42)
            :skiptime 0
            :atk '(0.01)
            :rel '(4 5 3 7 5 8 5 7 6 8)
            :rvbtime '(3.5 4.2 5.1 4.6 6.0 5.4 6.8 7.2 8.0 9.0)
            :rvbgain '(0.28 0.32 0.36 0.4 0.44 0.48 0.52 0.56 0.6 0.64)))
 :play nil)

(when *render-mysterious-piece*
  (render-last-score :open t))

;;; Reset the deterministic material on reevaluation.
(setf *mystery-state* 140626)
