(in-package :opusmodus)

;;; -------------------------------------------------------
;;; INSTRUMENT LIBRARY FOR CSOUND FRAMEWORK
;;; -------------------------------------------------------

;;; -------------------------------------------------------
;;; Instruments adapted from the excellent AthenaCL
;;; from Christofer Ariza
;;; -------------------------------------------------------

;;; -------------------------------------------------------
;;; SINEDRONE
;;; -------------------------------------------------------

(defcsinstr sinedrone
  (:type :instrument)
  (:pfields amp midi pan1 pan2)
  (:outputs (leftout rightout))
  (:body
   "iSine = ftgenonce:i(0, 0, 4096, 10, 1)"
   "iPulse = ftgenonce:i(0, 0, 4096, 10, 1, 1, 1, 1, .7, .5, .3, .1)"
   "iDur = p3"
   "iAmp = ampdb(p4) * 5"
   "iFreq = mtof:i(p5)"
   "ipan1 = p6"
   "ipan2 = p7"
   "kPan = line:k(ipan1,p3,ipan2)"
   "k1 linen iAmp, (iDur * .18), iDur, (iDur * .19)"
   "irel = 1.00"
   "idel1 = iDur - (.25 * iDur)"
   "isus = iDur - (idel1 - irel)"
   "idep = 2"
   "irat = 1"
   "k3 linseg 0, idel1, idep, isus, idep, irel, 0"
   "k2 oscil k3, irat, iSine"
   "k4 oscil k3, (irat * .666), iPulse"
   "a1 poscil k1, (iFreq + k2), iSine"
   "a2 poscil (k1 * .8), ((iFreq * .5) + (k4 * .5)), iSine"
   "aMixSig = a1 + a2"
   "aSigL = aMixSig * cos(kPan * $M_PI_2)"
   "aSigR = aMixSig * sin(kPan * $M_PI_2)"
   "outleta \"leftout\", aSigL"
   "outleta \"rightout\", aSigR")
  (:doc "Sine drone borrowed from Christopher Ariza AthenaCL."))

;;; -------------------------------------------------------
;;; SINEUNITENVELOPE
;;; -------------------------------------------------------

(defcsinstr sineunitenvelope
  (:type :instrument)
  (:pfields amp midi pan1 pan2 suspcent suscenterpcent)
  (:outputs (leftout rightout))
  (:body
   "iSine = ftgenonce:i(0, 0, 4096, 10, 1)"
   "iDur = p3"
   "iAmp = ampdb(p4) * 5"
   "iFreq = mtof:i(p5)"
   "ipan1 = p6"
   "ipan2 = p7"
   "kPan = line:k(ipan1,p3,ipan2)"
   "iSusPcent = p8"
   "iSusCenterPcent = p9"
   "iAttack = ((1 - iSusPcent) * iSusCenterPcent) * iDur"
   "iRelease = ((1 - iSusPcent) * (1 - iSusCenterPcent)) * iDur"
   "kAmp linen iAmp, iAttack, iDur, iRelease"
   "aSig poscil kAmp, iFreq, iSine"
   "aMixSig = aSig"
   "aSigL = aMixSig * cos(kPan * $M_PI_2)"
   "aSigR = aMixSig * sin(kPan * $M_PI_2)"
   "outleta \"leftout\", aSigL"
   "outleta \"rightout\", aSigR")
  (:doc "Sine with unit-envelope style shaping."))

;;; -------------------------------------------------------
;;; SAWDRONE
;;; -------------------------------------------------------

(defcsinstr sawdrone
  (:type :instrument)
  (:pfields amp midi pan1 pan2)
  (:outputs (leftout rightout))
  (:body
   "iSine = ftgenonce:i(0, 0, 4096, 10, 1)"
   "iPulse = ftgenonce:i(0, 0, 4096, 10, 1, 1, 1, 1, .7, .5, .3, .1)"
   "iSaw = ftgenonce:i(0, 0, 4096, 10, 1, .5, .3, .25, .2, .167, .14, .125, .111)"
   "iDur = p3"
   "iAmp = ampdb(p4) * 5"
   "iFreq = mtof:i(p5)"
   "ipan1 = p6"
   "ipan2 = p7"
   "kPan = line:k(ipan1,p3,ipan2)"
   "k1 linen iAmp, (iDur * .18), iDur, (iDur * .19)"
   "irel = 1.00"
   "idel1 = iDur - (.25 * iDur)"
   "isus = iDur - (idel1 - irel)"
   "idep = 2"
   "irat = 1"
   "k3 linseg 0, idel1, idep, isus, idep, irel, 0"
   "k2 oscil k3, irat, iSine"
   "k4 oscil k3, (irat * .666), iPulse"
   "a1 poscil k1, (iFreq + k2), iSaw"
   "a2 poscil (k1 * .8), ((iFreq * .5) + (k4 * .5)), iSine"
   "aMixSig = a1 + a2"
   "aSigL = aMixSig * cos(kPan * $M_PI_2)"
   "aSigR = aMixSig * sin(kPan * $M_PI_2)"
   "outleta \"leftout\", aSigL"
   "outleta \"rightout\", aSigR")
  (:doc "Saw drone borrowed from Christopher Ariza AthenaCL."))

;;; -------------------------------------------------------
;;; SAWUNITENVELOPE
;;; -------------------------------------------------------

(defcsinstr sawunitenvelope
  (:type :instrument)
  (:pfields amp midi pan1 pan2 suspcent suscenterpcent)
  (:outputs (leftout rightout))
  (:body
   "iSaw = ftgenonce:i(0, 0, 4096, 10, 1, .5, .3, .25, .2, .167, .14, .125, .111)"
   "iDur = p3"
   "iAmp = ampdb(p4) * 5"
   "iFreq = mtof:i(p5)"
   "ipan1 = p6"
   "ipan2 = p7"
   "kPan = line:k(ipan1,p3,ipan2)"
   "iSusPcent = p8"
   "iSusCenterPcent = p9"
   "iAttack = ((1 - iSusPcent) * iSusCenterPcent) * iDur"
   "iRelease = ((1 - iSusPcent) * (1 - iSusCenterPcent)) * iDur"
   "kAmp linen iAmp, iAttack, iDur, iRelease"
   "aSig oscil kAmp, iFreq, iSaw"
   "aMixSig = aSig"
   "aSigL = aMixSig * cos(kPan * $M_PI_2)"
   "aSigR = aMixSig * sin(kPan * $M_PI_2)"
   "outleta \"leftout\", aSigL"
   "outleta \"rightout\", aSigR")
  (:doc "Saw with unit-envelope style shaping."))


;;; -------------------------------------------------------
;;; SAMPLERREVERB
;;; based on Inst30
;;; -------------------------------------------------------

(defcsinstr samplerreverb
  (:type :instrument)
  (:pfields file amp midi pan1 pan2 skiptime atk rel rvbtime rvbgain)
  (:outputs (leftout rightout))
  (:body
   "Sfile = p4"
   "iAmp = ampdb(p5)"
   "iMidi = p6"
   "iPan1 = p7"
   "iPan2 = p8"
   "iSkip = max(0, p9)"
   "iAtk = max(0.001, p10)"
   "iRel = max(0.001, p11)"
   "iRvbTime = max(0.01, p12)"
   "iRvbGain = max(0, p13)"

   "iNchnls filenchnls Sfile"
   "kAmp linen iAmp, iAtk, p3, iRel"
   "kPan line iPan1, p3, iPan2"

   "if (iNchnls == 1) then"
   "  aSig diskin2 Sfile, 1, iSkip, 0"
   "  aDry = aSig * kAmp"
   "  aRvb reverb aSig, iRvbTime"
   "  aMix = aDry + (aRvb * iRvbGain)"
   "  aL, aR pan2 aMix, kPan"
   "else"
   "  aL0, aR0 diskin2 Sfile, 1, iSkip, 0"
   "  aDryL = aL0 * kAmp"
   "  aDryR = aR0 * kAmp"
   "  aRvbL reverb aL0, iRvbTime"
   "  aRvbR reverb aR0, iRvbTime"
   "  aL1 = aDryL + (aRvbL * iRvbGain)"
   "  aR1 = aDryR + (aRvbR * iRvbGain)"
   "  aMid = (aL1 + aR1) * 0.5"
   "  aSide = (aL1 - aR1) * 0.5"
   "  aMonoL = aMid * cos(kPan * $M_PI_2)"
   "  aMonoR = aMid * sin(kPan * $M_PI_2)"
   "  aL = (aMonoL * 0.35) + ((aMid + aSide) * 0.65)"
   "  aR = (aMonoR * 0.35) + ((aMid - aSide) * 0.65)"
   "endif"

   "aL dcblock2 aL"
   "aR dcblock2 aR"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; SAMPLERRAW
;;; based on Inst31
;;; -------------------------------------------------------

(defcsinstr samplerraw
  (:type :instrument)
  (:pfields file amp midi pan1 pan2)
  (:outputs (leftout rightout))
  (:body
   "Sfile = p4"
   "iAmp = ampdb(p5)"
   "iMidi = p6"
   "iPan1 = p7"
   "iPan2 = p8"

   "iNchnls filenchnls Sfile"
   "kAmp linen iAmp, 0.001, p3, 0.001"
   "kPan line iPan1, p3, iPan2"

   "if (iNchnls == 1) then"
   "  aSig diskin2 Sfile, 1, 0, 0"
   "  aSig = aSig * kAmp"
   "  aL, aR pan2 aSig, kPan"
   "else"
   "  aL0, aR0 diskin2 Sfile, 1, 0, 0"
   "  aL0 = aL0 * kAmp"
   "  aR0 = aR0 * kAmp"
   "  aMid = (aL0 + aR0) * 0.5"
   "  aSide = (aL0 - aR0) * 0.5"
   "  aMonoL = aMid * cos(kPan * $M_PI_2)"
   "  aMonoR = aMid * sin(kPan * $M_PI_2)"
   "  aL = (aMonoL * 0.35) + ((aMid + aSide) * 0.65)"
   "  aR = (aMonoR * 0.35) + ((aMid - aSide) * 0.65)"
   "endif"

   "aL dcblock2 aL"
   "aR dcblock2 aR"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; SAMPLERUNITENV
;;; based on Inst32
;;; -------------------------------------------------------

(defcsinstr samplerunitenv
  (:type :instrument)
  (:pfields file amp midi pan1 pan2 sustain center cutoff1 cutoff2 q skiptime)
  (:outputs (leftout rightout))
  (:body
   "Sfile = p4"
   "iAmp = ampdb(p5)"
   "iMidi = p6"
   "iPan1 = p7"
   "iPan2 = p8"
   "iSus = min(0.999, max(0.0, p9))"
   "iCenter = min(0.999, max(0.001, p10))"
   "iCut1 = max(20, p11)"
   "iCut2 = max(20, p12)"
   "iQ = max(1, p13)"
   "iSkip = max(0, p14)"

   "iNchnls filenchnls Sfile"
   "iAttack = ((1 - iSus) * iCenter) * p3"
   "iRelease = ((1 - iSus) * (1 - iCenter)) * p3"

   "kAmp linen iAmp, iAttack, p3, iRelease"
   "kCut linseg iCut1, p3, iCut2"
   "kPan line iPan1, p3, iPan2"

   "if (iNchnls == 1) then"
   "  aSig diskin2 Sfile, 1, iSkip, 0"
   "  aSig lowpass2 aSig, kCut, iQ"
   "  aSig = aSig * kAmp"
   "  aL, aR pan2 aSig, kPan"
   "else"
   "  aL0, aR0 diskin2 Sfile, 1, iSkip, 0"
   "  aL0 lowpass2 aL0, kCut, iQ"
   "  aR0 lowpass2 aR0, kCut, iQ"
   "  aL0 = aL0 * kAmp"
   "  aR0 = aR0 * kAmp"
   "  aMid = (aL0 + aR0) * 0.5"
   "  aSide = (aL0 - aR0) * 0.5"
   "  aMonoL = aMid * cos(kPan * $M_PI_2)"
   "  aMonoR = aMid * sin(kPan * $M_PI_2)"
   "  aL = (aMonoL * 0.35) + ((aMid + aSide) * 0.65)"
   "  aR = (aMonoR * 0.35) + ((aMid - aSide) * 0.65)"
   "endif"

   "aL dcblock2 aL"
   "aR dcblock2 aR"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; SAMPLERUNITENVBP
;;; based on Inst33
;;; -------------------------------------------------------

(defcsinstr samplerunitenvbp
  (:type :instrument)
  (:pfields file amp midi pan1 pan2 sustain center cf1 cf2 bw1 bw2 skiptime)
  (:outputs (leftout rightout))
  (:body
   "Sfile = p4"
   "iAmp = ampdb(p5)"
   "iMidi = p6"
   "iPan1 = p7"
   "iPan2 = p8"
   "iSus = min(0.999, max(0.0, p9))"
   "iCenter = min(0.999, max(0.001, p10))"
   "iCf1 = max(20, p11)"
   "iCf2 = max(20, p12)"
   "iBw1 = max(1, p13)"
   "iBw2 = max(1, p14)"
   "iSkip = max(0, p15)"

   "iNchnls filenchnls Sfile"
   "iAttack = ((1 - iSus) * iCenter) * p3"
   "iRelease = ((1 - iSus) * (1 - iCenter)) * p3"

   "kAmp linen iAmp, iAttack, p3, iRelease"
   "kCf linseg iCf1, p3, iCf2"
   "kBw linseg iBw1, p3, iBw2"
   "kPan line iPan1, p3, iPan2"

   "if (iNchnls == 1) then"
   "  aSig diskin2 Sfile, 1, iSkip, 0"
   "  aSig butterbp aSig, kCf, kBw"
   "  aSig = aSig * kAmp"
   "  aL, aR pan2 aSig, kPan"
   "else"
   "  aL0, aR0 diskin2 Sfile, 1, iSkip, 0"
   "  aL0 butterbp aL0, kCf, kBw"
   "  aR0 butterbp aR0, kCf, kBw"
   "  aL0 = aL0 * kAmp"
   "  aR0 = aR0 * kAmp"
   "  aMid = (aL0 + aR0) * 0.5"
   "  aSide = (aL0 - aR0) * 0.5"
   "  aMonoL = aMid * cos(kPan * $M_PI_2)"
   "  aMonoR = aMid * sin(kPan * $M_PI_2)"
   "  aL = (aMonoL * 0.35) + ((aMid + aSide) * 0.65)"
   "  aR = (aMonoR * 0.35) + ((aMid - aSide) * 0.65)"
   "endif"

   "aL dcblock2 aL"
   "aR dcblock2 aR"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; SAMPLERUNITENVDIST
;;; based on Inst34
;;; -------------------------------------------------------

(defcsinstr samplerunitenvdist
  (:type :instrument)
  (:pfields file amp midi pan1 pan2 sustain center distin distout curvepos curveneg lpf1 lpf2 lpfq skiptime)
  (:outputs (leftout rightout))
  (:body
   "Sfile = p4"
   "iAmp = ampdb(p5)"
   "iMidi = p6"
   "iPan1 = p7"
   "iPan2 = p8"
   "iSus = min(0.999, max(0.0, p9))"
   "iCenter = min(0.999, max(0.001, p10))"
   "iDistIn = max(0, p11)"
   "iDistOut = max(0, p12)"
   "iCurvePos = p13"
   "iCurveNeg = p14"
   "iLpf1 = max(20, p15)"
   "iLpf2 = max(20, p16)"
   "iLpfQ = max(1, p17)"
   "iSkip = max(0, p18)"

   "iNchnls filenchnls Sfile"
   "iAttack = ((1 - iSus) * iCenter) * p3"
   "iRelease = ((1 - iSus) * (1 - iCenter)) * p3"

   "kAmp linen iAmp, iAttack, p3, iRelease"
   "kCut linseg iLpf1, p3, iLpf2"
   "kPan line iPan1, p3, iPan2"

   "if (iNchnls == 1) then"
   "  aSig diskin2 Sfile, 1, iSkip, 0"
   "  aSig distort1 aSig, iDistIn, iDistOut, iCurvePos, iCurveNeg"
   "  aSig lowpass2 aSig, kCut, iLpfQ"
   "  aSig = aSig * kAmp"
   "  aL, aR pan2 aSig, kPan"
   "else"
   "  aL0, aR0 diskin2 Sfile, 1, iSkip, 0"
   "  aL0 distort1 aL0, iDistIn, iDistOut, iCurvePos, iCurveNeg"
   "  aR0 distort1 aR0, iDistIn, iDistOut, iCurvePos, iCurveNeg"
   "  aL0 lowpass2 aL0, kCut, iLpfQ"
   "  aR0 lowpass2 aR0, kCut, iLpfQ"
   "  aL0 = aL0 * kAmp"
   "  aR0 = aR0 * kAmp"
   "  aMid = (aL0 + aR0) * 0.5"
   "  aSide = (aL0 - aR0) * 0.5"
   "  aMonoL = aMid * cos(kPan * $M_PI_2)"
   "  aMonoR = aMid * sin(kPan * $M_PI_2)"
   "  aL = (aMonoL * 0.35) + ((aMid + aSide) * 0.65)"
   "  aR = (aMonoR * 0.35) + ((aMid - aSide) * 0.65)"
   "endif"

   "aL dcblock2 aL"
   "aR dcblock2 aR"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; SAMPLERUNITENVPEQ
;;; based on Inst35
;;; -------------------------------------------------------

(defcsinstr samplerunitenvpeq
  (:type :instrument)
  (:pfields file amp midi pan1 pan2 sustain center cf1 cf2 q1 q2 gain1 gain2 filtertype skiptime)
  (:outputs (leftout rightout))
  (:body
   "Sfile = p4"
   "iAmp = ampdb(p5)"
   "iMidi = p6"
   "iPan1 = p7"
   "iPan2 = p8"
   "iSus = min(0.999, max(0.0, p9))"
   "iCenter = min(0.999, max(0.001, p10))"
   "iCf1 = max(20, p11)"
   "iCf2 = max(20, p12)"
   "iQ1 = max(0.001, p13)"
   "iQ2 = max(0.001, p14)"
   "iGain1 = max(0.0001, p15)"
   "iGain2 = max(0.0001, p16)"
   "iType = i(p17)"
   "iSkip = max(0, p18)"

   "iNchnls filenchnls Sfile"
   "iAttack = ((1 - iSus) * iCenter) * p3"
   "iRelease = ((1 - iSus) * (1 - iCenter)) * p3"

   "kAmp linen iAmp, iAttack, p3, iRelease"
   "kCf linseg iCf1, p3, iCf2"
   "kQ linseg iQ1, p3, iQ2"
   "kGain linseg iGain1, p3, iGain2"
   "kPan line iPan1, p3, iPan2"

   "if (iNchnls == 1) then"
   "  aSig diskin2 Sfile, 1, iSkip, 0"
   "  aSig pareq aSig, kCf, kGain, kQ, iType"
   "  aSig = aSig * kAmp"
   "  aL, aR pan2 aSig, kPan"
   "else"
   "  aL0, aR0 diskin2 Sfile, 1, iSkip, 0"
   "  aL0 pareq aL0, kCf, kGain, kQ, iType"
   "  aR0 pareq aR0, kCf, kGain, kQ, iType"
   "  aL0 = aL0 * kAmp"
   "  aR0 = aR0 * kAmp"
   "  aMid = (aL0 + aR0) * 0.5"
   "  aSide = (aL0 - aR0) * 0.5"
   "  aMonoL = aMid * cos(kPan * $M_PI_2)"
   "  aMonoR = aMid * sin(kPan * $M_PI_2)"
   "  aL = (aMonoL * 0.35) + ((aMid + aSide) * 0.65)"
   "  aR = (aMonoR * 0.35) + ((aMid - aSide) * 0.65)"
   "endif"

   "aL dcblock2 aL"
   "aR dcblock2 aR"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; SAMPLERSAHENV
;;; based on Inst36
;;; -------------------------------------------------------

(defcsinstr samplersahenv
  (:type :instrument)
  (:pfields file amp midi pan1 pan2 sustain center lpf1 lpf2 lpfq skiptime hpf1 hpf2 rate1lo rate1hi rate2lo rate2hi rate3)
  (:globals
   "giBipolarPhasor ftgen 15, 0, 8192, 7, -1, 8192, 1")
  (:outputs (leftout rightout))
  (:body
   "Sfile = p4"
   "iAmp = ampdb(p5)"
   "iMidi = p6"
   "iPan1 = p7"
   "iPan2 = p8"
   "iSus = min(0.999, max(0.0, p9))"
   "iCenter = min(0.999, max(0.001, p10))"
   "iLpf1 = max(20, p11)"
   "iLpf2 = max(20, p12)"
   "iLpfQ = max(1, p13)"
   "iSkip = max(0, p14)"
   "iHpf1 = max(20, p15)"
   "iHpf2 = max(20, p16)"
   "iR1Lo = max(0.001, p17)"
   "iR1Hi = max(iR1Lo, p18)"
   "iR2Lo = max(0.001, p19)"
   "iR2Hi = max(iR2Lo, p20)"
   "iR3 = max(0.001, p21)"

   "iNchnls filenchnls Sfile"
   "iAttack = ((1 - iSus) * iCenter) * p3"
   "iRelease = ((1 - iSus) * (1 - iCenter)) * p3"

   "kAmp linen iAmp, iAttack, p3, iRelease"
   "kLpf linseg iLpf1, p3, iLpf2"
   "kHpf linseg iHpf1, p3, iHpf2"
   "kPan line iPan1, p3, iPan2"

   "aNoise1 random iR1Lo, iR1Hi"
   "aNoise2 random iR2Lo, iR2Hi"
   "aGateC oscili 1, iR3, giBipolarPhasor"
   "aRateB samphold aNoise2, aGateC"
   "aGateB oscili 1, aRateB, giBipolarPhasor"
   "aRateA samphold aNoise1, aGateB"
   "aGateA oscili 1, aRateA, giBipolarPhasor"

   "if (iNchnls == 1) then"
   "  aSrc diskin2 Sfile, 1, iSkip, 0"
   "  aSig samphold aSrc, aGateA"
   "  aSig butterhp aSig, kHpf"
   "  aSig lowpass2 aSig, kLpf, iLpfQ"
   "  aSig = aSig * kAmp"
   "  aL, aR pan2 aSig, kPan"
   "else"
   "  aSrcL, aSrcR diskin2 Sfile, 1, iSkip, 0"
   "  aL0 samphold aSrcL, aGateA"
   "  aR0 samphold aSrcR, aGateA"
   "  aL0 butterhp aL0, kHpf"
   "  aR0 butterhp aR0, kHpf"
   "  aL0 lowpass2 aL0, kLpf, iLpfQ"
   "  aR0 lowpass2 aR0, kLpf, iLpfQ"
   "  aL0 = aL0 * kAmp"
   "  aR0 = aR0 * kAmp"
   "  aMid = (aL0 + aR0) * 0.5"
   "  aSide = (aL0 - aR0) * 0.5"
   "  aMonoL = aMid * cos(kPan * $M_PI_2)"
   "  aMonoR = aMid * sin(kPan * $M_PI_2)"
   "  aL = (aMonoL * 0.35) + ((aMid + aSide) * 0.65)"
   "  aR = (aMonoR * 0.35) + ((aMid - aSide) * 0.65)"
   "endif"

   "aL dcblock2 aL"
   "aR dcblock2 aR"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; SAMPLERCROSSENV
;;; based on Inst37
;;; -------------------------------------------------------

(defcsinstr samplercrossenv
  (:type :instrument)
  (:pfields filea fileb amp midi pan1 pan2 sustain center lpf1 lpf2 lpfq skipa skipb fftsize bias1 bias2)
  (:globals
   "giCrossHamming ftgen 14, 0, 4096, 20, 2, 1")
  (:outputs (leftout rightout))
  (:body
   "SfileA = p4"
   "SfileB = p5"
   "iAmp = ampdb(p6)"
   "iMidi = p7"
   "iPan1 = p8"
   "iPan2 = p9"
   "iSus = min(0.999, max(0.0, p10))"
   "iCenter = min(0.999, max(0.001, p11))"
   "iLpf1 = max(20, p12)"
   "iLpf2 = max(20, p13)"
   "iLpfQ = max(1, p14)"
   "iSkipA = max(0, p15)"
   "iSkipB = max(0, p16)"
   "iSize = i(p17)"
   "iBias1 = max(0, min(1, p18))"
   "iBias2 = max(0, min(1, p19))"

   "iNchnlsA filenchnls SfileA"
   "iNchnlsB filenchnls SfileB"
   "iAttack = ((1 - iSus) * iCenter) * p3"
   "iRelease = ((1 - iSus) * (1 - iCenter)) * p3"

   "kAmp linen iAmp, iAttack, p3, iRelease"
   "kLpf linseg iLpf1, p3, iLpf2"
   "kBias linseg iBias1, p3, iBias2"
   "kPan line iPan1, p3, iPan2"

   "if (iNchnlsA == 1) then"
   "  aA diskin2 SfileA, 1, iSkipA, 0"
   "else"
   "  aAL, aAR diskin2 SfileA, 1, iSkipA, 0"
   "  aA = (aAL + aAR) * 0.5"
   "endif"

   "if (iNchnlsB == 1) then"
   "  aB diskin2 SfileB, 1, iSkipB, 0"
   "else"
   "  aBL, aBR diskin2 SfileB, 1, iSkipB, 0"
   "  aB = (aBL + aBR) * 0.5"
   "endif"

   "aSig cross2 aA, aB, iSize, 2, giCrossHamming, kBias"
   "aSig lowpass2 aSig, kLpf, iLpfQ"
   "aSig = aSig * kAmp"
   "aL, aR pan2 aSig, kPan"

   "aL dcblock2 aL"
   "aR dcblock2 aR"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))


;;; -------------------------------------------------------
;;; NOISEWHITE
;;; -------------------------------------------------------

(defcsinstr noisewhite
  (:type :instrument)
  (:pfields amp midi pan1 pan2)
  (:outputs (leftout rightout))
  (:body
   "iAmp = ampdb(p4)"
   "iMidi = p5"
   "iPan1 = p6"
   "iPan2 = p7"

   "kEnv linen iAmp, 0.1, p3, 0.1"
   "kPan line iPan1, p3, iPan2"

   "aN random -1, 1"
   "aSig = aN * kEnv"
   "aL, aR pan2 aSig, kPan"

   "aL dcblock2 aL"
   "aR dcblock2 aR"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; NOISEPITCHED
;;; -------------------------------------------------------

(defcsinstr noispitched
  (:type :instrument)
  (:pfields amp midi pan1 pan2 cf bw)
  (:outputs (leftout rightout))
  (:body
   "iAmp = ampdb(p4)"
   "iMidi = p5"
   "iPan1 = p6"
   "iPan2 = p7"
   "iCf = max(20, p8)"
   "iBw = max(1, p9)"

   "kEnv linen iAmp, (p3 * 0.9), p3, (p3 * 0.1)"
   "kPan line iPan1, p3, iPan2"

   "aN random -1, 1"
   "aSig reson (aN * kEnv), iCf, iBw, 1"
   "aL, aR pan2 aSig, kPan"

   "aL dcblock2 aL"
   "aR dcblock2 aR"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; NOISEUNITENV
;;; -------------------------------------------------------

(defcsinstr noiseunitenv
  (:type :instrument)
  (:pfields amp midi pan1 pan2 sustain center cutoff1 cutoff2 q)
  (:outputs (leftout rightout))
  (:body
   "iDur = p3"
   "iAmp = ampdb(p4)"
   "iMidi = p5"
   "iPan1 = p6"
   "iPan2 = p7"
   "iSus = min(0.999, max(0.0, p8))"
   "iCenter = min(0.999, max(0.001, p9))"
   "iCut1 = max(20, p10)"
   "iCut2 = max(20, p11)"
   "kQ = max(1, p12)"

   "iAttack = ((1 - iSus) * iCenter) * iDur"
   "iRelease = ((1 - iSus) * (1 - iCenter)) * iDur"

   "kAmp linen iAmp, iAttack, iDur, iRelease"
   "kCut linseg iCut1, iDur, iCut2"
   "kPan line iPan1, p3, iPan2"

   "aN random -1, 1"
   "aSig lowpass2 aN, kCut, kQ"
   "aSig = aSig * kAmp"
   "aL, aR pan2 aSig, kPan"

   "aL dcblock2 aL"
   "aR dcblock2 aR"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; NOISETAMBOURINE
;;; -------------------------------------------------------

(defcsinstr noisetambourine
  (:type :instrument)
  (:pfields amp midi pan1 pan2)
  (:outputs (leftout rightout))
  (:body
   "iAmp = ampdb(p4)"
   "iMidi = p5"
   "iPan1 = p6"
   "iPan2 = p7"

   "kPan line iPan1, p3, iPan2"
   "aEnv expon 1, min(0.1, p3), 0.0001"

   "a1 rnd31 0.3, 0, 0"
   "a2 rnd31 1.0, 0, 0"
   "a3 rnd31 0.3, 0, 0"
   "a4 rnd31 1.0, 0, 0"

   "a1 butterbp a1, 7500, 1000"
   "a1 butterbp a1, 7500, 400"
   "a2 butterbp a2, 10500, 1000"
   "a2 butterbp a2, 10500, 400"
   "a3 butterbp a3, 14000, 1000"
   "a3 butterbp a3, 14000, 400"
   "a4 butterbp a4, 18000, 1000"
   "a4 butterbp a4, 18000, 400"

   "aSig = (a1 + a2 + a3 + a4) * aEnv * iAmp"
   "aL, aR pan2 aSig, kPan"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; NOISEUNITENVBP
;;; -------------------------------------------------------

(defcsinstr noiseunitenvbp
  (:type :instrument)
  (:pfields amp midi pan1 pan2 sustain center cf1 cf2 bw1 bw2)
  (:outputs (leftout rightout))
  (:body
   "iDur = p3"
   "iAmp = ampdb(p4)"
   "iMidi = p5"
   "iPan1 = p6"
   "iPan2 = p7"
   "iSus = min(0.999, max(0.0, p8))"
   "iCenter = min(0.999, max(0.001, p9))"
   "iCf1 = max(20, p10)"
   "iCf2 = max(20, p11)"
   "iBw1 = max(1, p12)"
   "iBw2 = max(1, p13)"

   "iAttack = ((1 - iSus) * iCenter) * iDur"
   "iRelease = ((1 - iSus) * (1 - iCenter)) * iDur"

   "kAmp linen iAmp, iAttack, iDur, iRelease"
   "kCf linseg iCf1, iDur, iCf2"
   "kBw linseg iBw1, iDur, iBw2"
   "kPan line iPan1, p3, iPan2"

   "aN random -1, 1"
   "aSig butterbp aN, kCf, kBw"
   "aSig = aSig * kAmp"
   "aL, aR pan2 aSig, kPan"

   "aL dcblock2 aL"
   "aR dcblock2 aR"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; NOISESAHENV
;;; -------------------------------------------------------

(defcsinstr noisesahenv
  (:type :instrument)
  (:pfields amp midi pan1 pan2 sustain center lpf1 lpf2 lpfq hpf1 hpf2 rate1lo rate1hi rate2lo rate2hi rate3)
  (:globals
   "giBipolarPhasor ftgen 15, 0, 8192, 7, -1, 8192, 1")
  (:outputs (leftout rightout))
  (:body
   "iDur = p3"
   "iAmp = ampdb(p4)"
   "iMidi = p5"
   "iPan1 = p6"
   "iPan2 = p7"

   "iSus = min(0.999, max(0.0, p8))"
   "iCenter = min(0.999, max(0.001, p9))"
   "iLpf1 = max(20, p10)"
   "iLpf2 = max(20, p11)"
   "iLpfQ = max(1, p12)"
   "iHpf1 = max(20, p13)"
   "iHpf2 = max(20, p14)"
   "iR1Lo = max(0.001, p15)"
   "iR1Hi = max(iR1Lo, p16)"
   "iR2Lo = max(0.001, p17)"
   "iR2Hi = max(iR2Lo, p18)"
   "iR3 = max(0.001, p19)"

   "iAttack = ((1 - iSus) * iCenter) * iDur"
   "iRelease = ((1 - iSus) * (1 - iCenter)) * iDur"

   "kAmp linen iAmp, iAttack, iDur, iRelease"
   "kLpf linseg iLpf1, iDur, iLpf2"
   "kHpf linseg iHpf1, iDur, iHpf2"
   "kPan line iPan1, p3, iPan2"

   "aSigSrc random -1, 1"
   "aNoise1 random iR1Lo, iR1Hi"
   "aNoise2 random iR2Lo, iR2Hi"

   "aGateC oscili 1, iR3, giBipolarPhasor"
   "aRateB samphold aNoise2, aGateC"

   "aGateB oscili 1, aRateB, giBipolarPhasor"
   "aRateA samphold aNoise1, aGateB"

   "aGateA oscili 1, aRateA, giBipolarPhasor"
   "aSig samphold aSigSrc, aGateA"

   "aSig butterhp aSig, kHpf"
   "aSig lowpass2 aSig, kLpf, iLpfQ"
   "aSig = aSig * kAmp"

   "aL, aR pan2 aSig, kPan"

   "aL dcblock2 aL"
   "aR dcblock2 aR"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; NOISESAHENVDIST
;;; -------------------------------------------------------

(defcsinstr noisesahenvdist
  (:type :instrument)
  (:pfields amp midi pan1 pan2 sustain center lpf1 lpf2 lpfq hpf1 hpf2 rate1lo rate1hi rate2lo rate2hi rate3 rescf1 rescf2 res1 res2 dist1 dist2)
  (:globals
   "giBipolarPhasor ftgen 15, 0, 8192, 7, -1, 8192, 1")
  (:outputs (leftout rightout))
  (:body
   "iDur = p3"
   "iAmp = ampdb(p4)"
   "iMidi = p5"
   "iPan1 = p6"
   "iPan2 = p7"

   "iSus = min(0.999, max(0.0, p8))"
   "iCenter = min(0.999, max(0.001, p9))"
   "iLpf1 = max(20, p10)"
   "iLpf2 = max(20, p11)"
   "iLpfQ = max(1, p12)"
   "iHpf1 = max(20, p13)"
   "iHpf2 = max(20, p14)"
   "iR1Lo = max(0.001, p15)"
   "iR1Hi = max(iR1Lo, p16)"
   "iR2Lo = max(0.001, p17)"
   "iR2Hi = max(iR2Lo, p18)"
   "iR3 = max(0.001, p19)"
   "iResCf1 = max(20, p20)"
   "iResCf2 = max(20, p21)"
   "iRes1 = max(0, min(2, p22))"
   "iRes2 = max(0, min(2, p23))"
   "iDist1 = max(0, p24)"
   "iDist2 = max(0, p25)"

   "iAttack = ((1 - iSus) * iCenter) * iDur"
   "iRelease = ((1 - iSus) * (1 - iCenter)) * iDur"

   "kAmp linen iAmp, iAttack, iDur, iRelease"
   "kLpf linseg iLpf1, iDur, iLpf2"
   "kHpf linseg iHpf1, iDur, iHpf2"
   "kResCf linseg iResCf1, iDur, iResCf2"
   "kRes linseg iRes1, iDur, iRes2"
   "kDist linseg iDist1, iDur, iDist2"
   "kPan line iPan1, p3, iPan2"

   "aSigSrc random -1, 1"
   "aNoise1 random iR1Lo, iR1Hi"
   "aNoise2 random iR2Lo, iR2Hi"

   "aGateC oscili 1, iR3, giBipolarPhasor"
   "aRateB samphold aNoise2, aGateC"

   "aGateB oscili 1, aRateB, giBipolarPhasor"
   "aRateA samphold aNoise1, aGateB"

   "aGateA oscili 1, aRateA, giBipolarPhasor"
   "aSig samphold aSigSrc, aGateA"

   "aSig butterhp aSig, kHpf"
   "aSig lowpass2 aSig, kLpf, iLpfQ"
   "aSig = aSig * 0.99999"
   "aSig lpf18 aSig, kResCf, kRes, kDist"
   "aSig = aSig * kAmp"

   "aL, aR pan2 aSig, kPan"

   "aL dcblock2 aL"
   "aR dcblock2 aR"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; FMBASIC
;;; -------------------------------------------------------

(defcsinstr fmbasic
  (:type :instrument)
  (:pfields amp midi pan1 pan2 factor index)
  (:globals
   "giFmSine ftgen 201, 0, 8192, 10, 1"
   "giFmSine2 ftgen 203, 0, 8192, 10, 1")
  (:outputs (leftout rightout))
  (:body
   "iAmp = ampdb(p4)"
   "iFreq = mtof:i(p5)"
   "iPan1 = p6"
   "iPan2 = p7"
   "iFactor = max(0.001, p8)"
   "iIndex = max(0, p9)"

   "iEnvFreq = 1 / p3"
   "iModFreq = iFreq * iFactor"
   "iDev = iModFreq * iIndex"

   "kPan line iPan1, p3, iPan2"

   "aAmpEnv oscili iAmp, iEnvFreq, giFmSine"
   "aDevEnv oscili iDev, iEnvFreq, giFmSine"
   "aMod oscili aDevEnv, iModFreq, giFmSine2"
   "aSig oscili aAmpEnv, iFreq + aMod, giFmSine2"

   "aL, aR pan2 aSig, kPan"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; FMCLARINET
;;; -------------------------------------------------------

(defcsinstr fmclarinet
  (:type :instrument)
  (:pfields amp midi pan1 pan2 imax)
  (:globals
   "giFmCore ftgen 210, 0, 8192, 10, 1"
   "giClarAmp ftgen 211, 0, 8192, 7, 0, 512, 1, 6144, 0.7, 1536, 0"
   "giClarDyn ftgen 212, 0, 8192, 7, 0, 1024, 1, 4096, 0.6, 3072, 0")
  (:outputs (leftout rightout))
  (:body
   "iDur = p3"
   "iAmp = ampdb(p4)"
   "iFreq = mtof:i(p5)"
   "iPan1 = p6"
   "iPan2 = p7"
   "iMax = max(0, p8)"
   "iMin = 2"

   "iFq1 = iFreq * 3"
   "iFq2 = iFreq * 2"

   "kPan line iPan1, p3, iPan2"

   "aEnv oscili iAmp, 1 / iDur, giClarAmp"
   "aDyn oscili iFq2 * (iMax - iMin), 1 / iDur, giClarDyn"
   "aDyn = (iFq2 * iMin) + aDyn"
   "aMod oscili aDyn, iFq2, giFmCore"
   "aSig oscili aEnv, iFq1 + aMod, giFmCore"

   "aL, aR pan2 aSig, kPan"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; FMWOODDRUM
;;; -------------------------------------------------------

(defcsinstr fmwooddrum
  (:type :instrument)
  (:pfields amp midi pan1 pan2)
  (:globals
   "giFmCore ftgen 210, 0, 8192, 10, 1"
   "giWoodAmp ftgen 251, 0, 8192, 7, 0, 128, 1, 256, 0.8, 7808, 0"
   "giWoodDyn ftgen 231, 0, 8192, 7, 1, 2048, 0.5, 6144, 0")
  (:outputs (leftout rightout))
  (:body
   "iDur = p3"
   "iAmp = ampdb(p4)"
   "iFreq = mtof:i(p5)"
   "iPan1 = p6"
   "iPan2 = p7"

   "iFq1 = iFreq * 16"
   "iFq2 = iFreq * 11"
   "iMax = 25"

   "kPan line iPan1, p3, iPan2"

   "aEnv oscili iAmp, 1 / iDur, giWoodAmp"
   "aDyn oscili iFq2 * iMax, 1 / iDur, giWoodDyn"
   "aMod oscili aDyn, iFq2, giFmCore"
   "aSig oscili aEnv, iFq1 + aMod, giFmCore"

   "aL, aR pan2 aSig, kPan"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; FMSTRING
;;; -------------------------------------------------------

(defcsinstr fmstring
  (:type :instrument)
  (:pfields amp midi pan1 pan2 rise dec vibdel vibwth vibrate)
  (:globals
   "giFmCore ftgen 210, 0, 8192, 10, 1"
   "giVib ftgen 1, 0, 8192, 10, 1")
  (:outputs (leftout rightout))
  (:body
   "iDur = p3"
   "iAmp = ampdb(p4)"
   "iFreq = mtof:i(p5)"
   "iPan1 = p6"
   "iPan2 = p7"
   "iRise = max(0.001, p8)"
   "iDec = max(0.001, p9)"
   "iVibDel = max(0, p10)"
   "iVibWth = max(0, p11)"
   "iVibRate = max(0.01, p12)"

   "iFm1 = iFreq"
   "iFm2 = iFreq * 3"
   "iFm3 = iFreq * 4"

   "iInd1 = 7.5 / log(max(iFreq, 2))"
   "iInd2 = 15 / sqrt(max(iFreq, 2))"
   "iInd3 = 1.25 / sqrt(max(iFreq, 2))"
   "iNoiseDur = min(0.1, p3 * 0.5)"

   "kPan line iPan1, p3, iPan2"
   "kVib init 0"

   "timout 0, iVibDel, transient"
   "kVibCtl linen 1, 0.5, max(0.01, iDur - iVibDel), 0.1"
   "kRnd randi 0.0075, 2"
   "kVib oscili (kVibCtl * iVibWth) + kRnd, iVibRate * max(kVibCtl, 0.001), giVib"

   "transient:"
   "timout iNoiseDur, p3, continue"
   "kTrans linseg 1, iNoiseDur, 0, 1, 0"
   "aNoise randi kTrans * iAmp / 4, 0.2 * iFreq"
   "aAttack oscili aNoise, 2000, giVib"

   "continue:"
   "aMod1 oscili iFm1 * (iInd1 + kTrans), iFm1, giFmCore"
   "aMod2 oscili iFm2 * (iInd2 + kTrans), iFm2, giFmCore"
   "aMod3 oscili iFm3 * (iInd3 + kTrans), iFm3, giFmCore"
   "aSig oscili iAmp, (iFreq + aMod1 + aMod2 + aMod3) * (1 + kVib), giFmCore"
   "aSig linen (aSig + aAttack), iRise, iDur, iDec"

   "aL, aR pan2 aSig, kPan"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))


;;; -------------------------------------------------------
;;; VOCODENOISESINGLE
;;; -------------------------------------------------------

(defcsinstr vocodenoisesingle
  (:type :instrument)
  (:pfields file amp midi pan1 pan2 sustain center skiptime analysiscutoff bw analysiscf gencf)
  (:outputs (leftout rightout))
  (:body
   "Sfile = p4"
   "iAmp = ampdb(p5)"
   "iMidi = p6"
   "iPan1 = p7"
   "iPan2 = p8"
   "iSus = min(0.999, max(0.0, p9))"
   "iCenter = min(0.999, max(0.001, p10))"
   "iSkip = max(0, p11)"
   "iAnalysisCutoff = max(1, p12)"
   "iBw = max(10, p13)"
   "iAnalysisCf = max(20, p14)"
   "iGenCf = max(20, p15)"
   "iAttack = ((1 - iSus) * iCenter) * p3"
   "iRelease = ((1 - iSus) * (1 - iCenter)) * p3"

   "iNchnls filenchnls Sfile"
   "kAmp linen iAmp, iAttack, p3, iRelease"
   "kPan line iPan1, p3, iPan2"
   "aNoise random -1, 1"

   "if (iNchnls == 1) then"
   "  aSrc diskin2 Sfile, 1, iSkip, 0"
   "else"
   "  aLsrc, aRsrc diskin2 Sfile, 1, iSkip, 0"
   "  aSrc = (aLsrc + aRsrc) * 0.5"
   "endif"

   "aAmpCh butterbp aSrc, iAnalysisCf, iBw"
   "aAmpCh = abs(aAmpCh)"
   "aAmpCh butterlp aAmpCh, iAnalysisCutoff"
   "aAmpCh = aAmpCh * 100"
   "aAmpCh tone aAmpCh, iAnalysisCutoff"

   "aGen butterbp aNoise, iGenCf, iBw"
   "aSig = aGen * aAmpCh"
   "aSig = aSig * 2.5"
   "aSig = tanh(aSig) * kAmp"

   "aL, aR pan2 aSig, kPan"
   "aL dcblock2 aL"
   "aR dcblock2 aR"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; VOCODENOISESINGLEGLISS
;;; -------------------------------------------------------

(defcsinstr vocodenoisesinglegliss
  (:type :instrument)
  (:pfields file amp midi pan1 pan2 sustain center skiptime analysiscutoff bw analysiscf gencf1 gencf2)
  (:outputs (leftout rightout))
  (:body
   "Sfile = p4"
   "iAmp = ampdb(p5)"
   "iMidi = p6"
   "iPan1 = p7"
   "iPan2 = p8"
   "iSus = min(0.999, max(0.0, p9))"
   "iCenter = min(0.999, max(0.001, p10))"
   "iSkip = max(0, p11)"
   "iAnalysisCutoff = max(1, p12)"
   "iBw = max(10, p13)"
   "iAnalysisCf = max(20, p14)"
   "iGenCf1 = max(20, p15)"
   "iGenCf2 = max(20, p16)"
   "iAttack = ((1 - iSus) * iCenter) * p3"
   "iRelease = ((1 - iSus) * (1 - iCenter)) * p3"

   "iNchnls filenchnls Sfile"
   "kAmp linen iAmp, iAttack, p3, iRelease"
   "kPan line iPan1, p3, iPan2"
   "kGenCf linseg iGenCf1, p3, iGenCf2"
   "aNoise random -1, 1"

   "if (iNchnls == 1) then"
   "  aSrc diskin2 Sfile, 1, iSkip, 0"
   "else"
   "  aLsrc, aRsrc diskin2 Sfile, 1, iSkip, 0"
   "  aSrc = (aLsrc + aRsrc) * 0.5"
   "endif"

   "aAmpCh butterbp aSrc, iAnalysisCf, iBw"
   "aAmpCh = abs(aAmpCh)"
   "aAmpCh butterlp aAmpCh, iAnalysisCutoff"
   "aAmpCh = aAmpCh * 100"
   "aAmpCh tone aAmpCh, iAnalysisCutoff"

   "aGen butterbp aNoise, kGenCf, iBw"
   "aSig = aGen * aAmpCh"
   "aSig = aSig * 2.5"
   "aSig = tanh(aSig) * kAmp"

   "aL, aR pan2 aSig, kPan"
   "aL dcblock2 aL"
   "aR dcblock2 aR"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; VOCODENOISEQUADREMAP
;;; -------------------------------------------------------

(defcsinstr vocodenoisequadremap
  (:type :instrument)
  (:pfields file amp midi pan1 pan2 sustain center skiptime speed analysiscutoff bw
            acf1 acf2 acf3 acf4 gcf1 gcf2 gcf3 gcf4 lpf1 lpf2)
  (:outputs (leftout rightout))
  (:body
   "Sfile = p4"
   "iAmp = ampdb(p5)"
   "iMidi = p6"
   "iPan1 = p7"
   "iPan2 = p8"
   "iSus = min(0.999, max(0.0, p9))"
   "iCenter = min(0.999, max(0.001, p10))"
   "iSkip = max(0, p11)"
   "iSpeed = p12"
   "iAnalysisCutoff = max(1, p13)"
   "iBw = max(10, p14)"
   "iAcf1 = max(20, p15)"
   "iAcf2 = max(20, p16)"
   "iAcf3 = max(20, p17)"
   "iAcf4 = max(20, p18)"
   "iGcf1 = max(20, p19)"
   "iGcf2 = max(20, p20)"
   "iGcf3 = max(20, p21)"
   "iGcf4 = max(20, p22)"
   "iLpf1 = max(20, p23)"
   "iLpf2 = max(20, p24)"
   "iAttack = ((1 - iSus) * iCenter) * p3"
   "iRelease = ((1 - iSus) * (1 - iCenter)) * p3"

   "iNchnls filenchnls Sfile"
   "kAmp linen iAmp, iAttack, p3, iRelease"
   "kPan line iPan1, p3, iPan2"
   "kLpfCf linseg iLpf1, p3, iLpf2"
   "aNoise random -1, 1"

   "if (iNchnls == 1) then"
   "  aSrc diskin2 Sfile, iSpeed, iSkip, 0"
   "else"
   "  aLsrc, aRsrc diskin2 Sfile, iSpeed, iSkip, 0"
   "  aSrc = (aLsrc + aRsrc) * 0.5"
   "endif"

   "aAmpCh01 butterbp aSrc, iAcf1, iBw"
   "aAmpCh01 = abs(aAmpCh01)"
   "aAmpCh01 butterlp aAmpCh01, iAnalysisCutoff"
   "aAmpCh01 = aAmpCh01 * 85"
   "aAmpCh01 tone aAmpCh01, iAnalysisCutoff"

   "aAmpCh02 butterbp aSrc, iAcf2, iBw"
   "aAmpCh02 = abs(aAmpCh02)"
   "aAmpCh02 butterlp aAmpCh02, iAnalysisCutoff"
   "aAmpCh02 = aAmpCh02 * 85"
   "aAmpCh02 tone aAmpCh02, iAnalysisCutoff"

   "aAmpCh03 butterbp aSrc, iAcf3, iBw"
   "aAmpCh03 = abs(aAmpCh03)"
   "aAmpCh03 butterlp aAmpCh03, iAnalysisCutoff"
   "aAmpCh03 = aAmpCh03 * 85"
   "aAmpCh03 tone aAmpCh03, iAnalysisCutoff"

   "aAmpCh04 butterbp aSrc, iAcf4, iBw"
   "aAmpCh04 = abs(aAmpCh04)"
   "aAmpCh04 butterlp aAmpCh04, iAnalysisCutoff"
   "aAmpCh04 = aAmpCh04 * 85"
   "aAmpCh04 tone aAmpCh04, iAnalysisCutoff"

   "aGen01 butterbp aNoise, iGcf1, iBw"
   "aGen01 = aGen01 * aAmpCh01"
   "aGen02 butterbp aNoise, iGcf2, iBw"
   "aGen02 = aGen02 * aAmpCh02"
   "aGen03 butterbp aNoise, iGcf3, iBw"
   "aGen03 = aGen03 * aAmpCh03"
   "aGen04 butterbp aNoise, iGcf4, iBw"
   "aGen04 = aGen04 * aAmpCh04"

   "aSig = aGen01 + aGen02 + aGen03 + aGen04"
   "aSig butterlp aSig, kLpfCf"
   "aSig = aSig * 2.0"
   "aSig = tanh(aSig) * kAmp"

   "aL, aR pan2 aSig, kPan"
   "aL dcblock2 aL"
   "aR dcblock2 aR"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; VOCODENOISEQUADSCALE
;;; -------------------------------------------------------

(defcsinstr vocodenoisequadscale
  (:type :instrument)
  (:pfields file amp midi pan1 pan2 sustain center skiptime speed analysiscutoff bw
            analysisbase analysisscalar genbase genscalar lpf1 lpf2)
  (:outputs (leftout rightout))
  (:body
   "Sfile = p4"
   "iAmp = ampdb(p5)"
   "iMidi = p6"
   "iPan1 = p7"
   "iPan2 = p8"
   "iSus = min(0.999, max(0.0, p9))"
   "iCenter = min(0.999, max(0.001, p10))"
   "iSkip = max(0, p11)"
   "iSpeed = p12"
   "iAnalysisCutoff = max(1, p13)"
   "iBw = max(10, p14)"
   "iAnalysisBase = max(20, p15)"
   "iAnalysisScalar = max(1.0001, p16)"
   "iGenBase = max(20, p17)"
   "iGenScalar = max(1.0001, p18)"
   "iLpf1 = max(20, p19)"
   "iLpf2 = max(20, p20)"

   "iAcf1 = iAnalysisBase * (iAnalysisScalar ^ 0)"
   "iAcf2 = iAnalysisBase * (iAnalysisScalar ^ 1)"
   "iAcf3 = iAnalysisBase * (iAnalysisScalar ^ 2)"
   "iAcf4 = iAnalysisBase * (iAnalysisScalar ^ 3)"

   "iGcf1 = iGenBase * (iGenScalar ^ 0)"
   "iGcf2 = iGenBase * (iGenScalar ^ 1)"
   "iGcf3 = iGenBase * (iGenScalar ^ 2)"
   "iGcf4 = iGenBase * (iGenScalar ^ 3)"

   "iAttack = ((1 - iSus) * iCenter) * p3"
   "iRelease = ((1 - iSus) * (1 - iCenter)) * p3"

   "iNchnls filenchnls Sfile"
   "kAmp linen iAmp, iAttack, p3, iRelease"
   "kPan line iPan1, p3, iPan2"
   "kLpfCf linseg iLpf1, p3, iLpf2"
   "aNoise random -1, 1"

   "if (iNchnls == 1) then"
   "  aSrc diskin2 Sfile, iSpeed, iSkip, 0"
   "else"
   "  aLsrc, aRsrc diskin2 Sfile, iSpeed, iSkip, 0"
   "  aSrc = (aLsrc + aRsrc) * 0.5"
   "endif"

   "aAmpCh01 butterbp aSrc, iAcf1, iBw"
   "aAmpCh01 = abs(aAmpCh01)"
   "aAmpCh01 butterlp aAmpCh01, iAnalysisCutoff"
   "aAmpCh01 = aAmpCh01 * 85"
   "aAmpCh01 tone aAmpCh01, iAnalysisCutoff"

   "aAmpCh02 butterbp aSrc, iAcf2, iBw"
   "aAmpCh02 = abs(aAmpCh02)"
   "aAmpCh02 butterlp aAmpCh02, iAnalysisCutoff"
   "aAmpCh02 = aAmpCh02 * 85"
   "aAmpCh02 tone aAmpCh02, iAnalysisCutoff"

   "aAmpCh03 butterbp aSrc, iAcf3, iBw"
   "aAmpCh03 = abs(aAmpCh03)"
   "aAmpCh03 butterlp aAmpCh03, iAnalysisCutoff"
   "aAmpCh03 = aAmpCh03 * 85"
   "aAmpCh03 tone aAmpCh03, iAnalysisCutoff"

   "aAmpCh04 butterbp aSrc, iAcf4, iBw"
   "aAmpCh04 = abs(aAmpCh04)"
   "aAmpCh04 butterlp aAmpCh04, iAnalysisCutoff"
   "aAmpCh04 = aAmpCh04 * 85"
   "aAmpCh04 tone aAmpCh04, iAnalysisCutoff"

   "aGen01 butterbp aNoise, iGcf1, iBw"
   "aGen01 = aGen01 * aAmpCh01"
   "aGen02 butterbp aNoise, iGcf2, iBw"
   "aGen02 = aGen02 * aAmpCh02"
   "aGen03 butterbp aNoise, iGcf3, iBw"
   "aGen03 = aGen03 * aAmpCh03"
   "aGen04 butterbp aNoise, iGcf4, iBw"
   "aGen04 = aGen04 * aAmpCh04"

   "aSig = aGen01 + aGen02 + aGen03 + aGen04"
   "aSig butterlp aSig, kLpfCf"
   "aSig = aSig * 2.0"
   "aSig = tanh(aSig) * kAmp"

   "aL, aR pan2 aSig, kPan"
   "aL dcblock2 aL"
   "aR dcblock2 aR"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; VOCODENOISEQUADSCALEREMAP
;;; -------------------------------------------------------

(defcsinstr vocodenoisequadscaleremap
  (:type :instrument)
  (:pfields file amp midi pan1 pan2 sustain center skiptime speed analysiscutoff bw
            analysisbase analysisscalar genbase genscalar
            src1 src2 src3 src4 post1 post2 post3 post4 lpf1 lpf2)
  (:outputs (leftout rightout))
  (:body
   "Sfile = p4"
   "iAmp = ampdb(p5)"
   "iMidi = p6"
   "iPan1 = p7"
   "iPan2 = p8"
   "iSus = min(0.999, max(0.0, p9))"
   "iCenter = min(0.999, max(0.001, p10))"
   "iSkip = max(0, p11)"
   "iSpeed = p12"
   "iAnalysisCutoff = max(1, p13)"
   "iBw = max(10, p14)"
   "iAnalysisBase = max(20, p15)"
   "iAnalysisScalar = max(1.0001, p16)"
   "iGenBase = max(20, p17)"
   "iGenScalar = max(1.0001, p18)"
   "iSrc1 = int(max(1, min(4, p19))) - 1"
   "iSrc2 = int(max(1, min(4, p20))) - 1"
   "iSrc3 = int(max(1, min(4, p21))) - 1"
   "iSrc4 = int(max(1, min(4, p22))) - 1"
   "kPost1 = max(0, p23)"
   "kPost2 = max(0, p24)"
   "kPost3 = max(0, p25)"
   "kPost4 = max(0, p26)"
   "iLpf1 = max(20, p27)"
   "iLpf2 = max(20, p28)"

   "iAcf1 = iAnalysisBase * (iAnalysisScalar ^ 0)"
   "iAcf2 = iAnalysisBase * (iAnalysisScalar ^ 1)"
   "iAcf3 = iAnalysisBase * (iAnalysisScalar ^ 2)"
   "iAcf4 = iAnalysisBase * (iAnalysisScalar ^ 3)"

   "iGcf1 = iGenBase * (iGenScalar ^ iSrc1)"
   "iGcf2 = iGenBase * (iGenScalar ^ iSrc2)"
   "iGcf3 = iGenBase * (iGenScalar ^ iSrc3)"
   "iGcf4 = iGenBase * (iGenScalar ^ iSrc4)"

   "iAttack = ((1 - iSus) * iCenter) * p3"
   "iRelease = ((1 - iSus) * (1 - iCenter)) * p3"

   "iNchnls filenchnls Sfile"
   "kAmp linen iAmp, iAttack, p3, iRelease"
   "kPan line iPan1, p3, iPan2"
   "kLpfCf linseg iLpf1, p3, iLpf2"
   "aNoise random -1, 1"

   "if (iNchnls == 1) then"
   "  aSrc diskin2 Sfile, iSpeed, iSkip, 0"
   "else"
   "  aLsrc, aRsrc diskin2 Sfile, iSpeed, iSkip, 0"
   "  aSrc = (aLsrc + aRsrc) * 0.5"
   "endif"

   "aAmpCh01 butterbp aSrc, iAcf1, iBw"
   "aAmpCh01 = abs(aAmpCh01)"
   "aAmpCh01 butterlp aAmpCh01, iAnalysisCutoff"
   "aAmpCh01 = aAmpCh01 * 85"
   "aAmpCh01 tone aAmpCh01, iAnalysisCutoff"

   "aAmpCh02 butterbp aSrc, iAcf2, iBw"
   "aAmpCh02 = abs(aAmpCh02)"
   "aAmpCh02 butterlp aAmpCh02, iAnalysisCutoff"
   "aAmpCh02 = aAmpCh02 * 85"
   "aAmpCh02 tone aAmpCh02, iAnalysisCutoff"

   "aAmpCh03 butterbp aSrc, iAcf3, iBw"
   "aAmpCh03 = abs(aAmpCh03)"
   "aAmpCh03 butterlp aAmpCh03, iAnalysisCutoff"
   "aAmpCh03 = aAmpCh03 * 85"
   "aAmpCh03 tone aAmpCh03, iAnalysisCutoff"

   "aAmpCh04 butterbp aSrc, iAcf4, iBw"
   "aAmpCh04 = abs(aAmpCh04)"
   "aAmpCh04 butterlp aAmpCh04, iAnalysisCutoff"
   "aAmpCh04 = aAmpCh04 * 85"
   "aAmpCh04 tone aAmpCh04, iAnalysisCutoff"

   "aGen01 butterbp aNoise, iGcf1, iBw"
   "aGen01 = aGen01 * aAmpCh01 * kPost1"
   "aGen02 butterbp aNoise, iGcf2, iBw"
   "aGen02 = aGen02 * aAmpCh02 * kPost2"
   "aGen03 butterbp aNoise, iGcf3, iBw"
   "aGen03 = aGen03 * aAmpCh03 * kPost3"
   "aGen04 butterbp aNoise, iGcf4, iBw"
   "aGen04 = aGen04 * aAmpCh04 * kPost4"

   "aSig = aGen01 + aGen02 + aGen03 + aGen04"
   "aSig butterlp aSig, kLpfCf"
   "aSig = aSig * 2.0"
   "aSig = tanh(aSig) * kAmp"

   "aL, aR pan2 aSig, kPan"
   "aL dcblock2 aL"
   "aR dcblock2 aR"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; VOCODENOISEOCTSCALE
;;; -------------------------------------------------------

(defcsinstr vocodenoiseoctscale
  (:type :instrument)
  (:pfields file amp midi pan1 pan2 sustain center skiptime speed analysiscutoff bw
            analysisbase analysisscalar genbase genscalar lpf1 lpf2)
  (:outputs (leftout rightout))
  (:body
   "Sfile = p4"
   "iAmp = ampdb(p5)"
   "iMidi = p6"
   "iPan1 = p7"
   "iPan2 = p8"
   "iSus = min(0.999, max(0.0, p9))"
   "iCenter = min(0.999, max(0.001, p10))"
   "iSkip = max(0, p11)"
   "iSpeed = p12"
   "iAnalysisCutoff = max(1, p13)"
   "iBw = max(10, p14)"
   "iAnalysisBase = max(20, p15)"
   "iAnalysisScalar = max(1.0001, p16)"
   "iGenBase = max(20, p17)"
   "iGenScalar = max(1.0001, p18)"
   "iLpf1 = max(20, p19)"
   "iLpf2 = max(20, p20)"
   "iAttack = ((1 - iSus) * iCenter) * p3"
   "iRelease = ((1 - iSus) * (1 - iCenter)) * p3"

   "iNchnls filenchnls Sfile"
   "kAmp linen iAmp, iAttack, p3, iRelease"
   "kPan line iPan1, p3, iPan2"
   "kLpfCf linseg iLpf1, p3, iLpf2"
   "aNoise random -1, 1"

   "if (iNchnls == 1) then"
   "  aSrc diskin2 Sfile, iSpeed, iSkip, 0"
   "else"
   "  aLsrc, aRsrc diskin2 Sfile, iSpeed, iSkip, 0"
   "  aSrc = (aLsrc + aRsrc) * 0.5"
   "endif"

   "iAcf1 = iAnalysisBase * (iAnalysisScalar ^ 0)"
   "iAcf2 = iAnalysisBase * (iAnalysisScalar ^ 1)"
   "iAcf3 = iAnalysisBase * (iAnalysisScalar ^ 2)"
   "iAcf4 = iAnalysisBase * (iAnalysisScalar ^ 3)"
   "iAcf5 = iAnalysisBase * (iAnalysisScalar ^ 4)"
   "iAcf6 = iAnalysisBase * (iAnalysisScalar ^ 5)"
   "iAcf7 = iAnalysisBase * (iAnalysisScalar ^ 6)"
   "iAcf8 = iAnalysisBase * (iAnalysisScalar ^ 7)"

   "iGcf1 = iGenBase * (iGenScalar ^ 0)"
   "iGcf2 = iGenBase * (iGenScalar ^ 1)"
   "iGcf3 = iGenBase * (iGenScalar ^ 2)"
   "iGcf4 = iGenBase * (iGenScalar ^ 3)"
   "iGcf5 = iGenBase * (iGenScalar ^ 4)"
   "iGcf6 = iGenBase * (iGenScalar ^ 5)"
   "iGcf7 = iGenBase * (iGenScalar ^ 6)"
   "iGcf8 = iGenBase * (iGenScalar ^ 7)"

   "aAmpCh01 butterbp aSrc, iAcf1, iBw"
   "aAmpCh01 = abs(aAmpCh01)"
   "aAmpCh01 butterlp aAmpCh01, iAnalysisCutoff"
   "aAmpCh01 = aAmpCh01 * 75"
   "aAmpCh01 tone aAmpCh01, iAnalysisCutoff"
   "aAmpCh02 butterbp aSrc, iAcf2, iBw"
   "aAmpCh02 = abs(aAmpCh02)"
   "aAmpCh02 butterlp aAmpCh02, iAnalysisCutoff"
   "aAmpCh02 = aAmpCh02 * 75"
   "aAmpCh02 tone aAmpCh02, iAnalysisCutoff"
   "aAmpCh03 butterbp aSrc, iAcf3, iBw"
   "aAmpCh03 = abs(aAmpCh03)"
   "aAmpCh03 butterlp aAmpCh03, iAnalysisCutoff"
   "aAmpCh03 = aAmpCh03 * 75"
   "aAmpCh03 tone aAmpCh03, iAnalysisCutoff"
   "aAmpCh04 butterbp aSrc, iAcf4, iBw"
   "aAmpCh04 = abs(aAmpCh04)"
   "aAmpCh04 butterlp aAmpCh04, iAnalysisCutoff"
   "aAmpCh04 = aAmpCh04 * 75"
   "aAmpCh04 tone aAmpCh04, iAnalysisCutoff"
   "aAmpCh05 butterbp aSrc, iAcf5, iBw"
   "aAmpCh05 = abs(aAmpCh05)"
   "aAmpCh05 butterlp aAmpCh05, iAnalysisCutoff"
   "aAmpCh05 = aAmpCh05 * 75"
   "aAmpCh05 tone aAmpCh05, iAnalysisCutoff"
   "aAmpCh06 butterbp aSrc, iAcf6, iBw"
   "aAmpCh06 = abs(aAmpCh06)"
   "aAmpCh06 butterlp aAmpCh06, iAnalysisCutoff"
   "aAmpCh06 = aAmpCh06 * 75"
   "aAmpCh06 tone aAmpCh06, iAnalysisCutoff"
   "aAmpCh07 butterbp aSrc, iAcf7, iBw"
   "aAmpCh07 = abs(aAmpCh07)"
   "aAmpCh07 butterlp aAmpCh07, iAnalysisCutoff"
   "aAmpCh07 = aAmpCh07 * 75"
   "aAmpCh07 tone aAmpCh07, iAnalysisCutoff"
   "aAmpCh08 butterbp aSrc, iAcf8, iBw"
   "aAmpCh08 = abs(aAmpCh08)"
   "aAmpCh08 butterlp aAmpCh08, iAnalysisCutoff"
   "aAmpCh08 = aAmpCh08 * 75"
   "aAmpCh08 tone aAmpCh08, iAnalysisCutoff"

   "aGen01 butterbp aNoise, iGcf1, iBw"
   "aGen01 = aGen01 * aAmpCh01"
   "aGen02 butterbp aNoise, iGcf2, iBw"
   "aGen02 = aGen02 * aAmpCh02"
   "aGen03 butterbp aNoise, iGcf3, iBw"
   "aGen03 = aGen03 * aAmpCh03"
   "aGen04 butterbp aNoise, iGcf4, iBw"
   "aGen04 = aGen04 * aAmpCh04"
   "aGen05 butterbp aNoise, iGcf5, iBw"
   "aGen05 = aGen05 * aAmpCh05"
   "aGen06 butterbp aNoise, iGcf6, iBw"
   "aGen06 = aGen06 * aAmpCh06"
   "aGen07 butterbp aNoise, iGcf7, iBw"
   "aGen07 = aGen07 * aAmpCh07"
   "aGen08 butterbp aNoise, iGcf8, iBw"
   "aGen08 = aGen08 * aAmpCh08"

   "aSig = aGen01 + aGen02 + aGen03 + aGen04 + aGen05 + aGen06 + aGen07 + aGen08"
   "aSig butterlp aSig, kLpfCf"
   "aSig = aSig * 1.6"
   "aSig = tanh(aSig) * kAmp"

   "aL, aR pan2 aSig, kPan"
   "aL dcblock2 aL"
   "aR dcblock2 aR"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; VOCODENOISEOCTSCALEREMAP
;;; -------------------------------------------------------

(defcsinstr vocodenoiseoctscaleremap
  (:type :instrument)
  (:pfields file amp midi pan1 pan2 sustain center skiptime speed analysiscutoff bw
            analysisbase analysisscalar genbase genscalar
            src1 src2 src3 src4 src5 src6 src7 src8
            post1 post2 post3 post4 post5 post6 post7 post8 lpf1 lpf2)
  (:outputs (leftout rightout))
  (:body
   "Sfile = p4"
   "iAmp = ampdb(p5)"
   "iMidi = p6"
   "iPan1 = p7"
   "iPan2 = p8"
   "iSus = min(0.999, max(0.0, p9))"
   "iCenter = min(0.999, max(0.001, p10))"
   "iSkip = max(0, p11)"
   "iSpeed = p12"
   "iAnalysisCutoff = max(1, p13)"
   "iBw = max(10, p14)"
   "iAnalysisBase = max(20, p15)"
   "iAnalysisScalar = max(1.0001, p16)"
   "iGenBase = max(20, p17)"
   "iGenScalar = max(1.0001, p18)"
   "iSrc1 = int(max(1, min(8, p19))) - 1"
   "iSrc2 = int(max(1, min(8, p20))) - 1"
   "iSrc3 = int(max(1, min(8, p21))) - 1"
   "iSrc4 = int(max(1, min(8, p22))) - 1"
   "iSrc5 = int(max(1, min(8, p23))) - 1"
   "iSrc6 = int(max(1, min(8, p24))) - 1"
   "iSrc7 = int(max(1, min(8, p25))) - 1"
   "iSrc8 = int(max(1, min(8, p26))) - 1"
   "kPost1 = max(0, p27)"
   "kPost2 = max(0, p28)"
   "kPost3 = max(0, p29)"
   "kPost4 = max(0, p30)"
   "kPost5 = max(0, p31)"
   "kPost6 = max(0, p32)"
   "kPost7 = max(0, p33)"
   "kPost8 = max(0, p34)"
   "iLpf1 = max(20, p35)"
   "iLpf2 = max(20, p36)"

   "iAcf1 = iAnalysisBase * (iAnalysisScalar ^ 0)"
   "iAcf2 = iAnalysisBase * (iAnalysisScalar ^ 1)"
   "iAcf3 = iAnalysisBase * (iAnalysisScalar ^ 2)"
   "iAcf4 = iAnalysisBase * (iAnalysisScalar ^ 3)"
   "iAcf5 = iAnalysisBase * (iAnalysisScalar ^ 4)"
   "iAcf6 = iAnalysisBase * (iAnalysisScalar ^ 5)"
   "iAcf7 = iAnalysisBase * (iAnalysisScalar ^ 6)"
   "iAcf8 = iAnalysisBase * (iAnalysisScalar ^ 7)"

   "iGcf1 = iGenBase * (iGenScalar ^ iSrc1)"
   "iGcf2 = iGenBase * (iGenScalar ^ iSrc2)"
   "iGcf3 = iGenBase * (iGenScalar ^ iSrc3)"
   "iGcf4 = iGenBase * (iGenScalar ^ iSrc4)"
   "iGcf5 = iGenBase * (iGenScalar ^ iSrc5)"
   "iGcf6 = iGenBase * (iGenScalar ^ iSrc6)"
   "iGcf7 = iGenBase * (iGenScalar ^ iSrc7)"
   "iGcf8 = iGenBase * (iGenScalar ^ iSrc8)"

   "iAttack = ((1 - iSus) * iCenter) * p3"
   "iRelease = ((1 - iSus) * (1 - iCenter)) * p3"

   "iNchnls filenchnls Sfile"
   "kAmp linen iAmp, iAttack, p3, iRelease"
   "kPan line iPan1, p3, iPan2"
   "kLpfCf linseg iLpf1, p3, iLpf2"
   "aNoise random -1, 1"

   "if (iNchnls == 1) then"
   "  aSrc diskin2 Sfile, iSpeed, iSkip, 0"
   "else"
   "  aLsrc, aRsrc diskin2 Sfile, iSpeed, iSkip, 0"
   "  aSrc = (aLsrc + aRsrc) * 0.5"
   "endif"

   "aAmpCh01 butterbp aSrc, iAcf1, iBw"
   "aAmpCh01 = abs(aAmpCh01)"
   "aAmpCh01 butterlp aAmpCh01, iAnalysisCutoff"
   "aAmpCh01 = aAmpCh01 * 65"
   "aAmpCh01 tone aAmpCh01, iAnalysisCutoff"
   "aAmpCh02 butterbp aSrc, iAcf2, iBw"
   "aAmpCh02 = abs(aAmpCh02)"
   "aAmpCh02 butterlp aAmpCh02, iAnalysisCutoff"
   "aAmpCh02 = aAmpCh02 * 65"
   "aAmpCh02 tone aAmpCh02, iAnalysisCutoff"
   "aAmpCh03 butterbp aSrc, iAcf3, iBw"
   "aAmpCh03 = abs(aAmpCh03)"
   "aAmpCh03 butterlp aAmpCh03, iAnalysisCutoff"
   "aAmpCh03 = aAmpCh03 * 65"
   "aAmpCh03 tone aAmpCh03, iAnalysisCutoff"
   "aAmpCh04 butterbp aSrc, iAcf4, iBw"
   "aAmpCh04 = abs(aAmpCh04)"
   "aAmpCh04 butterlp aAmpCh04, iAnalysisCutoff"
   "aAmpCh04 = aAmpCh04 * 65"
   "aAmpCh04 tone aAmpCh04, iAnalysisCutoff"
   "aAmpCh05 butterbp aSrc, iAcf5, iBw"
   "aAmpCh05 = abs(aAmpCh05)"
   "aAmpCh05 butterlp aAmpCh05, iAnalysisCutoff"
   "aAmpCh05 = aAmpCh05 * 65"
   "aAmpCh05 tone aAmpCh05, iAnalysisCutoff"
   "aAmpCh06 butterbp aSrc, iAcf6, iBw"
   "aAmpCh06 = abs(aAmpCh06)"
   "aAmpCh06 butterlp aAmpCh06, iAnalysisCutoff"
   "aAmpCh06 = aAmpCh06 * 65"
   "aAmpCh06 tone aAmpCh06, iAnalysisCutoff"
   "aAmpCh07 butterbp aSrc, iAcf7, iBw"
   "aAmpCh07 = abs(aAmpCh07)"
   "aAmpCh07 butterlp aAmpCh07, iAnalysisCutoff"
   "aAmpCh07 = aAmpCh07 * 65"
   "aAmpCh07 tone aAmpCh07, iAnalysisCutoff"
   "aAmpCh08 butterbp aSrc, iAcf8, iBw"
   "aAmpCh08 = abs(aAmpCh08)"
   "aAmpCh08 butterlp aAmpCh08, iAnalysisCutoff"
   "aAmpCh08 = aAmpCh08 * 65"
   "aAmpCh08 tone aAmpCh08, iAnalysisCutoff"

   "aGen01 butterbp aNoise, iGcf1, iBw"
   "aGen01 = aGen01 * aAmpCh01 * kPost1"
   "aGen02 butterbp aNoise, iGcf2, iBw"
   "aGen02 = aGen02 * aAmpCh02 * kPost2"
   "aGen03 butterbp aNoise, iGcf3, iBw"
   "aGen03 = aGen03 * aAmpCh03 * kPost3"
   "aGen04 butterbp aNoise, iGcf4, iBw"
   "aGen04 = aGen04 * aAmpCh04 * kPost4"
   "aGen05 butterbp aNoise, iGcf5, iBw"
   "aGen05 = aGen05 * aAmpCh05 * kPost5"
   "aGen06 butterbp aNoise, iGcf6, iBw"
   "aGen06 = aGen06 * aAmpCh06 * kPost6"
   "aGen07 butterbp aNoise, iGcf7, iBw"
   "aGen07 = aGen07 * aAmpCh07 * kPost7"
   "aGen08 butterbp aNoise, iGcf8, iBw"
   "aGen08 = aGen08 * aAmpCh08 * kPost8"

   "aSig = aGen01 + aGen02 + aGen03 + aGen04 + aGen05 + aGen06 + aGen07 + aGen08"
   "aSig butterlp aSig, kLpfCf"
   "aSig = aSig * 1.6"
   "aSig = tanh(aSig) * kAmp"

   "aL, aR pan2 aSig, kPan"
   "aL dcblock2 aL"
   "aR dcblock2 aR"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))


;;; -------------------------------------------------------
;;; PHASEVOCODEREAD
;;; -------------------------------------------------------

(defcsinstr phasevocoderead
  (:type :instrument)
  (:pfields analysis amp midi pan1 pan2 bin start fadein fadeout)
  (:globals
   "giPvReadSine ftgen 1, 0, 8192, 10, 1")
  (:outputs (leftout rightout))
  (:body
   "iAnalysis = i(p4)"
   "iAmp = ampdb(p5)"
   "iMidi = p6"
   "iPan1 = p7"
   "iPan2 = p8"
   "iBin = i(p9)"
   "iStart = max(0, p10)"
   "iFadeIn = max(0.001, p11)"
   "iFadeOut = max(0.001, p12)"

   "kTime line iStart, p3, iStart + p3"
   "kEnv linen iAmp, iFadeIn, p3, iFadeOut"
   "kPan line iPan1, p3, iPan2"
   "kFreq, kPvAmp pvread kTime, iAnalysis, iBin"
   "aSig oscili (kPvAmp * kEnv), kFreq, giPvReadSine"

   "aL, aR pan2 aSig, kPan"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))


;;; -------------------------------------------------------
;;; SYNTHREZZY
;;; -------------------------------------------------------

(defcsinstr synthrezzy
  (:type :instrument)
  (:pfields amp freq sweep rez wave drive pan1 pan2)
  (:outputs (leftout rightout))
  (:globals
   "giRezSine   ftgen 0, 0, 16384, 10, 1"
   "giRezTri    ftgen 0, 0, 4096, 7, 0, 1024, 1, 2048, -1, 1024, 0"
   "giRezSaw    ftgen 0, 0, 16384, 7, -1, 16384, 1"
   "giRezSquare ftgen 0, 0, 16384, 7, 1, 8192, 1, 0, -1, 8192, -1")
  (:body
   "kamp = ampdb(p4) * 1.2"
   "kfreq = p5"
   "iSweep = max(40, p6)"
   "kRez = limit(p7, 0.05, 0.98)"
   "iWaveSel = int(limit(p8, 1, 4))"
   "kDrive = max(0, p9)"
   "ipan1 = p10"
   "ipan2 = p11"

   "iWave = giRezSine"
   "if (iWaveSel == 2) then"
   "  iWave = giRezTri"
   "elseif (iWaveSel == 3) then"
   "  iWave = giRezSaw"
   "elseif (iWaveSel == 4) then"
   "  iWave = giRezSquare"
   "endif"

   "aEnv madsr 0.01, 0.12, 0.75, 0.10"
   "kFco linseg iSweep, p3 * 0.5, max(60, iSweep * 0.2), p3 * 0.5, max(40, iSweep * 0.1)"
   "aOsc oscili kamp, kfreq, iWave"
   "aPre = aOsc * (1 + kDrive)"
   "aSat = tanh(aPre)"
   "aFilt moogladder aSat, kFco, kRez"
   "aMix = aFilt * aEnv"

   "kPan = line:k(ipan1, p3, ipan2)"
   "aL, aR pan2 aMix, kPan"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR")
  (:doc "Resonant synth with selectable waveform, filter sweep and controllable drive."))

(in-package :opusmodus)

;;; -------------------------------------------------------
;;; SYNTHWAVEFORMVIBRATO
;;; -------------------------------------------------------

(defcsinstr synthwaveformvibrato
  (:type :instrument)
  (:pfields amp freq atk rel vibdepth vibdelay vibrate wave1 wave2 xfade pan1 pan2)
  (:outputs (leftout rightout))
  (:globals
   "giWvVibSine   ftgen 0, 0, 16384, 10, 1"
   "giWvVibTri    ftgen 0, 0, 4096, 7, 0, 1024, 1, 2048, -1, 1024, 0"
   "giWvVibSaw    ftgen 0, 0, 16384, 7, -1, 16384, 1"
   "giWvVibSquare ftgen 0, 0, 16384, 7, 1, 8192, 1, 0, -1, 8192, -1")
  (:body
   "kamp = ampdb(p4) * 0.18"
   "kfreq = p5"

   "iAtk = p6"
   "if (iAtk < 0.001) then"
   "  iAtk = 0.001"
   "endif"

   "iRel = p7"
   "if (iRel < 0.001) then"
   "  iRel = 0.001"
   "endif"

   "iVibDepth = p8"
   "if (iVibDepth < 0) then"
   "  iVibDepth = 0"
   "endif"

   "iVibDelay = p9"
   "if (iVibDelay < 0) then"
   "  iVibDelay = 0"
   "elseif (iVibDelay > 0.99) then"
   "  iVibDelay = 0.99"
   "endif"

   "kVibRate = p10"
   "if (kVibRate < 0.05) then"
   "  kVibRate = 0.05"
   "endif"

   "iWaveSel1 = int(p11)"
   "if (iWaveSel1 < 1) then"
   "  iWaveSel1 = 1"
   "elseif (iWaveSel1 > 4) then"
   "  iWaveSel1 = 4"
   "endif"

   "iWaveSel2 = int(p12)"
   "if (iWaveSel2 < 1) then"
   "  iWaveSel2 = 1"
   "elseif (iWaveSel2 > 4) then"
   "  iWaveSel2 = 4"
   "endif"

   "iXfade = p13"
   "if (iXfade < 0.01) then"
   "  iXfade = 0.01"
   "elseif (iXfade > 0.99) then"
   "  iXfade = 0.99"
   "endif"

   "ipan1 = p14"
   "ipan2 = p15"

   "iWave1 = giWvVibSine"
   "if (iWaveSel1 == 2) then"
   "  iWave1 = giWvVibTri"
   "elseif (iWaveSel1 == 3) then"
   "  iWave1 = giWvVibSaw"
   "elseif (iWaveSel1 == 4) then"
   "  iWave1 = giWvVibSquare"
   "endif"

   "iWave2 = giWvVibSine"
   "if (iWaveSel2 == 2) then"
   "  iWave2 = giWvVibTri"
   "elseif (iWaveSel2 == 3) then"
   "  iWave2 = giWvVibSaw"
   "elseif (iWaveSel2 == 4) then"
   "  iWave2 = giWvVibSquare"
   "endif"

   "iVibDelayTime = p3 * iVibDelay"
   "iVibRiseTime = p3 * (1 - iVibDelay)"
   "if (iVibRiseTime < 0.001) then"
   "  iVibRiseTime = 0.001"
   "endif"

   "iMorph1 = p3 * iXfade"
   "iMorph2 = p3 * (1 - iXfade)"
   "if (iMorph2 < 0.001) then"
   "  iMorph2 = 0.001"
   "endif"

   "aEnv madsr iAtk, 0.15, 0.90, iRel"
   "kVibEnv linseg 0, iVibDelayTime, 0, iVibRiseTime, iVibDepth"
   "kVib oscili kVibEnv, kVibRate, giWvVibSine"

   "kMorph linseg 0, iMorph1, 1, iMorph2, 1"

   "a1 oscili kamp * 0.34, kfreq * (1 + kVib), iWave1"
   "a2 oscili kamp * 0.22, kfreq * 1.003 * (1 + kVib), iWave1"
   "a3 oscili kamp * 0.22, kfreq * 0.997 * (1 + kVib), iWave1"

   "a4 oscili kamp * 0.34, kfreq * (1 + kVib), iWave2"
   "a5 oscili kamp * 0.22, kfreq * 1.25 * (1 + (kVib * 0.7)), iWave2"
   "a6 oscili kamp * 0.18, kfreq * 0.50 * (1 + (kVib * 0.5)), iWave2"

   "aFrom = a1 + a2 + a3"
   "aTo = a4 + a5 + a6"
   "aMix = ((1 - kMorph) * aFrom + (kMorph * aTo)) * aEnv * 8"

   "kPan = line:k(ipan1, p3, ipan2)"
   "aL, aR pan2 aMix, kPan"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR")
  (:doc "Waveform-morphing synth with delayed vibrato and layered detuned oscillators."))


;;; -------------------------------------------------------
;;; SYNTHVCOAUDIOENVELOPESINEQUAD
;;; -------------------------------------------------------

(defcsinstr synthvcoaudioenvelopesinequad
  (:type :instrument)
  (:pfields amp freq
            suspct suscenter
            lpfstart lpfend lpfq
            wave widthstart widthend
            trem1start trem1end trem1amp
            trem2start trem2end trem2amp
            trem3start trem3end trem3amp
            trem4start trem4end trem4amp
            pan1 pan2)
  (:outputs (leftout rightout))
  (:globals
   "giSVAESQ_Sine ftgen 0, 0, 16384, 10, 1")
  (:body
   "iDur = p3"
   "iAmp = ampdb(p4) * 0.22"
   "iFreq = p5"

   "iSusPcent = p6"
   "if (iSusPcent < 0) then"
   "  iSusPcent = 0"
   "elseif (iSusPcent > 1) then"
   "  iSusPcent = 1"
   "endif"

   "iSusCenterPcent = p7"
   "if (iSusCenterPcent < 0) then"
   "  iSusCenterPcent = 0"
   "elseif (iSusCenterPcent > 1) then"
   "  iSusCenterPcent = 1"
   "endif"

   "iCutoffStart = p8"
   "iCutoffEnd = p9"

   "iUserQ = p10"
   "if (iUserQ < 0) then"
   "  iUserQ = 0"
   "elseif (iUserQ > 1) then"
   "  iUserQ = 1"
   "endif"
   "iLpfQ = 0.7 + (iUserQ * 0.6)"

   "iVcoWaveForm = int(p11)"
   "if (iVcoWaveForm < 1) then"
   "  iVcoWaveForm = 1"
   "elseif (iVcoWaveForm > 3) then"
   "  iVcoWaveForm = 3"
   "endif"

   "iVcoWidthStart = p12"
   "iVcoWidthEnd = p13"

   "iTremRateStart01 = p14"
   "iTremRateEnd01 = p15"
   "iTremAmp01 = p16"

   "iTremRateStart02 = p17"
   "iTremRateEnd02 = p18"
   "iTremAmp02 = p19"

   "iTremRateStart03 = p20"
   "iTremRateEnd03 = p21"
   "iTremAmp03 = p22"

   "iTremRateStart04 = p23"
   "iTremRateEnd04 = p24"
   "iTremAmp04 = p25"

   "ipan1 = p26"
   "ipan2 = p27"

   "iAttack = ((1 - iSusPcent) * iSusCenterPcent) * iDur"
   "iRelease = ((1 - iSusPcent) * (1 - iSusCenterPcent)) * iDur"
   "if (iAttack < 0.001) then"
   "  iAttack = 0.001"
   "endif"
   "if (iRelease < 0.001) then"
   "  iRelease = 0.001"
   "endif"

   "kAmp linen iAmp, iAttack, iDur, iRelease"

   "kTremCf01 linseg iTremRateStart01, iDur, iTremRateEnd01"
   "kTremCf02 linseg iTremRateStart02, iDur, iTremRateEnd02"
   "kTremCf03 linseg iTremRateStart03, iDur, iTremRateEnd03"
   "kTremCf04 linseg iTremRateStart04, iDur, iTremRateEnd04"

   "aTrem01 poscil 1, kTremCf01, giSVAESQ_Sine"
   "aTrem01 = (((aTrem01 + 1) * 0.5) * iTremAmp01) + (1 - iTremAmp01)"

   "aTrem02 poscil 1, kTremCf02, giSVAESQ_Sine"
   "aTrem02 = (((aTrem02 + 1) * 0.5) * iTremAmp02) + (1 - iTremAmp02)"

   "aTrem03 poscil 1, kTremCf03, giSVAESQ_Sine"
   "aTrem03 = (((aTrem03 + 1) * 0.5) * iTremAmp03) + (1 - iTremAmp03)"

   "aTrem04 poscil 1, kTremCf04, giSVAESQ_Sine"
   "aTrem04 = (((aTrem04 + 1) * 0.5) * iTremAmp04) + (1 - iTremAmp04)"

   "kVcoWidth linseg iVcoWidthStart, iDur, iVcoWidthEnd"
   "if (kVcoWidth < 0.02) then"
   "  kVcoWidth = 0.02"
   "elseif (kVcoWidth > 0.98) then"
   "  kVcoWidth = 0.98"
   "endif"

   "aSig vco kAmp, iFreq, iVcoWaveForm, kVcoWidth, giSVAESQ_Sine"

   "kLpfCf linseg iCutoffStart, iDur, iCutoffEnd"
   "if (kLpfCf < 40) then"
   "  kLpfCf = 40"
   "endif"

   "aSig lowpass2 aSig, kLpfCf, iLpfQ"

   "aMixSig = aSig * aTrem01 * aTrem02 * aTrem03 * aTrem04"
   "aMixSig = tanh(aMixSig * 1.2)"
   "aMixSig dcblock2 aMixSig"

   "kPan = line:k(ipan1, p3, ipan2)"
   "aL, aR pan2 aMixSig, kPan"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; SYNTHVCOAUDIOENVELOPESQUAREQUAD
;;; -------------------------------------------------------

(defcsinstr synthvcoaudioenvelopesquarequad
  (:type :instrument)
  (:pfields amp freq
            suspct suscenter
            lpfstart lpfend lpfq
            wave widthstart widthend
            trem1start trem1end trem1amp
            trem2start trem2end trem2amp
            trem3start trem3end trem3amp
            trem4start trem4end trem4amp
            pan1 pan2)
  (:outputs (leftout rightout))
  (:globals
   "giSVAESQ_Sine   ftgen 0, 0, 16384, 10, 1"
   "giSVAESQ_Square ftgen 0, 0, 16384, 7, 1, 8192, 1, 0, -1, 8192, -1")
  (:body
   "iDur = p3"
   "iAmp = ampdb(p4) * 0.32"
   "iFreq = p5"

   "iSusPcent = p6"
   "if (iSusPcent < 0) then"
   "  iSusPcent = 0"
   "elseif (iSusPcent > 1) then"
   "  iSusPcent = 1"
   "endif"

   "iSusCenterPcent = p7"
   "if (iSusCenterPcent < 0) then"
   "  iSusCenterPcent = 0"
   "elseif (iSusCenterPcent > 1) then"
   "  iSusCenterPcent = 1"
   "endif"

   "iCutoffStart = p8"
   "iCutoffEnd = p9"
   "iLpfQ = p10"
   "if (iLpfQ < 1) then"
   "  iLpfQ = 1"
   "endif"

   "iVcoWaveForm = int(p11)"
   "if (iVcoWaveForm < 1) then"
   "  iVcoWaveForm = 1"
   "elseif (iVcoWaveForm > 3) then"
   "  iVcoWaveForm = 3"
   "endif"

   "iVcoWidthStart = p12"
   "iVcoWidthEnd = p13"

   "iTremRateStart01 = p14"
   "iTremRateEnd01 = p15"
   "iTremAmp01 = p16"

   "iTremRateStart02 = p17"
   "iTremRateEnd02 = p18"
   "iTremAmp02 = p19"

   "iTremRateStart03 = p20"
   "iTremRateEnd03 = p21"
   "iTremAmp03 = p22"

   "iTremRateStart04 = p23"
   "iTremRateEnd04 = p24"
   "iTremAmp04 = p25"

   "ipan1 = p26"
   "ipan2 = p27"

   "iAttack = ((1 - iSusPcent) * iSusCenterPcent) * iDur"
   "iRelease = ((1 - iSusPcent) * (1 - iSusCenterPcent)) * iDur"

   "if (iAttack < 0.001) then"
   "  iAttack = 0.001"
   "endif"
   "if (iRelease < 0.001) then"
   "  iRelease = 0.001"
   "endif"

   "kAmp linen iAmp, iAttack, iDur, iRelease"

   "kTremCf01 linseg iTremRateStart01, iDur, iTremRateEnd01"
   "kTremCf02 linseg iTremRateStart02, iDur, iTremRateEnd02"
   "kTremCf03 linseg iTremRateStart03, iDur, iTremRateEnd03"
   "kTremCf04 linseg iTremRateStart04, iDur, iTremRateEnd04"

   "aTrem01 poscil 1, kTremCf01, giSVAESQ_Square"
   "aTrem01 = (((aTrem01 + 1) * 0.5) * iTremAmp01) + (1 - iTremAmp01)"

   "aTrem02 poscil 1, kTremCf02, giSVAESQ_Square"
   "aTrem02 = (((aTrem02 + 1) * 0.5) * iTremAmp02) + (1 - iTremAmp02)"

   "aTrem03 poscil 1, kTremCf03, giSVAESQ_Square"
   "aTrem03 = (((aTrem03 + 1) * 0.5) * iTremAmp03) + (1 - iTremAmp03)"

   "aTrem04 poscil 1, kTremCf04, giSVAESQ_Square"
   "aTrem04 = (((aTrem04 + 1) * 0.5) * iTremAmp04) + (1 - iTremAmp04)"

   "kVcoWidth linseg iVcoWidthStart, iDur, iVcoWidthEnd"
   "aSig vco kAmp, iFreq, iVcoWaveForm, kVcoWidth, giSVAESQ_Sine"

   "kLpfCf linseg iCutoffStart, iDur, iCutoffEnd"
   "aSig lowpass2 aSig, kLpfCf, iLpfQ"

   "aMixSig = aSig * aTrem01 * aTrem02 * aTrem03 * aTrem04"
   "aMixSig dcblock2 aMixSig"

   "kPan = line:k(ipan1, p3, ipan2)"
   "aL, aR pan2 aMixSig, kPan"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR")
  (:doc "VCO instrument with proportional macro envelope, low-pass filter and four square-based audio-rate tremolo modulators."))

;;; -------------------------------------------------------
;;; SYNTHVCODISTORT
;;; -------------------------------------------------------

(defcsinstr synthvcodistort
  (:type :instrument)
  (:pfields amp freq
            suspct suscenter
            lpfstart lpfend lpfq
            wave widthstart widthend
            rcfstart rcfend
            resstart resend
            diststart distend
            pan1 pan2)
  (:outputs (leftout rightout))
  (:globals
   "giSVCD_Sine ftgen 0, 0, 16384, 10, 1")
  (:body
   "iDur = p3"
   "iAmp = ampdb(p4) * 0.28"
   "iFreq = p5"

   "iSusPcent = p6"
   "if (iSusPcent < 0) then"
   "  iSusPcent = 0"
   "elseif (iSusPcent > 1) then"
   "  iSusPcent = 1"
   "endif"

   "iSusCenterPcent = p7"
   "if (iSusCenterPcent < 0) then"
   "  iSusCenterPcent = 0"
   "elseif (iSusCenterPcent > 1) then"
   "  iSusCenterPcent = 1"
   "endif"

   "iCutoffStart = p8"
   "iCutoffEnd = p9"
   "iLpfQ = p10"
   "if (iLpfQ < 1) then"
   "  iLpfQ = 1"
   "endif"

   "iVcoWaveForm = int(p11)"
   "if (iVcoWaveForm < 1) then"
   "  iVcoWaveForm = 1"
   "elseif (iVcoWaveForm > 3) then"
   "  iVcoWaveForm = 3"
   "endif"

   "iVcoWidthStart = p12"
   "iVcoWidthEnd = p13"

   "iResonCutoffStart = p14"
   "iResonCutoffEnd = p15"

   "iResonStart = p16"
   "iResonEnd = p17"

   "iDistortionStart = p18"
   "iDistortionEnd = p19"

   "ipan1 = p20"
   "ipan2 = p21"

   "iAttack = ((1 - iSusPcent) * iSusCenterPcent) * iDur"
   "iRelease = ((1 - iSusPcent) * (1 - iSusCenterPcent)) * iDur"

   "if (iAttack < 0.001) then"
   "  iAttack = 0.001"
   "endif"
   "if (iRelease < 0.001) then"
   "  iRelease = 0.001"
   "endif"

   "kAmp linen iAmp, iAttack, iDur, iRelease"

   "kVcoWidth linseg iVcoWidthStart, iDur, iVcoWidthEnd"
   "aSig vco 1, iFreq, iVcoWaveForm, kVcoWidth, giSVCD_Sine"

   "kResonCutoff linseg iResonCutoffStart, iDur, iResonCutoffEnd"
   "kReson linseg iResonStart, iDur, iResonEnd"
   "kDistortion linseg iDistortionStart, iDur, iDistortionEnd"

   "aSig lpf18 aSig, kResonCutoff, kReson, kDistortion"

   "kLpfCf linseg iCutoffStart, iDur, iCutoffEnd"
   "aSig lowpass2 aSig, kLpfCf, iLpfQ"

   "aMixSig = aSig * kAmp"
   "aMixSig dcblock2 aMixSig"

   "kPan = line:k(ipan1, p3, ipan2)"
   "aL, aR pan2 aMixSig, kPan"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR")
  (:doc "VCO instrument with proportional macro envelope, resonant lpf18 distortion stage and final low-pass filtering."))


;;; -------------------------------------------------------
;;; PLUCKTAMHATS
;;; -------------------------------------------------------

(defcsinstr plucktamhats
  (:type :instrument)
  (:pfields amp freq pan parm lpfreq)
  (:outputs (leftout rightout))
  (:body
   "iDur = p3"
   "iAmp = ampdb(p4)"
   "iFreq = p5"
   "iPan = p6"
   "iparm = p7"
   "ilp_fq = p8"

   "k1 linseg 1, (.1 * p3), .7, (.5 * p3), .7, (.4 * p3), 0"

   ;; design original conservé
   "a1 pluck iAmp, iFreq,        iFreq,        0, 3, iparm"
   "a2 pluck iAmp, (iFreq*.51),  (iFreq*.51),  0, 3, iparm"
   "a4 pluck iAmp, (iFreq*.24),  (iFreq*.24),  0, 3, iparm"

   "a3 = ((a1 + a2 + a4) * k1)"
   "a6 tone a3, ilp_fq"
   "aMixSig = (a6 * 2)"

   "aL, aR pan2 aMixSig, iPan"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR")
  (:doc "Percussive sound somewhere between tam-tam and high-hat."))


;;; -------------------------------------------------------
;;; PLUCKFORMANT
;;; -------------------------------------------------------

(defcsinstr pluckformant
  (:type :instrument)
  (:pfields amp freq pan
            pluckamp pluckdur
            fmamp fmrise fmdec
            index vibdepth vibrate
            formantamp formantrise)
  (:outputs (leftout rightout))
  (:globals
   "giPF1 ftgen 1, 0, 16384, 10, 1"
   "giPF4 ftgen 4, 0, 2048, 19, .5, .5, 270, .5"
   "giPF7 ftgen 7, 0, 1024, 7, 1, 1024, -1"
   "giPF10 ftgen 10, 0, 2048, 19, .5, .5, 270, .5")
  (:body
   "iAmp = ampdb(p4) / 2"
   "iFreq = p5"

   "iPan = p6"
   "ipluckamp = p7"
   "ipluckdur = p8 * p3"
   "ipluckoff = p3 - ipluckdur"

   "ifmamp = p9"
   "ifmrise = p10 * p3"
   "ifmdec = p11 * p3"
   "ifmoff = p3 - (ifmrise + ifmdec)"
   "index = p12"
   "ivibdepth = p13"
   "ivibrate = p14"
   "iformantamp = p15"
   "iformantrise = p16 * p3"
   "iformantdec = p3 - iformantrise"

   ;; design original conservé
   "kpluck linseg ipluckamp, ipluckdur, 0, ipluckoff, 0"
   "apluck1 pluck iAmp, iFreq, iFreq, 0, 1"
   "apluck2 pluck iAmp, iFreq * 1.003, iFreq * 1.003, 0, 1"
   "apluck = kpluck * (apluck1 + apluck2)"

   "kfm linseg 0, ifmrise, ifmamp, ifmdec, 0, ifmoff, 0"
   "kndx = kfm * index"
   "afm1 foscil iAmp, iFreq, 1, 7, kndx, 1"
   "afm2 foscil iAmp, iFreq * 1.003, 1.003, 2.003, kndx, 1"
   "afm = kfm * (afm1 + afm2)"

   "kfrmnt linseg 0, iformantrise, iformantamp, iformantdec, 0"
   "kvib oscil ivibdepth, ivibrate, 1"
   "afrmnt1 fof iAmp, iFreq + kvib, 650, 0, 40, .003, .017, .007, 4, 1, 7, p3"
   "afrmnt2 fof iAmp, (iFreq * 1.001) + kvib * .009, 650, 0, 40, .003, .017, .007, 10, 1, 7, p3"
   "aformnt = kfrmnt * (afrmnt1 + afrmnt2)"

   "aMixSig = (apluck + afm + aformnt)"

   "aL, aR pan2 aMixSig, iPan"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR")
  (:doc "A pluck that slowly morphs into a vocal, formant derived sound."))(defcsinstr pluckformant
  (:type :instrument)
  (:pfields amp freq pan
            pluckamp pluckdur
            fmamp fmrise fmdec
            index vibdepth vibrate
            formantamp formantrise)
  (:outputs (leftout rightout))
  (:globals
   "giPF1 ftgen 1, 0, 16384, 10, 1"
   "giPF4 ftgen 4, 0, 2048, 19, .5, .5, 270, .5"
   "giPF7 ftgen 7, 0, 1024, 7, 1, 1024, -1"
   "giPF10 ftgen 10, 0, 2048, 19, .5, .5, 270, .5")
  (:body
   "iAmp = ampdb(p4) / 2"
   "iFreq = p5"

   "iPan = p6"
   "ipluckamp = p7"
   "ipluckdur = p8 * p3"
   "ipluckoff = p3 - ipluckdur"

   "ifmamp = p9"
   "ifmrise = p10 * p3"
   "ifmdec = p11 * p3"
   "ifmoff = p3 - (ifmrise + ifmdec)"
   "index = p12"
   "ivibdepth = p13"
   "ivibrate = p14"
   "iformantamp = p15"
   "iformantrise = p16 * p3"
   "iformantdec = p3 - iformantrise"

   "if (ipluckoff < 0) then"
   "  ipluckoff = 0"
   "endif"
   "if (ifmoff < 0) then"
   "  ifmoff = 0"
   "endif"
   "if (iformantdec < 0) then"
   "  iformantdec = 0"
   "endif"

   ;; design original conservé
   "kpluck linseg ipluckamp, ipluckdur, 0, ipluckoff, 0"
   "apluck1 pluck iAmp, iFreq, iFreq, 0, 1"
   "apluck2 pluck iAmp, iFreq * 1.003, iFreq * 1.003, 0, 1"
   "apluck = kpluck * (apluck1 + apluck2)"

   "kfm linseg 0, ifmrise, ifmamp, ifmdec, 0, ifmoff, 0"
   "kndx = kfm * index"
   "afm1 foscil iAmp, iFreq, 1, 7, kndx, 1"
   "afm2 foscil iAmp, iFreq * 1.003, 1.003, 2.003, kndx, 1"
   "afm = kfm * (afm1 + afm2)"

   "kfrmnt linseg 0, iformantrise, iformantamp, iformantdec, 0"
   "kvib oscil ivibdepth, ivibrate, 1"

   ;; seule correction importante : plus d'overlaps
   "afrmnt1 fof iAmp, iFreq + kvib, 650, 0, 40, .003, .017, .007, 20, 1, 7, p3"
   "afrmnt2 fof iAmp, (iFreq * 1.001) + kvib * .009, 650, 0, 40, .003, .017, .007, 20, 1, 7, p3"
   "aformnt = kfrmnt * (afrmnt1 + afrmnt2)"

   "aMixSig = (apluck + afm + aformnt)"

   "aL, aR pan2 aMixSig, iPan"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR")
  (:doc "A pluck that slowly morphs into a vocal, formant derived sound."))


;;; -------------------------------------------------------
;;; PLUCKUNITENVELOPE
;;; -------------------------------------------------------

(defcsinstr pluckunitenvelope
  (:type :instrument)
  (:pfields amp freq pan
            function method parm1 parm2
            suspct suscenter
            lpfstart lpfend lpfq)
  (:outputs (leftout rightout))
  (:body
   "iDur = p3"
   "iAmp = ampdb(p4)"
   "iFreq = p5"
   "iPan = p6"

   "iFunction = p7"
   "iMethod = p8"
   "iParm1 = p9"
   "iParm2 = p10"

   "iSusPcent = p11"
   "iSusCenterPcent = p12"
   "iCutoffStart = p13"
   "iCutoffEnd = p14"
   "kq = p15"

   "iAttack = ((1 - iSusPcent) * iSusCenterPcent) * iDur"
   "iRelease = ((1 - iSusPcent) * (1 - iSusCenterPcent)) * iDur"

   "kAmp linen iAmp, iAttack, iDur, iRelease"
   "kFreq linseg iCutoffStart, iDur, iCutoffEnd"

   ;; design original conservé
   "aSig pluck iAmp, iFreq, iFreq, iFunction, iMethod, iParm1, iParm2"
   "aSig lowpass2 aSig, kFreq, kq"
   "aMixSig = aSig"

   "aL, aR pan2 aMixSig, iPan"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR")
  (:doc "A single pluck with a unit envelope and variable low pass filter."))(defcsinstr pluckunitenvelope
  (:type :instrument)
  (:pfields amp freq pan
            function method parm1 parm2
            suspct suscenter
            lpfstart lpfend lpfq)
  (:outputs (leftout rightout))
  (:body
   "iDur = p3"
   "iAmp = ampdb(p4)"
   "iFreq = p5"
   "iPan = p6"

   "iFunction = p7"
   "iMethod = p8"
   "iParm1 = p9"
   "iParm2 = p10"

   "iSusPcent = p11"
   "iSusCenterPcent = p12"
   "iCutoffStart = p13"
   "iCutoffEnd = p14"
   "kq = p15"

   ;; correction minimale pour method 4
   "if (iMethod == 4 && iParm2 < 1) then"
   "  iParm2 = 1"
   "endif"

   "iAttack = ((1 - iSusPcent) * iSusCenterPcent) * iDur"
   "iRelease = ((1 - iSusPcent) * (1 - iSusCenterPcent)) * iDur"

   "kAmp linen iAmp, iAttack, iDur, iRelease"
   "kFreq linseg iCutoffStart, iDur, iCutoffEnd"

   ;; design original conservé
   "aSig pluck iAmp, iFreq, iFreq, iFunction, iMethod, iParm1, iParm2"
   "aSig lowpass2 aSig, kFreq, kq"
   "aMixSig = aSig"

   "aL, aR pan2 aMixSig, iPan"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR")
  (:doc "A single pluck with a unit envelope and variable low pass filter."))





;;; -------------------------------------------------------
;;; Instruments Stéphane Boussuge collection
;;; -------------------------------------------------------
;;; -------------------------------------------------------
;;; DISKIN2
;;; -------------------------------------------------------

(defcsinstr diskin2
  (:type :instrument)
  (:pfields file amp speed skiptime wrap atk rel pan1 pan2)
  (:outputs (leftout rightout))
  (:body
   "Sfile = p4"
   "kamp = ampdb(p5)"
   "kspeed = p6"
   "iskip = max(0, p7)"
   "iwrap = i(p8)"
   "iAtk = max(0.001, p9)"
   "iRel = max(0.001, p10)"
   "ipan1 = p11"
   "ipan2 = p12"

   "iNchnls filenchnls Sfile"

   "aEnv linen 1, iAtk, p3, iRel"
   "kPan line ipan1, p3, ipan2"

   "if (iNchnls == 1) then"
   "  aSig diskin2 Sfile, kspeed, iskip, iwrap"
   "  aSig = aSig * kamp * aEnv"
   "  aL, aR pan2 aSig, kPan"
   "else"
   "  aL0, aR0 diskin2 Sfile, kspeed, iskip, iwrap"
   "  aL0 = aL0 * kamp * aEnv"
   "  aR0 = aR0 * kamp * aEnv"
   "  aMid = (aL0 + aR0) * 0.5"
   "  aSide = (aL0 - aR0) * 0.5"
   "  aMonoL = aMid * cos(kPan * $M_PI_2)"
   "  aMonoR = aMid * sin(kPan * $M_PI_2)"
   "  aL = (aMonoL * 0.35) + ((aMid + aSide) * 0.65)"
   "  aR = (aMonoR * 0.35) + ((aMid - aSide) * 0.65)"
   "endif"

   "aL dcblock2 aL"
   "aR dcblock2 aR"
   "aL = tanh(aL)"
   "aR = tanh(aR)"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; LPOSCIL
;;; -------------------------------------------------------

(defcsinstr lposcil
  (:type :instrument)
  (:pfields file amp speed loopstart loopend atk rel pan1 pan2)
  (:outputs (leftout rightout))
  (:body
   "Sfile = p4"
   "kAmp = ampdb:k(p5)"
   "kSpeed = p6"
   "kLoopStart = max(0, p7)"
   "kLoopEnd init 0"
   "iAtk = max(0.001, p9)"
   "iRel = max(0.001, p10)"
   "iPan1 = p11"
   "iPan2 = p12"

   ;; file inspection
   "iNchnls filenchnls Sfile"

   ;; deferred loading, no post-normalization
   "if (iNchnls == 1) then"
   "  iFtL ftgenonce 0, 0, 0, -1, Sfile, 0, 0, 1"
   "  iFtR = iFtL"
   "else"
   "  iFtL ftgenonce 0, 0, 0, -1, Sfile, 0, 0, 1"
   "  iFtR ftgenonce 0, 0, 0, -1, Sfile, 0, 0, 2"
   "endif"

   ;; safe loop end handling
   "iTabLen = ftlen(iFtL)"
   "if (p8 <= 0) then"
   "  kLoopEnd = iTabLen"
   "else"
   "  kLoopEnd = p8"
   "endif"
   "kLoopEnd limit kLoopEnd, 1, iTabLen"
   "if (kLoopEnd <= kLoopStart + 2) then"
   "  kLoopEnd = kLoopStart + 2"
   "endif"

   ;; envelope and stereo motion
   "kEnv linen 1, iAtk, p3, iRel"
   "kPan line iPan1, p3, iPan2"

   ;; playback
   "aL lposcil (kAmp * kEnv), kSpeed, kLoopStart, kLoopEnd, iFtL"
   "aR lposcil (kAmp * kEnv), kSpeed, kLoopStart, kLoopEnd, iFtR"

   ;; safety
   "aL dcblock2 aL"
   "aR dcblock2 aR"
   "aL = tanh(aL)"
   "aR = tanh(aR)"

   ;; optional pan narrowing / widening even for mono-derived sources
   "aMid = (aL + aR) * 0.5"
   "aSide = (aL - aR) * 0.5"
   "aPL = aMid + (aSide * (1 - abs((kPan * 2) - 1)))"
   "aPR = aMid - (aSide * (1 - abs((kPan * 2) - 1)))"

   "outleta \"leftout\", aPL"
   "outleta \"rightout\", aPR")
  (:doc "Looping audio file player based on lposcil. The file is passed in :file, loop points are in samples, and mono/stereo files are handled automatically."))



;;; -------------------------------------------------------
;;; CKANALOG adapted from Cook
;;; -------------------------------------------------------

(defcsinstr ckanalog
  (:type :instrument)
  (:pfields amp midi
            porta
            vco2ratio detunehz
            vcf1 vcf2 rez
            wav1 wav2
            lfowave lforate1 lforate2
            ring
            pan1 pan2)
  (:globals
   "giSine      ftgen 1, 0, 8192, 10, 1"
   "giTri       ftgen 2, 0, 4096, 7, 0, 1024, 1, 2048, -1, 1024, 0"
   "giSquare    ftgen 3, 0, 1024, 7, 1, 512, 1, 0, -1, 512, -1"
   "giHalfTri   ftgen 4, 0, 4096, -7, 0, 1024, 0.5, 2048, -0.5, 1024, 0"
   "giFlat      ftgen 5, 0, 1024, 7, 0, 1024, 0"
   "gkckanalog_last init 60")
  (:outputs (leftout rightout))
  (:body
   ;; ----------------------------------------------------
   ;; Base
   ;; ----------------------------------------------------
   "iLevel      = ampdb(p4)"
   "iNote       = cpsmidinn(p5)"
   "iPort       = max(0.0001, i(p6))"
   "iVco2Ratio  = p7"
   "iDet        = p8"
   "iVcf1       = max(20, p9)"
   "iVcf2       = max(20, p10)"
   "iRez        = p11"
   "iWav1       = i(p12)"
   "iWav2       = i(p13)"
   "iLfoWave    = i(p14)"
   "iRate1      = max(0.001, p15)"
   "iRate2      = max(0.001, p16)"
   "kRing       = min(1, max(0, p17))"
   "iMaxd       = 1 / max(0.001, iNote)"

   ;; ----------------------------------------------------
   ;; Simple mono glide memory
   ;; Best for monophonic usage
   ;; ----------------------------------------------------
   "iPrevMidi   = i(gkckanalog_last)"
   "gkckanalog_last = p5"
   "iHoldTime   = max(0.0001, p3 - iPort)"
   "kMidi       linseg iPrevMidi, iPort, p5, iHoldTime, p5"
   "kFreq       = cpsmidinn(kMidi)"

   ;; ----------------------------------------------------
   ;; Filter + amp contour
   ;; ----------------------------------------------------
   "kVcf        expseg iVcf1, p3, iVcf2"
   "kAmpEnv     linseg 0, 0.01, iLevel, max(0.0001, p3 - 0.02), iLevel, 0.01, 0"

   ;; ----------------------------------------------------
   ;; PWM LFOs
   ;; ----------------------------------------------------
   "kPwm1Raw    oscil 0.45, iRate1, iLfoWave"
   "kPw1        = kPwm1Raw + 0.5"
   "kPwm2Raw    oscil 0.45, iRate2, iLfoWave"
   "kPw2        = kPwm2Raw + 0.5"

   ;; ----------------------------------------------------
   ;; Oscillators
   ;; wav: 1=saw, 2=pwm, 3=saw/tri/ramp
   ;; ----------------------------------------------------
   "aVco1       vco kAmpEnv, kFreq, iWav1, kPw1, 1, iMaxd"
   "aVco2       vco kAmpEnv, (kFreq * iVco2Ratio) + iDet, iWav2, kPw2, 1, iMaxd"

   ;; ----------------------------------------------------
   ;; Ringmod crossfade
   ;; ----------------------------------------------------
   "aRing       = aVco1 * aVco2"
   "aMix        = ((aVco1 + aVco2) * (1 - kRing)) + (aRing * kRing)"

   ;; ----------------------------------------------------
   ;; Filter
   ;; ----------------------------------------------------
   "aVcf        rezzy aMix, kVcf, iRez"

   ;; ----------------------------------------------------
   ;; k-rate pan
   ;; ----------------------------------------------------
   "kPanProg    = min(1, max(0, timeinsts() / p3))"
   "kPan        = p18 + ((p19 - p18) * kPanProg)"

   "aL, aR      pan2 aVcf, kPan"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR")
  (:doc "Cook-style analog synth: 2 VCO, 2 LFO PWM, glide, ringmod, resonant filter, stereo k-rate pan. Best used monophonically for authentic glide behaviour."))

;;; -------------------------------------------------------
;;; CMJANALOGPAD (From Comajuncosas)
;;; -------------------------------------------------------

(defcsinstr cmjanalogpad
  (:type :instrument)
  (:pfields amp midi pan1 pan2)
  (:outputs (leftout rightout))
  (:body
   ;; ----------------------------------------------------
   ;; Original patch core
   ;; ----------------------------------------------------
   "aout        init 0"
   "kdeclick    linen 1, 0.01, p3, 0.01"
   "kampdb      = ampdb(p4)"

   ;; ----------------------------------------------------
   ;; Cascaded FM section
   ;; ----------------------------------------------------
   "ifdbk       = 0.6"
   "iamp        = 1"
   "ipor        = cpsmidinn(p5)"
   "imod1       = 2 * ipor"
   "indx1       = 3"
   "imod2       = 1.33 * ipor"
   "indx2       = 3"

   "kndx1       linseg 0, p3/3, indx1, p3/2, indx1"
   "kndx2       linseg 0, p3/2, indx2, p3/3, indx2"

   "amod1       oscil3 imod1 * kndx1, imod1, 1"
   "amod2       oscil3 imod2 * kndx2, imod2 + amod1, 1"
   "apor        oscil3 iamp/2, ipor + amod2, 1"
   "kamp        linen 1, p3/3, p3, p3/3"

   ;; ----------------------------------------------------
   ;; Analog LPF section
   ;; ----------------------------------------------------
   "kfco        linseg 200, p3/4, 10000, p3/4, 4000, p3/2, 50"
   "kres        linseg 0, p3/3, 0, p3/3, 0.5, p3/3, 0.2"

   "alpf0       moogvcf (apor * kamp) - (ifdbk * aout), kfco, kres"
   "adist       = 0.5 * tanh(apor * kamp)"
   "alpf1       tonex -adist, sr/4"
   "alpf2       tonex alpf1, sr/8"
   "alpf3       tonex -alpf2, sr/16"
   "alpf4       tonex alpf3, sr/32"

   ;; ----------------------------------------------------
   ;; Multiband waveshaper section
   ;; ----------------------------------------------------
   "awsh1       table3 0.5 + alpf1, 2, 1"
   "awsh2       table3 0.5 + alpf2, 3, 1"
   "awsh3       table3 0.5 + alpf3, 4, 1"
   "awsh4       table3 0.5 + alpf4, 5, 1"

   "aout        = awsh1 + awsh2 + awsh3 + awsh4"

   ;; ----------------------------------------------------
   ;; Output + stereo pan
   ;; Original revised patch:
   ;; out aout*0.1*kdeclick
   ;; Here we keep that and add ampdb(p4)
   ;; ----------------------------------------------------
   "asig        = aout * 0.1 * kdeclick * kampdb"

   "kpanprog    = min(1, max(0, timeinsts() / p3))"
   "kpan        = p6 + ((p7 - p6) * kpanprog)"

   "aL, aR      pan2 asig, kpan"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR")
  (:doc "AnalogPad adapted faithfully from Comajuncosas AnalogPad CSD version, using MIDI notes and k-rate stereo panning."))


;;; -------------------------------------------------------
;;; MINCER1
;;; -------------------------------------------------------

(defcsinstr mincer1
  (:type :instrument)
  (:pfields amp
            file
            pos1 pos2
            pitch
            lock
            fftsize decim
            pan1 pan2)
  (:outputs (leftout rightout))
  (:body
   ;; ----------------------------------------------------
   ;; Core params
   ;; ----------------------------------------------------
   "kamp       = ampdb(p4)"
   "Sfile      = p5"
   "iPos1      = i(p6)"
   "iPos2      = i(p7)"
   "kPitch     = p8"
   "kLock      = p9"
   "iFftSize   = i(p10)"
   "iDecim     = i(p11)"
   "kPan       = line:k(p12, p3, p13)"

   ;; ----------------------------------------------------
   ;; Load soundfile into a function table once
   ;; ----------------------------------------------------
   "iTab       ftgenonce 0, 0, 0, 1, Sfile, 0, 0, 0"

   ;; ----------------------------------------------------
   ;; Time pointer in seconds
   ;; mincer expects an audio-rate pointer
   ;; ----------------------------------------------------
   "aTime      line iPos1, p3, iPos2"

   ;; ----------------------------------------------------
   ;; Mincer
   ;; ----------------------------------------------------
   "aSig       mincer aTime, kamp, kPitch, iTab, kLock, iFftSize, iDecim"

   ;; ----------------------------------------------------
   ;; Stereo output with k-rate pan
   ;; ----------------------------------------------------
   "aOutL, aOutR pan2 aSig, kPan"
   "outleta \"leftout\", aOutL"
   "outleta \"rightout\", aOutR")
  (:doc "Mincer1: mono file playback via ftgenonce + mincer, with k-rate panning."))



;;; -------------------------------------------------------
;;; MINCER2
;;; -------------------------------------------------------

(defcsinstr mincer2
  (:type :instrument)
  (:pfields amp
            file
            startpos
            speed
            pitch
            lock
            fftsize
            decim
            freeze
            jitterdepth
            jitterrate
            att
            hold
            dec
            sus
            rel
            cutoff
            res
            filttype
            panmode
            pan1
            pan2
            panrate
            pandepth)
  (:outputs (leftout rightout))
  (:body
   ;; ----------------------------------------------------
   ;; Core params
   ;; ----------------------------------------------------
   "kamp         = ampdb(p4)"
   "Sfile        = p5"
   "iStartPos    = i(p6)"
   "kSpeed       = p7"
   "kPitch       = p8"
   "kLock        = p9"
   "iFftSize     = i(p10)"
   "iDecim       = i(p11)"
   "kFreeze      = p12"
   "kJitDepth    = max(0, p13)"
   "kJitRate     = max(0.001, p14)"

   ;; ----------------------------------------------------
   ;; Amp envelope AHDSR
   ;; ----------------------------------------------------
   "iAtt         = max(0.0001, i(p15))"
   "iHold        = max(0.0,    i(p16))"
   "iDec         = max(0.0001, i(p17))"
   "iSus         = i(p18)"
   "iRel         = max(0.0001, i(p19))"
   "aAmpEnv      linsegr 0, iAtt, 1, iHold, 1, iDec, iSus, iRel, 0"

   ;; ----------------------------------------------------
   ;; Post-filter params
   ;; filttype: 0=LP 1=BP 2=HP
   ;; ----------------------------------------------------
   "kCut         = max(20, p20)"
   "kRes         = min(0.98, max(0.0, p21))"
   "iFiltType    = i(p22)"

   ;; ----------------------------------------------------
   ;; Pan control
   ;; panmode:
   ;; 0 = manual interpolated pan
   ;; 1 = autopan (sine LFO)
   ;; 2 = random pan (randomi)
   ;; ----------------------------------------------------
   "iPanMode     = i(p23)"
   "kPan1        = p24"
   "kPan2        = p25"
   "kPanRate     = max(0.001, p26)"
   "kPanDepth    = min(1, max(0, p27))"

   ;; ----------------------------------------------------
   ;; Load soundfile
   ;; ----------------------------------------------------
   "iTab         ftgenonce 0, 0, 0, 1, Sfile, 0, 0, 0"

   ;; ----------------------------------------------------
   ;; Time pointer in seconds
   ;; speed-driven scan from start position
   ;; freeze = 1 => pointer stopped
   ;; ----------------------------------------------------
   "kBaseTime    init iStartPos"
   "if (kFreeze < 0.5) then"
   "  kBaseTime = kBaseTime + (kSpeed / kr)"
   "endif"

   ;; small jitter around the reading position
   "kJitter      randomi -kJitDepth, kJitDepth, kJitRate"
   "kReadTime    = kBaseTime + kJitter"
   "aTime        interp kReadTime"

   ;; ----------------------------------------------------
   ;; Mincer
   ;; ----------------------------------------------------
   "aSig         mincer aTime, kamp, kPitch, iTab, kLock, iFftSize, iDecim"

   ;; ----------------------------------------------------
   ;; Amplitude envelope
   ;; ----------------------------------------------------
   "aEnvSig      = aSig * aAmpEnv"

   ;; ----------------------------------------------------
   ;; Post filter
   ;; ----------------------------------------------------
   "aLP          moogladder aEnvSig, kCut, kRes"
   "aHP          = aEnvSig - aLP"
   "kBW          = max(20, (1.01 - kRes) * kCut)"
   "aBP          reson aEnvSig, kCut, kBW, 1"

   "if (iFiltType == 0) then"
   "  aFilt = aLP"
   "elseif (iFiltType == 1) then"
   "  aFilt = aBP"
   "else"
   "  aFilt = aHP"
   "endif"

   ;; ----------------------------------------------------
   ;; Pan generator
   ;; ----------------------------------------------------
   "kPanProg     = min(1, max(0, timeinsts() / p3))"
   "kPanLine     = kPan1 + ((kPan2 - kPan1) * kPanProg)"
   "kPanAutoRaw  lfo kPanDepth, kPanRate, 0"
   "kPanAuto     = 0.5 + (kPanAutoRaw * 0.5)"
   "kPanRnd      randomi kPan1, kPan2, kPanRate"

   "if (iPanMode == 0) then"
   "  kPan = kPanLine"
   "elseif (iPanMode == 1) then"
   "  kPan = kPanAuto"
   "else"
   "  kPan = kPanRnd"
   "endif"

   "kPan         = min(1, max(0, kPan))"

   ;; ----------------------------------------------------
   ;; Stereo out
   ;; ----------------------------------------------------
   "aOutL, aOutR pan2 aFilt, kPan"
   "outleta \"leftout\", aOutL"
   "outleta \"rightout\", aOutR")
  (:doc "Mincer2: file-based mincer instrument with AHDSR amplitude envelope, speed scan, freeze, position jitter, post-filter, and manual/autopan/random k-rate panning."))



;;; -------------------------------------------------------
;;; MINCER3
;;; -------------------------------------------------------

(defcsinstr mincer3
  (:type :instrument)
  (:pfields amp
            file
            startpos
            speed
            pitch
            lock
            fftsize
            decim
            freeze
            jitterdepth
            jitterrate
            looplen
            xfade
            att
            hold
            dec
            sus
            rel
            cutoff
            res
            filttype
            panmode
            pan1
            pan2
            panrate
            pandepth)
  (:outputs (leftout rightout))
  (:body
   ;; ----------------------------------------------------
   ;; Core params
   ;; ----------------------------------------------------
   "kamp         = ampdb(p4)"
   "Sfile        = p5"
   "iStartPos    = i(p6)"
   "kSpeed       = p7"
   "kPitch       = p8"
   "kLock        = p9"
   "iFftSize     = i(p10)"
   "iDecim       = i(p11)"
   "kFreeze      = p12"
   "kJitDepth    = max(0, p13)"
   "kJitRate     = max(0.001, p14)"
   "kLoopLen     = max(0.001, p15)"
   "kXfade       = max(0.0001, min(kLoopLen * 0.5, p16))"

   ;; ----------------------------------------------------
   ;; Amp envelope AHDSR
   ;; ----------------------------------------------------
   "iAtt         = max(0.0001, i(p17))"
   "iHold        = max(0.0,    i(p18))"
   "iDec         = max(0.0001, i(p19))"
   "iSus         = i(p20)"
   "iRel         = max(0.0001, i(p21))"
   "aAmpEnv      linsegr 0, iAtt, 1, iHold, 1, iDec, iSus, iRel, 0"

   ;; ----------------------------------------------------
   ;; Post-filter params
   ;; filttype: 0=LP 1=BP 2=HP
   ;; ----------------------------------------------------
   "kCut         = max(20, p22)"
   "kRes         = min(0.98, max(0.0, p23))"
   "iFiltType    = i(p24)"

   ;; ----------------------------------------------------
   ;; Pan control
   ;; panmode:
   ;; 0 = manual interpolated pan
   ;; 1 = autopan
   ;; 2 = random pan
   ;; ----------------------------------------------------
   "iPanMode     = i(p25)"
   "kPan1        = p26"
   "kPan2        = p27"
   "kPanRate     = max(0.001, p28)"
   "kPanDepth    = min(1, max(0, p29))"

   ;; ----------------------------------------------------
   ;; Load soundfile
   ;; ----------------------------------------------------
   "iTab         ftgenonce 0, 0, 0, 1, Sfile, 0, 0, 0"

   ;; ----------------------------------------------------
   ;; Local loop phase
   ;; We accumulate a local time pointer, then wrap it
   ;; inside a loop window of length kLoopLen.
   ;; ----------------------------------------------------
   "kPhase       init 0"
   "if (kFreeze < 0.5) then"
   "  kPhase = kPhase + (kSpeed / kr)"
   "endif"

   ;; jitter around read position
   "kJitter      randomi -kJitDepth, kJitDepth, kJitRate"

   ;; wrapped phase in loop window
   "kWrap1       = frac(kPhase / kLoopLen) * kLoopLen"
   "kWrap2       = frac((kPhase + kXfade) / kLoopLen) * kLoopLen"

   ;; two read positions for crossfade
   "kPos1        = iStartPos + kWrap1 + kJitter"
   "kPos2        = iStartPos + kWrap2 + kJitter"

   "aTime1       interp kPos1"
   "aTime2       interp kPos2"

   ;; ----------------------------------------------------
   ;; Two mincer readers for smooth loop crossfade
   ;; ----------------------------------------------------
   "aSig1        mincer aTime1, kamp, kPitch, iTab, kLock, iFftSize, iDecim"
   "aSig2        mincer aTime2, kamp, kPitch, iTab, kLock, iFftSize, iDecim"

   ;; crossfade weight based on loop phase position
   "kXPos        = frac(kPhase / kLoopLen) * kLoopLen"
   "kFade        = min(1, max(0, kXPos / kXfade))"
   "if (kXPos < kXfade) then"
   "  kMixA = kFade"
   "  kMixB = 1 - kFade"
   "elseif (kXPos > (kLoopLen - kXfade)) then"
   "  kFade2 = (kXPos - (kLoopLen - kXfade)) / kXfade"
   "  kMixA = 1 - kFade2"
   "  kMixB = kFade2"
   "else"
   "  kMixA = 1"
   "  kMixB = 0"
   "endif"

   "aSig         = (aSig1 * kMixA) + (aSig2 * kMixB)"

   ;; ----------------------------------------------------
   ;; Amplitude envelope
   ;; ----------------------------------------------------
   "aEnvSig      = aSig * aAmpEnv"

   ;; ----------------------------------------------------
   ;; Post filter
   ;; ----------------------------------------------------
   "aLP          moogladder aEnvSig, kCut, kRes"
   "aHP          = aEnvSig - aLP"
   "kBW          = max(20, (1.01 - kRes) * kCut)"
   "aBP          reson aEnvSig, kCut, kBW, 1"

   "if (iFiltType == 0) then"
   "  aFilt = aLP"
   "elseif (iFiltType == 1) then"
   "  aFilt = aBP"
   "else"
   "  aFilt = aHP"
   "endif"

   ;; ----------------------------------------------------
   ;; Pan generator
   ;; ----------------------------------------------------
   "kPanProg     = min(1, max(0, timeinsts() / p3))"
   "kPanLine     = kPan1 + ((kPan2 - kPan1) * kPanProg)"
   "kPanAutoRaw  lfo kPanDepth, kPanRate, 0"
   "kPanAuto     = 0.5 + (kPanAutoRaw * 0.5)"
   "kPanRnd      randomi kPan1, kPan2, kPanRate"

   "if (iPanMode == 0) then"
   "  kPan = kPanLine"
   "elseif (iPanMode == 1) then"
   "  kPan = kPanAuto"
   "else"
   "  kPan = kPanRnd"
   "endif"

   "kPan         = min(1, max(0, kPan))"

   ;; ----------------------------------------------------
   ;; Stereo out
   ;; ----------------------------------------------------
   "aOutL, aOutR pan2 aFilt, kPan"
   "outleta \"leftout\", aOutL"
   "outleta \"rightout\", aOutR")
  (:doc "Mincer3: file-based mincer instrument with local loop window, crossfaded loop read, AHDSR amplitude envelope, speed, freeze, jitter, post-filter, and manual/autopan/random k-rate panning."))



;;; -------------------------------------------------------
;;; ANALOG1
;;; -------------------------------------------------------

(defcsinstr analog1
  (:type :instrument)
  (:pfields amp midi wave pw
            att hold dec sus rel
            cutoff res filttype
            pan1 pan2)
  (:outputs (leftout rightout))
  (:body

   ;; ----------------------------------------------------
   ;; Core params
   ;; ----------------------------------------------------
   "kamp     = ampdb(p4)"
   "kcps     = mtof(p5)"
   "iwave    = i(p6)"
   "kpw      = p7"

   ;; ----------------------------------------------------
   ;; AHDSR
   ;; ----------------------------------------------------
   "iAtt     = max(0.0001, i(p8))"
   "iHold    = max(0.0,    i(p9))"
   "iDec     = max(0.0001, i(p10))"
   "iSus     =          p11"
   "iRel     = max(0.0001, i(p12))"

   ;; ----------------------------------------------------
   ;; Filter
   ;; ----------------------------------------------------
   "kCut1    = max(20, p13)"
   "kRes     = max(0.01, p14)"
   "iFType   = i(p15)"

   ;; ----------------------------------------------------
   ;; Pan
   ;; ----------------------------------------------------
   "kPan     = line:k(p16, p3, p17)"

   ;; ----------------------------------------------------
   ;; Oscillator
   ;; iwave examples:
   ;; 0 = saw-ish default for vco2 family
   ;; 2 = pulse-like mode
   ;; kpwm mainly relevant for pulse usage
   ;; ----------------------------------------------------
   "aOsc     vco2 kamp, kcps, iwave, kpw"

   ;; ----------------------------------------------------
   ;; AHDSR envelope
   ;; ----------------------------------------------------
   "aEnv     linsegr 0, iAtt, 1, iHold, 1, iDec, iSus, iRel, 0"

   ;; small pre-filter gain shaping
   "aPre     = aOsc * aEnv"

   ;; ----------------------------------------------------
   ;; Filter selection
   ;; 0 = LP
   ;; 1 = BP
   ;; 2 = HP
   ;; ----------------------------------------------------
   "aLP      tone   aPre, kCut1"
   "kBW      = max(20, kCut1 / kRes)"
   "aBP      reson  aPre, kCut1, kBW, 1"
   "aHP      atone  aPre, kCut1"

   "if (iFType == 0) then"
   "  aFilt = aLP"
   "elseif (iFType == 1) then"
   "  aFilt = aBP"
   "else"
   "  aFilt = aHP"
   "endif"

   ;; ----------------------------------------------------
   ;; Stereo out
   ;; ----------------------------------------------------
   "aOutL, aOutR pan2 aFilt, kPan"
   "outleta \"leftout\", aOutL"
   "outleta \"rightout\", aOutR")
  (:doc "Analog1: single-vco2 synth with AHDSR and selectable LP/BP/HP filter."))



;;; -------------------------------------------------------
;;; ANALOG1B
;;; -------------------------------------------------------

(defcsinstr analog1b
  (:type :instrument)
  (:pfields amp midi wave pw porta
            att hold dec sus rel
            fatt fhold fdec fsus frel
            cutoff envamt res filttype
            lforate lfodepth drive
            pan1 pan2)
  (:outputs (leftout rightout))
  (:body
   "kamp        = ampdb(p4)"
   "kPorta      = max(0.0001, p8)"
   "kMidi       portk p5, kPorta"
   "kcps        = cpsmidinn(kMidi)"
   "iwave       = i(p6)"
   "kpw         = p7"

   "iAtt        = max(0.0001, i(p9))"
   "iHold       = max(0.0,    i(p10))"
   "iDec        = max(0.0001, i(p11))"
   "iSus        = i(p12)"
   "iRel        = max(0.0001, i(p13))"
   "aAmpEnv     linsegr 0, iAtt, 1, iHold, 1, iDec, iSus, iRel, 0"

   "iFAtt       = max(0.0001, i(p14))"
   "iFHold      = max(0.0,    i(p15))"
   "iFDec       = max(0.0001, i(p16))"
   "iFSus       = i(p17)"
   "iFRel       = max(0.0001, i(p18))"
   "aFiltEnv    linsegr 0, iFAtt, 1, iFHold, 1, iFDec, iFSus, iFRel, 0"
   "kFiltEnv    downsamp aFiltEnv"

   "kBaseCut    = max(20, p19)"
   "kEnvAmt     = p20"
   "kRes        = max(0.1, p21)"
   "iFType      = i(p22)"

   "kLfoRate    = max(0, p23)"
   "kLfoDepth   = max(0, p24)"
   "kDrive      = max(1, p25)"
   "kPan        = line:k(p26, p3, p27)"

   "aOsc        vco2 kamp, kcps, iwave, kpw"
   "aDriven     = tanh(aOsc * aAmpEnv * kDrive)"

   "kLfo        lfo kLfoDepth, kLfoRate, 0"
   "kCutRaw     = kBaseCut + (kFiltEnv * kEnvAmt) + kLfo"
   "kCut        = limit(kCutRaw, 20, 18000)"
   "kBW         = max(20, kCut / kRes)"

   "aLP         tone  aDriven, kCut"
   "aBP         reson aDriven, kCut, kBW, 1"
   "aHP         atone aDriven, kCut"

   "if (iFType == 0) then"
   "  aFilt = aLP"
   "elseif (iFType == 1) then"
   "  aFilt = aBP"
   "else"
   "  aFilt = aHP"
   "endif"

   "aOutL, aOutR pan2 aFilt, kPan"
   "outleta \"leftout\", aOutL"
   "outleta \"rightout\", aOutR")
  (:doc "Analog1b: one-vco2 synth with amp/filter envelopes, drive, selectable LP/BP/HP filter, cutoff LFO and portamento."))



;;; -------------------------------------------------------
;;; ANALOG1C
;;; -------------------------------------------------------

(defcsinstr analog1c
  (:type :instrument)
  (:pfields amp midi wave
            pw pwmrate pwmdepth
            porta
            submix noisemix
            att hold dec sus rel
            fatt fhold fdec fsus frel
            cutoff envamt res filttype
            penvamt patt phold pdec
            lforate lfodepth
            drive
            pan1 pan2)
  (:outputs (leftout rightout))
  (:body
   "kamp        = ampdb(p4)"
   "kMidiBase   portk p5, max(0.0001, p10)"

   ;; pitch env in semitones
   "iPEnvAmt    = i(p27)"
   "iPAtt       = max(0.0001, i(p28))"
   "iPHold      = max(0.0,    i(p29))"
   "iPDec       = max(0.0001, i(p30))"
   "kPitchEnv   linseg iPEnvAmt, iPAtt, iPEnvAmt, iPHold, iPEnvAmt, iPDec, 0"

   "kMidi       = kMidiBase + kPitchEnv"
   "kcps        = cpsmidinn(kMidi)"
   "iwave       = i(p6)"

   ;; PWM
   "kPwBase     = min(0.98, max(0.02, p7))"
   "kPwmRate    = max(0, p8)"
   "kPwmDepth   = max(0, p9)"
   "kPwmLfo     lfo kPwmDepth, kPwmRate, 0"
   "kPw         = min(0.98, max(0.02, kPwBase + kPwmLfo))"

   ;; mix
   "kSubMix     = min(1, max(0, p11))"
   "kNoiseMix   = min(1, max(0, p12))"

   ;; amp env
   "iAtt        = max(0.0001, i(p13))"
   "iHold       = max(0.0,    i(p14))"
   "iDec        = max(0.0001, i(p15))"
   "iSus        = i(p16)"
   "iRel        = max(0.0001, i(p17))"
   "aAmpEnv     linsegr 0, iAtt, 1, iHold, 1, iDec, iSus, iRel, 0"

   ;; filter env
   "iFAtt       = max(0.0001, i(p18))"
   "iFHold      = max(0.0,    i(p19))"
   "iFDec       = max(0.0001, i(p20))"
   "iFSus       = i(p21)"
   "iFRel       = max(0.0001, i(p22))"
   "aFiltEnv    linsegr 0, iFAtt, 1, iFHold, 1, iFDec, iFSus, iFRel, 0"
   "kFiltEnv    downsamp aFiltEnv"

   ;; filter / modulation
   "kBaseCut    = max(20, p23)"
   "kEnvAmt     = p24"
   "kRes        = min(0.98, max(0.0, p25))"
   "iFType      = i(p26)"
   "kLfoRate    = max(0, p31)"
   "kLfoDepth   = max(0, p32)"
   "kDrive      = max(1, p33)"
   "kPan        = line:k(p34, p3, p35)"

   ;; oscillators
   "aMain       vco2 kamp, kcps, iwave, kPw"
   "aSub        vco2 (kamp * kSubMix), kcps * 0.5, 2, 0.5"
   "aNoise      rand (kamp * kNoiseMix)"

   "kMainScale  = max(0.2, 1 - ((kSubMix * 0.5) + (kNoiseMix * 0.5)))"
   "aMix        = (aMain * kMainScale) + aSub + aNoise"

   ;; drive
   "aDriven     = tanh(aMix * aAmpEnv * kDrive)"

   ;; cutoff modulation
   "kLfo        lfo kLfoDepth, kLfoRate, 0"
   "kCutRaw     = kBaseCut + (kFiltEnv * kEnvAmt) + kLfo"
   "kCut        = max(20, min(18000, kCutRaw))"

   ;; filters
   "aLP         moogladder aDriven, kCut, kRes"
   "aHP         = aDriven - aLP"
   "kBW         = max(20, (1.01 - kRes) * kCut)"
   "aBP         reson aDriven, kCut, kBW, 1"

   ;; select filter
   "if (iFType == 0) then"
   "  aFilt = aLP"
   "elseif (iFType == 1) then"
   "  aFilt = aBP"
   "else"
   "  aFilt = aHP"
   "endif"

   ;; out
   "aOutL, aOutR pan2 aFilt, kPan"
   "outleta \"leftout\", aOutL"
   "outleta \"rightout\", aOutR")
  (:doc "Analog1c: vco2 synth with sub oscillator, noise, PWM, amp/filter AHDSR, pitch envelope, selectable LP/BP/HP filter, drive, filter LFO and portamento."))



;;; -------------------------------------------------------
;;; ANALOG2
;;; -------------------------------------------------------

(defcsinstr analog2
  (:type :instrument)
  (:pfields amp midi
            wave1 pw1
            wave2 pw2 detune
            att hold dec sus rel
            cutoff res filttype
            pan1 pan2)
  (:outputs (leftout rightout))
  (:body

   ;; ----------------------------------------------------
   ;; Core
   ;; ----------------------------------------------------
   "kamp        = ampdb(p4)"
   "kcps1       = mtof(p5)"
   "iwave1      = i(p6)"
   "kpw1        = p7"
   "iwave2      = i(p8)"
   "kpw2        = p9"
   "kDetune     = p10"
   "kcps2       = kcps1 * pow(2, kDetune / 1200)"

   ;; ----------------------------------------------------
   ;; AHDSR
   ;; ----------------------------------------------------
   "iAtt        = max(0.0001, i(p11))"
   "iHold       = max(0.0,    i(p12))"
   "iDec        = max(0.0001, i(p13))"
   "iSus        = i(p14)"
   "iRel        = max(0.0001, i(p15))"
   "aEnv        linsegr 0, iAtt, 1, iHold, 1, iDec, iSus, iRel, 0"

   ;; ----------------------------------------------------
   ;; Filter
   ;; ----------------------------------------------------
   "kCut        = max(20, p16)"
   "kRes        = max(0.1, p17)"
   "iFType      = i(p18)"

   ;; ----------------------------------------------------
   ;; Pan
   ;; ----------------------------------------------------
   "kPan        = line:k(p19, p3, p20)"

   ;; ----------------------------------------------------
   ;; Oscillators
   ;; ----------------------------------------------------
   "aOsc1       vco2 kamp, kcps1, iwave1, kpw1"
   "aOsc2       vco2 kamp, kcps2, iwave2, kpw2"
   "aMix        = (aOsc1 + aOsc2) * 0.5"

   ;; ----------------------------------------------------
   ;; Envelope
   ;; ----------------------------------------------------
   "aPre        = aMix * aEnv"

   ;; ----------------------------------------------------
   ;; Filter bank
   ;; 0 = LP
   ;; 1 = BP
   ;; 2 = HP
   ;; ----------------------------------------------------
   "aLP         tone  aPre, kCut"
   "kBW         = max(20, kCut / kRes)"
   "aBP         reson aPre, kCut, kBW, 1"
   "aHP         atone aPre, kCut"

   "if (iFType == 0) then"
   "  aFilt = aLP"
   "elseif (iFType == 1) then"
   "  aFilt = aBP"
   "else"
   "  aFilt = aHP"
   "endif"

   ;; ----------------------------------------------------
   ;; Output
   ;; ----------------------------------------------------
   "aOutL, aOutR pan2 aFilt, kPan"
   "outleta \"leftout\", aOutL"
   "outleta \"rightout\", aOutR")
  (:doc "Analog2: two-vco2 synth with selectable LP/BP/HP filter, AHDSR envelope, and VCO2 detune in cents."))



;;; -------------------------------------------------------
;;; ANALOG2B
;;; -------------------------------------------------------

(defcsinstr analog2b
  (:type :instrument)
  (:pfields amp midi
            wave1 pw1 pwmrate1 pwmdepth1
            wave2 pw2 pwmrate2 pwmdepth2
            vco2interval detune mix2
            porta
            att hold dec sus rel
            fatt fhold fdec fsus frel
            cutoff envamt res filttype
            lforate lfodepth
            drive
            pan1 pan2)
  (:outputs (leftout rightout))
  (:body

   ;; ----------------------------------------------------
   ;; Core pitch / portamento
   ;; ----------------------------------------------------
   "kamp        = ampdb(p4)"
   "kMidiBase   portk p5, max(0.0001, p17)"

   ;; ----------------------------------------------------
   ;; Osc 1 PWM
   ;; ----------------------------------------------------
   "iwave1      = i(p6)"
   "kPw1Base    = min(0.98, max(0.02, p7))"
   "kPwmRate1   = max(0, p8)"
   "kPwmDepth1  = max(0, p9)"
   "kPwmLfo1    lfo kPwmDepth1, kPwmRate1, 0"
   "kPw1        = min(0.98, max(0.02, kPw1Base + kPwmLfo1))"

   ;; ----------------------------------------------------
   ;; Osc 2 PWM / interval / detune
   ;; ----------------------------------------------------
   "iwave2      = i(p10)"
   "kPw2Base    = min(0.98, max(0.02, p11))"
   "kPwmRate2   = max(0, p12)"
   "kPwmDepth2  = max(0, p13)"
   "kPwmLfo2    lfo kPwmDepth2, kPwmRate2, 0"
   "kPw2        = min(0.98, max(0.02, kPw2Base + kPwmLfo2))"

   "kInterval   = p14"
   "kDetune     = p15"
   "kMix2       = min(1, max(0, p16))"

   "kcps1       = cpsmidinn(kMidiBase)"
   "kcps2       = cpsmidinn(kMidiBase + kInterval) * pow(2, kDetune / 1200)"

   ;; ----------------------------------------------------
   ;; Amp envelope AHDSR
   ;; ----------------------------------------------------
   "iAtt        = max(0.0001, i(p18))"
   "iHold       = max(0.0,    i(p19))"
   "iDec        = max(0.0001, i(p20))"
   "iSus        = i(p21)"
   "iRel        = max(0.0001, i(p22))"
   "aAmpEnv     linsegr 0, iAtt, 1, iHold, 1, iDec, iSus, iRel, 0"

   ;; ----------------------------------------------------
   ;; Filter envelope AHDSR
   ;; ----------------------------------------------------
   "iFAtt       = max(0.0001, i(p23))"
   "iFHold      = max(0.0,    i(p24))"
   "iFDec       = max(0.0001, i(p25))"
   "iFSus       = i(p26)"
   "iFRel       = max(0.0001, i(p27))"
   "aFiltEnv    linsegr 0, iFAtt, 1, iFHold, 1, iFDec, iFSus, iFRel, 0"
   "kFiltEnv    downsamp aFiltEnv"

   ;; ----------------------------------------------------
   ;; Filter / modulation / drive / pan
   ;; ----------------------------------------------------
   "kBaseCut    = max(20, p28)"
   "kEnvAmt     = p29"
   "kRes        = min(0.98, max(0.0, p30))"
   "iFType      = i(p31)"

   "kLfoRate    = max(0, p32)"
   "kLfoDepth   = max(0, p33)"
   "kDrive      = max(1, p34)"
   "kPan        = line:k(p35, p3, p36)"

   ;; ----------------------------------------------------
   ;; Oscillators and mix
   ;; ----------------------------------------------------
   "aOsc1       vco2 kamp, kcps1, iwave1, kPw1"
   "aOsc2       vco2 kamp, kcps2, iwave2, kPw2"

   "kMix1       = 1 - kMix2"
   "aMix        = (aOsc1 * kMix1) + (aOsc2 * kMix2)"

   ;; ----------------------------------------------------
   ;; Pre-filter drive
   ;; ----------------------------------------------------
   "aDriven     = tanh(aMix * aAmpEnv * kDrive)"

   ;; ----------------------------------------------------
   ;; Cutoff modulation
   ;; ----------------------------------------------------
   "kLfo        lfo kLfoDepth, kLfoRate, 0"
   "kCutRaw     = kBaseCut + (kFiltEnv * kEnvAmt) + kLfo"
   "kCut        = max(20, min(18000, kCutRaw))"

   ;; ----------------------------------------------------
   ;; Filter bank
   ;; 0 = LP / 1 = BP / 2 = HP
   ;; ----------------------------------------------------
   "aLP         moogladder aDriven, kCut, kRes"
   "aHP         = aDriven - aLP"
   "kBW         = max(20, (1.01 - kRes) * kCut)"
   "aBP         reson aDriven, kCut, kBW, 1"

   "if (iFType == 0) then"
   "  aFilt = aLP"
   "elseif (iFType == 1) then"
   "  aFilt = aBP"
   "else"
   "  aFilt = aHP"
   "endif"

   ;; ----------------------------------------------------
   ;; Output
   ;; ----------------------------------------------------
   "aOutL, aOutR pan2 aFilt, kPan"
   "outleta \"leftout\", aOutL"
   "outleta \"rightout\", aOutR")
  (:doc "Analog2b: dual-vco2 synth with independent PWM, VCO2 interval and detune, amp/filter AHDSR, selectable LP/BP/HP filter, drive, cutoff LFO and portamento."))




;;; -------------------------------------------------------
;;; ANALOG2C
;;; -------------------------------------------------------

(defcsinstr analog2c
  (:type :instrument)
  (:pfields amp midi
            wave1 pw1 pwmrate1 pwmdepth1
            wave2 pw2 pwmrate2 pwmdepth2
            vco2interval detune mix2
            porta
            submix subwave
            noisemix
            att hold dec sus rel
            fatt fhold fdec fsus frel
            cutoff envamt res filttype
            penvamt patt phold pdec
            lforate lfodepth
            drive
            pan1 pan2)
  (:outputs (leftout rightout))
  (:body
   ;; ----------------------------------------------------
   ;; Core pitch / portamento
   ;; ----------------------------------------------------
   "kamp        = ampdb(p4)"
   "kPorta      = max(0.0001, p17)"
   "kMidiBase   portk p5, kPorta"

   ;; ----------------------------------------------------
   ;; Pitch envelope (semitones)
   ;; ----------------------------------------------------
   "iPEnvAmt    = i(p35)"
   "iPAtt       = max(0.0001, i(p36))"
   "iPHold      = max(0.0,    i(p37))"
   "iPDec       = max(0.0001, i(p38))"
   "kPitchEnv   linseg iPEnvAmt, iPAtt, iPEnvAmt, iPHold, iPEnvAmt, iPDec, 0"

   "kMidi       = kMidiBase + kPitchEnv"
   "kcps1       = cpsmidinn(kMidi)"
   "kcps2       = cpsmidinn(kMidi + p14) * pow(2, p15 / 1200)"
   "kcpsSub     = kcps1 * 0.5"

   ;; ----------------------------------------------------
   ;; Osc 1 PWM
   ;; ----------------------------------------------------
   "iwave1      = i(p6)"
   "kPw1Base    = min(0.98, max(0.02, p7))"
   "kPwmRate1   = max(0, p8)"
   "kPwmDepth1  = max(0, p9)"
   "kPwmLfo1    lfo kPwmDepth1, kPwmRate1, 0"
   "kPw1        = min(0.98, max(0.02, kPw1Base + kPwmLfo1))"

   ;; ----------------------------------------------------
   ;; Osc 2 PWM
   ;; ----------------------------------------------------
   "iwave2      = i(p10)"
   "kPw2Base    = min(0.98, max(0.02, p11))"
   "kPwmRate2   = max(0, p12)"
   "kPwmDepth2  = max(0, p13)"
   "kPwmLfo2    lfo kPwmDepth2, kPwmRate2, 0"
   "kPw2        = min(0.98, max(0.02, kPw2Base + kPwmLfo2))"

   ;; ----------------------------------------------------
   ;; Mix controls
   ;; ----------------------------------------------------
   "kMix2       = min(1, max(0, p16))"
   "kMix1       = 1 - kMix2"
   "kSubMix     = min(1, max(0, p18))"
   "iSubWave    = i(p19)"
   "kNoiseMix   = min(1, max(0, p20))"

   ;; ----------------------------------------------------
   ;; Amp envelope AHDSR
   ;; ----------------------------------------------------
   "iAtt        = max(0.0001, i(p21))"
   "iHold       = max(0.0,    i(p22))"
   "iDec        = max(0.0001, i(p23))"
   "iSus        = i(p24)"
   "iRel        = max(0.0001, i(p25))"
   "aAmpEnv     linsegr 0, iAtt, 1, iHold, 1, iDec, iSus, iRel, 0"

   ;; ----------------------------------------------------
   ;; Filter envelope AHDSR
   ;; ----------------------------------------------------
   "iFAtt       = max(0.0001, i(p26))"
   "iFHold      = max(0.0,    i(p27))"
   "iFDec       = max(0.0001, i(p28))"
   "iFSus       = i(p29)"
   "iFRel       = max(0.0001, i(p30))"
   "aFiltEnv    linsegr 0, iFAtt, 1, iFHold, 1, iFDec, iFSus, iFRel, 0"
   "kFiltEnv    downsamp aFiltEnv"

   ;; ----------------------------------------------------
   ;; Filter / modulation / drive / pan
   ;; ----------------------------------------------------
   "kBaseCut    = max(20, p31)"
   "kEnvAmt     = p32"
   "kRes        = min(0.98, max(0.0, p33))"
   "iFType      = i(p34)"
   "kLfoRate    = max(0, p39)"
   "kLfoDepth   = max(0, p40)"
   "kDrive      = max(1, p41)"
   "kPan        = line:k(p42, p3, p43)"

   ;; ----------------------------------------------------
   ;; Oscillators / sub / noise
   ;; ----------------------------------------------------
   "aOsc1       vco2 kamp, kcps1, iwave1, kPw1"
   "aOsc2       vco2 kamp, kcps2, iwave2, kPw2"
   "aSub        vco2 (kamp * kSubMix), kcpsSub, iSubWave, 0.5"
   "aNoise      rand (kamp * kNoiseMix)"

   ;; keep level controlled when adding sources
   "aMix        = ((aOsc1 * kMix1) + (aOsc2 * kMix2) + aSub + aNoise) * 0.6"

   ;; ----------------------------------------------------
   ;; Pre-filter drive
   ;; ----------------------------------------------------
   "aDriven     = tanh(aMix * aAmpEnv * kDrive)"

   ;; ----------------------------------------------------
   ;; Cutoff modulation
   ;; ----------------------------------------------------
   "kLfo        lfo kLfoDepth, kLfoRate, 0"
   "kCutRaw     = kBaseCut + (kFiltEnv * kEnvAmt) + kLfo"
   "kCut        = max(20, min(18000, kCutRaw))"

   ;; ----------------------------------------------------
   ;; Filter bank
   ;; 0 = LP / 1 = BP / 2 = HP
   ;; ----------------------------------------------------
   "aLP         moogladder aDriven, kCut, kRes"
   "aHP         = aDriven - aLP"
   "kBW         = max(20, (1.01 - kRes) * kCut)"
   "aBP         reson aDriven, kCut, kBW, 1"

   "if (iFType == 0) then"
   "  aFilt = aLP"
   "elseif (iFType == 1) then"
   "  aFilt = aBP"
   "else"
   "  aFilt = aHP"
   "endif"

   ;; ----------------------------------------------------
   ;; Output
   ;; ----------------------------------------------------
   "aOutL, aOutR pan2 aFilt, kPan"
   "outleta \"leftout\", aOutL"
   "outleta \"rightout\", aOutR")
  (:doc "Analog2c: dual-vco2 synth with interval/detune, independent PWM, sub osc, noise, amp/filter AHDSR, pitch envelope, selectable LP/BP/HP filter, drive, cutoff LFO and portamento."))


;;; -------------------------------------------------------
;;; ANALOG2D
;;; -------------------------------------------------------

(defcsinstr analog2d
  (:type :instrument)
  (:pfields amp midi
            wave1 pw1 pwmrate1 pwmdepth1
            wave2 pw2 pwmrate2 pwmdepth2
            vco2interval detune mix2
            porta
            submix subwave
            noisemix
            att hold dec sus rel
            fatt fhold fdec fsus frel
            cutoff envamt res filttype
            penvamt patt phold pdec
            lforate lfodepth
            drive
            fmamt syncamt
            pan1 pan2)
  (:outputs (leftout rightout))
  (:body

   ;; ----------------------------------------------------
   ;; Core pitch / portamento
   ;; ----------------------------------------------------
   "kamp        = ampdb(p4)"
   "kPorta      = max(0.0001, p17)"
   "kMidiBase   portk p5, kPorta"

   ;; ----------------------------------------------------
   ;; Pitch envelope (in semitones)
   ;; ----------------------------------------------------
   "iPEnvAmt    = i(p35)"
   "iPAtt       = max(0.0001, i(p36))"
   "iPHold      = max(0.0,    i(p37))"
   "iPDec       = max(0.0001, i(p38))"
   "kPitchEnv   linseg iPEnvAmt, iPAtt, iPEnvAmt, iPHold, iPEnvAmt, iPDec, 0"

   "kMidi       = kMidiBase + kPitchEnv"
   "kcps1       = cpsmidinn(kMidi)"
   "kcps2base   = cpsmidinn(kMidi + p14) * pow(2, p15 / 1200)"
   "kcpsSub     = kcps1 * 0.5"

   ;; ----------------------------------------------------
   ;; Osc 1 PWM
   ;; ----------------------------------------------------
   "iwave1      = i(p6)"
   "kPw1Base    = min(0.98, max(0.02, p7))"
   "kPwmRate1   = max(0, p8)"
   "kPwmDepth1  = max(0, p9)"
   "kPwmLfo1    lfo kPwmDepth1, kPwmRate1, 0"
   "kPw1        = min(0.98, max(0.02, kPw1Base + kPwmLfo1))"

   ;; ----------------------------------------------------
   ;; Osc 2 PWM
   ;; ----------------------------------------------------
   "iwave2      = i(p10)"
   "kPw2Base    = min(0.98, max(0.02, p11))"
   "kPwmRate2   = max(0, p12)"
   "kPwmDepth2  = max(0, p13)"
   "kPwmLfo2    lfo kPwmDepth2, kPwmRate2, 0"
   "kPw2        = min(0.98, max(0.02, kPw2Base + kPwmLfo2))"

   ;; ----------------------------------------------------
   ;; Mix / FM / Sync
   ;; ----------------------------------------------------
   "kMix2       = min(1, max(0, p16))"
   "kMix1       = 1 - kMix2"
   "kSubMix     = min(1, max(0, p18))"
   "iSubWave    = i(p19)"
   "kNoiseMix   = min(1, max(0, p20))"
   "kFmAmt      = max(0, p42)"
   "kSyncAmt    = min(1, max(0, p43))"

   ;; ----------------------------------------------------
   ;; Amp envelope AHDSR
   ;; ----------------------------------------------------
   "iAtt        = max(0.0001, i(p21))"
   "iHold       = max(0.0,    i(p22))"
   "iDec        = max(0.0001, i(p23))"
   "iSus        = i(p24)"
   "iRel        = max(0.0001, i(p25))"
   "aAmpEnv     linsegr 0, iAtt, 1, iHold, 1, iDec, iSus, iRel, 0"

   ;; ----------------------------------------------------
   ;; Filter envelope AHDSR
   ;; ----------------------------------------------------
   "iFAtt       = max(0.0001, i(p26))"
   "iFHold      = max(0.0,    i(p27))"
   "iFDec       = max(0.0001, i(p28))"
   "iFSus       = i(p29)"
   "iFRel       = max(0.0001, i(p30))"
   "aFiltEnv    linsegr 0, iFAtt, 1, iFHold, 1, iFDec, iFSus, iFRel, 0"
   "kFiltEnv    downsamp aFiltEnv"

   ;; ----------------------------------------------------
   ;; Filter / modulation / drive / pan
   ;; ----------------------------------------------------
   "kBaseCut    = max(20, p31)"
   "kEnvAmt     = p32"
   "kRes        = min(0.98, max(0.0, p33))"
   "iFType      = i(p34)"
   "kLfoRate    = max(0, p39)"
   "kLfoDepth   = max(0, p40)"
   "kDrive      = max(1, p41)"
   "kPan        = line:k(p44, p3, p45)"

   ;; ----------------------------------------------------
   ;; Oscillators
   ;; ----------------------------------------------------
   "aOsc1       vco2 kamp, kcps1, iwave1, kPw1"

   ;; light FM from osc1 into osc2 frequency (k-rate safe)
   "kFmSrc      downsamp aOsc1"
   "kFmCps      = kFmSrc * (kcps2base * 0.25 * kFmAmt)"
   "kCps2       = max(0.1, kcps2base + kFmCps)"
   "aOsc2       vco2 kamp, kCps2, iwave2, kPw2"

   ;; Sub and noise
   "aSub        vco2 (kamp * kSubMix), kcpsSub, iSubWave, 0.5"
   "aNoise      rand (kamp * kNoiseMix)"

   ;; Basic dual osc mix
   "aCore       = ((aOsc1 * kMix1) + (aOsc2 * kMix2))"

   ;; Sync-like emphasis
   "aSyncShp    = tanh((aOsc1 + aOsc2) * (1 + (6 * kSyncAmt)))"
   "aOscMix     = (aCore * (1 - kSyncAmt)) + (aSyncShp * kSyncAmt)"

   ;; Final source mix
   "aMix        = (aOscMix + aSub + aNoise) * 0.55"

   ;; ----------------------------------------------------
   ;; Pre-filter drive
   ;; ----------------------------------------------------
   "aDriven     = tanh(aMix * aAmpEnv * kDrive)"

   ;; ----------------------------------------------------
   ;; Cutoff modulation
   ;; ----------------------------------------------------
   "kLfo        lfo kLfoDepth, kLfoRate, 0"
   "kCutRaw     = kBaseCut + (kFiltEnv * kEnvAmt) + kLfo"
   "kCut        = max(20, min(18000, kCutRaw))"

   ;; ----------------------------------------------------
   ;; Filter bank
   ;; ----------------------------------------------------
   "aLP         moogladder aDriven, kCut, kRes"
   "aHP         = aDriven - aLP"
   "kBW         = max(20, (1.01 - kRes) * kCut)"
   "aBP         reson aDriven, kCut, kBW, 1"

   "if (iFType == 0) then"
   "  aFilt = aLP"
   "elseif (iFType == 1) then"
   "  aFilt = aBP"
   "else"
   "  aFilt = aHP"
   "endif"

   ;; ----------------------------------------------------
   ;; Output
   ;; ----------------------------------------------------
   "aOutL, aOutR pan2 aFilt, kPan"
   "outleta \"leftout\", aOutL"
   "outleta \"rightout\", aOutR")
  (:doc "Analog2d: dual-vco2 synth with interval/detune, PWM, sub, noise, pitch env, amp/filter AHDSR, selectable LP/BP/HP filter, drive, cutoff LFO, light k-rate FM, sync-like shaping, and portamento."))



;;; -------------------------------------------------------
;;; FM1
;;; -------------------------------------------------------

(defcsinstr fm1
  (:type :instrument)
  (:pfields amp midi mod index1 index2 rise dec pan1 pan2)
  (:outputs (leftout rightout))
  (:body
   "iSine = ftgenonce:i(0, 0, 16384, 10, 1)"
   "kamp = ampdb:k(p4)"
   "kcps = mtof:k(p5)"
   "kmod = p6"
   "indx1 = p7"
   "indx2 = p8"
   "kndx = line:k(indx1, p3, indx2)"
   "irise = p9"
   "idec = p10"
   "ipan1 = p11"
   "ipan2 = p12"
   "kPan = line:k(ipan1,p3,ipan2)"
   "aSig = foscili:a(kamp, kcps, 1, kmod, kndx, iSine)"
   "aEnv = linen(1, irise, p3, idec)"
   "aOut = aSig * aEnv"
   "aSigL, aSigR pan2 aOut, kPan"
   "outleta \"leftout\", aSigL"
   "outleta \"rightout\", aSigR")
  (:doc "Simple FM instrument."))

;;; -------------------------------------------------------
;;; NIGHT
;;; -------------------------------------------------------

(defcsinstr night
  (:type :instrument)
  (:pfields amp midi pan1 pan2)
  (:outputs (leftout rightout))
  (:body
   "; String-pad borrowed from the piece \"Bay at Night\""
   "iwave = ftgenonce:i(0, 0, 4096, 10, 1, .5, .33, .25, .0, .1, .1, .1)"
   "iamp = ampdb(p4)"
   "ihz = mtof:i(p5)"
   "ipan1 = p6"
   "ipan2 = p7"
   "kPan = line:k(ipan1,p3,ipan2)"
   "kctrl = linseg:k(0, p3/4, iamp, p3/2, 0)"
   "afund = poscil:a(kctrl, ihz, iwave)"
   "acel1 = poscil:a(kctrl, ihz - .1, iwave)"
   "acel2 = poscil:a(kctrl, ihz + .1, iwave)"
   "asig = afund + acel1 + acel2"
   "asig butterlp asig, (p5+125)*40+900"
   "aSigL = asig * cos(kPan * $M_PI_2)"
   "aSigR = asig * sin(kPan * $M_PI_2)"
   "outleta \"leftout\", aSigL"
   "outleta \"rightout\", aSigR")
  (:doc "String-pad borrowed from Bay at Night."))

;;; -------------------------------------------------------
;;; TROMBONE
;;; -------------------------------------------------------

(defcsinstr trombone
  (:type :instrument)
  (:pfields amp note1 note2)
  (:outputs (leftout rightout))
  (:body
   "iSine = ftgenonce:i(0, 0, 4096, 10, 1)"
   "iamp = ampdb(p4)"
   "inote1 = p5"
   "inote2 = p6"
   "inotemid = inote1 + ((inote2 - inote1) / 2)"
   "idur = p3"
   "icurve = 2"
   "knote transeg inote1, idur/2, icurve, inotemid, idur/2, -icurve, inote2"
   "kenv linseg 0, p3/4, iamp, p3/2, iamp, p3/4, 0"
   "kdtn jspline 0.05, 0.4, 0.8"
   "knh init 75"
   "klh init 1"
   "kmul rspline 0.3, 0.82, 0.04, 0.2"
   "kamp rspline 0.02, 3, 0.05, 0.1"
   "a1 gbuzz kenv*kamp, cpsmidinn(knote)*semitone(kdtn), 75, 1, kmul^1.75, iSine"
   "a1 dcblock2 a1"
   "a1 = a1 * 10"
   "kpan rspline 0, 1, 0.1, 1"
   "a1, a2 pan2 a1, kpan"
   "outleta \"leftout\", a1"
   "outleta \"rightout\", a2")
  (:doc "Trombone derived from Iain McCurdy's Csound Haiku I."))


;;; -------------------------------------------------------
;;; PAD1
;;; -------------------------------------------------------

(defcsinstr pad1
  (:type :instrument)
  (:pfields amp midi rise dec wave)
  (:outputs (leftout rightout))
  (:body
   "iDur = p3"
   "iNote = p5"
   "kamp = ampdb:k(p4)"
   "irise = p6"
   "idec = p7"
   "iWave = p8"
   "aEnv linen 1, irise, iDur, idec"
   "kDet1 = randomh(-0.3, 0.3, 0.5)"
   "kDet2 = randomh(-0.3, 0.3, 0.33)"
   "kDet3 = randomh(-0.3, 0.3, 0.25)"
   "kFreq1 = mtof(iNote + kDet1)"
   "kFreq2 = mtof(iNote + kDet2)"
   "kFreq3 = mtof(iNote + kDet3)"
   "a1 = poscil(aEnv * kamp * 0.33, kFreq1, iWave)"
   "a2 = poscil(aEnv * kamp * 0.33, kFreq2, iWave)"
   "a3 = poscil(aEnv * kamp * 0.33, kFreq3, iWave)"
   "kPanEnv1 linen 1, 0.1*iDur, 0.8*iDur, 0.1*iDur"
   "kPanEnv2 linen 1, 0.2*iDur, 0.6*iDur, 0.2*iDur"
   "kPanEnv3 linen 1, 0.3*iDur, 0.4*iDur, 0.3*iDur"
   "kPan1 = kPanEnv1"
   "kPan2 = 1 - kPanEnv2"
   "kPan3 = kPanEnv3"
   "a1L, a1R pan2 a1, kPan1"
   "a2L, a2R pan2 a2, kPan2"
   "a3L, a3R pan2 a3, kPan3"
   "aL = tone(a1L + a2L + a3L, 800)"
   "aR = tone(a1R + a2R + a3R, 800)"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR")
  (:doc "Versatile pad using an externally defined wavetable."))

;;; -------------------------------------------------------
;;; GRAIN1
;;; -------------------------------------------------------

(defcsinstr grain1
  (:type :instrument)
  (:pfields amp ft dens1 dens2 rise dec pan1 pan2)
  (:outputs (leftout rightout))
  (:body
   "iWin = ftgenonce:i(0, 0, 1025, 20, 2, 1)"
   "iDur = p3"
   "kamp = ampdb:k(p4)"
   "iFt = p5"
   "iDens1 = p6"
   "iDens2 = p7"
   "irise = p8"
   "idec = p9"
   "ipan1 = p10"
   "ipan2 = p11"
   "ipitch = sr/ftlen(iFt)"
   "kdens1 = expon(iDens1, p3, iDens2)"
   "aEnv = linen(1, irise, iDur, idec)"
   "a1 = grain(aEnv * kamp, ipitch, kdens1, 0, 0, 1, iFt, iWin, 1)"
   "kPan = line:k(ipan1,p3,ipan2)"
   "aL, aR pan2 a1, kPan"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR")
  (:doc "Granulator for soundfiles loaded in ftables."))

;;; -------------------------------------------------------
;;; GRAIN1B
;;; -------------------------------------------------------

(defcsinstr grain1b
  (:type :instrument)
  (:pfields amp ft dens1 dens2 rise dec pan1 pan2 pitchfact)
  (:outputs (leftout rightout))
  (:body
   "iWin = ftgenonce:i(0, 0, 1025, 20, 2, 1)"
   "iDur = p3"
   "kamp = ampdb:k(p4)"
   "iFt = p5"
   "iDens1 = p6"
   "iDens2 = p7"
   "irise = p8"
   "idec = p9"
   "ipan1 = p10"
   "ipan2 = p11"
   "ipitch = sr/ftlen(iFt)"
   "ipitchfact = p12"
   "ipitch2 = ipitch * ipitchfact"
   "kdens1 = expon(iDens1, p3, iDens2)"
   "aEnv = linen(1, irise, iDur, idec)"
   "a1 = grain(aEnv * kamp, ipitch2, kdens1, 0, 0, 1, iFt, iWin, 1)"
   "kPan = line:k(ipan1,p3,ipan2)"
   "aL, aR pan2 a1, kPan"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR")
  (:doc "Granulator for soundfiles with fixed pitch-factor control."))

;;; -------------------------------------------------------
;;; GRAIN2
;;; -------------------------------------------------------

(defcsinstr grain2
  (:type :instrument)
  (:pfields amp midi fn gdur ovrlp rise dec rndvarfrq1 rndvarfrq2 pan1 pan2)
  (:outputs (leftout rightout))
  (:body
   "iwfn = ftgenonce:i(0, 0, 1025, 20, 2, 1)"
   "iDur = p3"
   "kamp = ampdb:k(p4)"
   "kcps = mtof:k(p5)"
   "kfn = p6"
   "kgdur = p7"
   "iovrlp = p8"
   "irise = p9"
   "idec = p10"
   "iRndVarFrq1 = p11"
   "iRndVarFrq2 = p12"
   "ipan1 = p13"
   "ipan2 = p14"
   "kfmd = expon(iRndVarFrq1, p3, iRndVarFrq2)"
   "a1 = grain2(kcps, kfmd, kgdur, iovrlp, kfn, iwfn)"
   "aEnv = linen(kamp, irise, iDur, idec)"
   "a1 = a1 * aEnv"
   "kPan = line:k(ipan1,p3,ipan2)"
   "aL, aR pan2 a1, kPan"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR")
  (:doc "Granulator for generated ftables, not soundfiles."))

;;; -------------------------------------------------------
;;; DISKGRAIN1
;;; -------------------------------------------------------

(defcsinstr diskgrain1
  (:type :instrument)
  (:pfields file amp freq pitch grsize prate envfn overlaps maxgrsize offset pan1 pan2)
  (:outputs (leftout rightout))
  (:body
   "Sfile = p4"
   "kgain = 30"
   "kamp = ampdb(p5) * kgain"
   "kfreq = p6"
   "kpitch = p7"
   "kgrsize = p8"
   "kprate = p9"
   "ifun = i(p10)"
   "iolaps = i(p11)"
   "imaxgrsize = i(p12)"
   "ioffset = i(p13)"
   "ipan1 = p14"
   "ipan2 = p15"
   "kPan = line:k(ipan1, p3, ipan2)"
   "aSig diskgrain Sfile, kamp, kfreq, kpitch, kgrsize, kprate, ifun, iolaps, imaxgrsize, ioffset"
   "aL, aR pan2 aSig, kPan"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR")
  (:doc "Synchronous granular synthesis from a soundfile using the Csound diskgrain opcode."))

;;; -------------------------------------------------------
;;; VCO2PAD1
;;; -------------------------------------------------------
(defcsinstr vco2pad1
  (:type :instrument)
  (:pfields amp freq atk rel detune bright vibdepth vibrate submix pan1 pan2)
  (:outputs (leftout rightout))
  (:body
   "kamp = ampdb(p4) * 4"
   "kfreq = p5"
   "iAtk = max(0.001, p6)"
   "iRel = max(0.001, p7)"
   "kDet = max(0, p8)"
   "iBright = limit(p9, 150, 12000)"
   "kVibDepth = max(0, p10)"
   "kVibRate = max(0.01, p11)"
   "kSubMix = limit(p12, 0, 1)"
   "iPan1 = p13"
   "iPan2 = p14"

   "aEnv madsr iAtk, 0.25, 0.9, iRel"

   "kVib oscili kVibDepth, kVibRate"

   "kRat1 = cent(kDet)"
   "kRat2 = cent(-kDet)"
   "kRat3 = cent(kDet * 0.35)"

   "a1 vco2 kamp * 0.34, kfreq * kRat1 * (1 + kVib)"
   "a2 vco2 kamp * 0.34, kfreq * kRat2 * (1 + kVib)"
   "a3 vco2 kamp * 0.22, kfreq * kRat3 * (1 + (kVib * 0.6))"
   "aSub vco2 kamp * 0.18 * kSubMix, (kfreq * 0.5) * (1 + (kVib * 0.2))"

   "aMix = (a1 + a2 + a3 + aSub) * 0.7"
   "aMix = aMix * aEnv"

   "iCfStart = limit(iBright * 1.7, 150, 12000)"
   "kCf linseg iCfStart, iAtk, iBright, max(0.01, p3 - iAtk), iBright"

   "aFilt butlp aMix, kCf"
   "aFilt tone aFilt, 10000"

   "kPan line iPan1, p3, iPan2"
   "aL, aR pan2 aFilt, kPan"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; VCO2X2MOD1
;;; -------------------------------------------------------
(defcsinstr vco2x2mod1
  (:type :instrument)
  (:pfields amp freq atk rel detune bright vibdepth vibrate pwm submix noisemix drift pan1 pan2)
  (:outputs (leftout rightout))
  (:body
   "giSine ftgenonce 0, 0, 16384, 10, 1"

   "kamp = ampdb(p4) * 1.8"
   "kfreq = p5"
   "iAtk = max(0.001, p6)"
   "iRel = max(0.001, p7)"
   "kDet = p8"
   "iBright = limit(i(p9), 150, 12000)"
   "kVibDepth = max(0, p10)"
   "kVibRate = max(0.01, p11)"
   "kPW = limit(p12, 0.05, 0.95)"
   "kSubMix = limit(p13, 0, 1)"
   "kNoiseMix = limit(p14, 0, 1)"
   "kDriftAmt = max(0, p15)"
   "iPan1 = p16"
   "iPan2 = p17"

   "aEnv madsr iAtk, 0.30, 0.90, iRel"
   "kVib oscili kVibDepth, kVibRate, giSine"

   "kDrift1 jspline 0, kDriftAmt, 0.15"
   "kDrift2 jspline 0, kDriftAmt, 0.19"

   "kRat1 = pow(2, (kDet + kDrift1) / 1200)"
   "kRat2 = pow(2, (-kDet + kDrift2) / 1200)"

   "kFreq1 = kfreq * kRat1 * (1 + kVib)"
   "kFreq2 = kfreq * kRat2 * (1 + (kVib * 0.85))"

   "a1 vco2 kamp * 0.34, kFreq1, 0"
   "a2 vco2 kamp * 0.28, kFreq2, 2, kPW"
   "aSub vco2 kamp * 0.14 * kSubMix, kfreq * 0.5, 2, 0.5"
   "aNoise rand kamp * 0.02 * kNoiseMix"

   "aMix = a1 + a2 + aSub + aNoise"
   "aMix = aMix * 0.65"
   "aMix = aMix * aEnv"

   "kCf line iBright * 0.75, p3, iBright"
   "aMix butterlp aMix, kCf"

   "kPan line iPan1, p3, iPan2"
   "aL, aR pan2 aMix, kPan"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))

;;; -------------------------------------------------------
;;; POSCILX2MOD1
;;; -------------------------------------------------------
(defcsinstr poscilx2mod1
  (:type :instrument)
  (:pfields amp freq atk rel detune bright vibdepth vibrate submix noisemix drift osc1fn osc2fn subfn vibfn pan1 pan2)
  (:outputs (leftout rightout))
  (:body
   "kamp = ampdb(p4) * 1.8"
   "kfreq = p5"
   "iAtk = max(0.001, p6)"
   "iRel = max(0.001, p7)"
   "kDet = p8"
   "iBright = limit(i(p9), 150, 12000)"
   "kVibDepth = max(0, p10)"
   "kVibRate = max(0.01, p11)"
   "kSubMix = limit(p12, 0, 1)"
   "kNoiseMix = limit(p13, 0, 1)"
   "kDriftAmt = max(0, p14)"
   "iOsc1Fn = i(p15)"
   "iOsc2Fn = i(p16)"
   "iSubFn = i(p17)"
   "iVibFn = i(p18)"
   "iPan1 = p19"
   "iPan2 = p20"

   "aEnv madsr iAtk, 0.30, 0.90, iRel"
   "kVib poscil kVibDepth, kVibRate, iVibFn"

   "kDrift1 jspline 0, kDriftAmt, 0.15"
   "kDrift2 jspline 0, kDriftAmt, 0.19"

   "kRat1 = pow(2, (kDet + kDrift1) / 1200)"
   "kRat2 = pow(2, (-kDet + kDrift2) / 1200)"

   "kFreq1 = kfreq * kRat1 * (1 + kVib)"
   "kFreq2 = kfreq * kRat2 * (1 + (kVib * 0.85))"

   "a1 poscil kamp * 0.34, kFreq1, iOsc1Fn"
   "a2 poscil kamp * 0.28, kFreq2, iOsc2Fn"
   "aSub poscil kamp * 0.14 * kSubMix, kfreq * 0.5, iSubFn"
   "aNoise rand kamp * 0.02 * kNoiseMix"

   "aMix = a1 + a2 + aSub + aNoise"
   "aMix = aMix * 0.65"
   "aMix = aMix * aEnv"

   "kCf line iBright * 0.75, p3, iBright"
   "aMix butterlp aMix, kCf"

   "kPan line iPan1, p3, iPan2"
   "aL, aR pan2 aMix, kPan"

   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR"))


;;; -------------------------------------------------------
;;; FX / OUTPUTS
;;; -------------------------------------------------------

;;; -------------------------------------------------------
;;; REVERB - PLATEAU1
;;; -------------------------------------------------------

(defcsinstr plateau1
  (:type :fx)
  (:pfields amp mix predelay size decay damping diffusion modrate moddepth width)
  (:globals
   "giPlateauSine ftgen 0, 0, 16384, 10, 1")
  (:inputs (leftin rightin))
  (:outputs (leftout rightout))
  (:body
   "aleftin inleta \"leftin\""
   "arightin inleta \"rightin\""

   ;; fixed defaults for FX instruments in this framework
   "kAmp init -4"
   "kMix init 0.42"
   "kPredelay init 0.022"
   "kSize init 1.10"
   "kDecay init 0.86"
   "kDamping init 0.42"
   "kDiffusion init 0.74"
   "kModRate init 0.19"
   "kModDepth init 0.0013"
   "kWidth init 0.98"

   "kMix limit kMix, 0, 1"
   "kPredelay limit kPredelay, 0, 0.25"
   "kSize limit kSize, 0.35, 2.5"
   "kDecay limit kDecay, 0, 0.96"
   "kDamping limit kDamping, 0, 1"
   "kDiffusion limit kDiffusion, 0, 0.85"
   "kModRate limit kModRate, 0.02, 3.0"
   "kModDepth limit kModDepth, 0, 0.006"
   "kWidth limit kWidth, 0, 1"

   "kOutGain = ampdb(kAmp)"
   "kDampHz = 18000 - (kDamping * 16800)"

   "aPred interp kPredelay"
   "aSize interp kSize"

   "aInL = dcblock2(aleftin)"
   "aInR = dcblock2(arightin)"

   ;; pre-delay left
   "aPreBufL delayr 0.5"
   "aPreTapL deltapi aPred"
   "delayw aInL"

   ;; pre-delay right
   "aPreBufR delayr 0.5"
   "aPreTapR deltapi aPred"
   "delayw aInR"

   "aMono = (aPreTapL + aPreTapR) * 0.5"
   "aStereo = (aPreTapL - aPreTapR) * 0.5"

   ;; input diffusion stage 1
   "aDel1 = 0.004771 * aSize"
   "aBuf1 delayr 0.1"
   "aTap1 deltapi aDel1"
   "aDiff1 = aTap1 - (kDiffusion * aMono)"
   "delayw aMono + (kDiffusion * aDiff1)"

   ;; input diffusion stage 2
   "aDel2 = 0.003595 * aSize"
   "aBuf2 delayr 0.1"
   "aTap2 deltapi aDel2"
   "aDiff2 = aTap2 - (kDiffusion * aDiff1)"
   "delayw aDiff1 + (kDiffusion * aDiff2)"

   ;; input diffusion stage 3
   "aDel3 = 0.012734 * aSize"
   "aBuf3 delayr 0.1"
   "aTap3 deltapi aDel3"
   "aDiff3 = aTap3 - (kDiffusion * aDiff2)"
   "delayw aDiff2 + (kDiffusion * aDiff3)"

   ;; input diffusion stage 4
   "aDel4 = 0.009307 * aSize"
   "aBuf4 delayr 0.1"
   "aTap4 deltapi aDel4"
   "aDiff4 = aTap4 - (kDiffusion * aDiff3)"
   "delayw aDiff3 + (kDiffusion * aDiff4)"

   "aFeedL = aDiff4 + (aStereo * 0.35)"
   "aFeedR = aDiff4 - (aStereo * 0.35)"

   ;; subtle modulation
   "aModL1 poscil kModDepth, kModRate * 0.97, giPlateauSine"
   "aModL2 poscil kModDepth, kModRate * 1.11, giPlateauSine"
   "aModR1 poscil kModDepth, kModRate * 1.03, giPlateauSine"
   "aModR2 poscil kModDepth, kModRate * 0.89, giPlateauSine"

   "aFbL init 0"
   "aFbR init 0"

   ;; ----------------------------------------------------
   ;; left tank
   ;; ----------------------------------------------------
   "aTankInL = aFeedL + (aFbR * kDecay)"

   "aLDel1 = (0.030509 * aSize) + aModL1"
   "aLDel1 limit aLDel1, 0.001, 1.4"
   "aLBuf1 delayr 1.5"
   "aLTap1 deltapi aLDel1"
   "aLAp1 = aLTap1 - (kDiffusion * aTankInL)"
   "delayw aTankInL + (kDiffusion * aLAp1)"

   "aLDel2 = (0.089244 * aSize) + aModL2"
   "aLDel2 limit aLDel2, 0.001, 1.4"
   "aLBuf2 delayr 1.5"
   "aLTap2 deltapi aLDel2"
   "delayw aLAp1"

   "aLDamp tone aLTap2, kDampHz"

   "aLDel3 = 0.060481 * aSize"
   "aLBuf3 delayr 1.5"
   "aLTap3 deltapi aLDel3"
   "aLAp2 = aLTap3 - (kDiffusion * aLDamp)"
   "delayw aLDamp + (kDiffusion * aLAp2)"

   "aLDel4 = 0.106280 * aSize"
   "aLBuf4 delayr 1.5"
   "aLTap4 deltapi aLDel4"
   "delayw aLAp2"

   "aFbL = dcblock2(aLTap4)"

   ;; ----------------------------------------------------
   ;; right tank
   ;; ----------------------------------------------------
   "aTankInR = aFeedR + (aFbL * kDecay)"

   "aRDel1 = (0.022579 * aSize) + aModR1"
   "aRDel1 limit aRDel1, 0.001, 1.4"
   "aRBuf1 delayr 1.5"
   "aRTap1 deltapi aRDel1"
   "aRAp1 = aRTap1 - (kDiffusion * aTankInR)"
   "delayw aTankInR + (kDiffusion * aRAp1)"

   "aRDel2 = (0.074321 * aSize) + aModR2"
   "aRDel2 limit aRDel2, 0.001, 1.4"
   "aRBuf2 delayr 1.5"
   "aRTap2 deltapi aRDel2"
   "delayw aRAp1"

   "aRDamp tone aRTap2, kDampHz"

   "aRDel3 = 0.050211 * aSize"
   "aRBuf3 delayr 1.5"
   "aRTap3 deltapi aRDel3"
   "aRAp2 = aRTap3 - (kDiffusion * aRDamp)"
   "delayw aRDamp + (kDiffusion * aRAp2)"

   "aRDel4 = 0.089770 * aSize"
   "aRBuf4 delayr 1.5"
   "aRTap4 deltapi aRDel4"
   "delayw aRAp2"

   "aFbR = dcblock2(aRTap4)"

   ;; stereo taps
   "aWetL = (aLTap2 * 0.30) + (aLTap4 * 0.45) + (aRTap3 * 0.25)"
   "aWetR = (aRTap2 * 0.30) + (aRTap4 * 0.45) + (aLTap3 * 0.25)"

   "aWetL = dcblock2(aWetL)"
   "aWetR = dcblock2(aWetR)"

   "aMid = (aWetL + aWetR) * 0.5"
   "aSide = ((aWetL - aWetR) * 0.5) * kWidth"
   "aWetL = aMid + aSide"
   "aWetR = aMid - aSide"

   "aOutL = ((1 - kMix) * aInL) + (kMix * aWetL)"
   "aOutR = ((1 - kMix) * aInR) + (kMix * aWetR)"

   "aOutL = tanh(aOutL * kOutGain)"
   "aOutR = tanh(aOutR * kOutGain)"

   "outleta \"leftout\", aOutL"
   "outleta \"rightout\", aOutR"))


(def-simple-stereo-fx reverberator98
  "aleftin inleta \"leftin\""
  "arightin inleta \"rightin\""
  "idelay = 0.98"
  "icutoff = 12000"
  "aleftout, arightout reverbsc aleftin, arightin, idelay, icutoff"
  "outleta \"leftout\", aleftout"
  "outleta \"rightout\", arightout")

(def-simple-stereo-fx reverberator95
  "aleftin inleta \"leftin\""
  "arightin inleta \"rightin\""
  "idelay = 0.95"
  "icutoff = 12000"
  "aleftout, arightout reverbsc aleftin, arightin, idelay, icutoff"
  "outleta \"leftout\", aleftout"
  "outleta \"rightout\", arightout")

(def-simple-stereo-fx reverberator92
  "aleftin inleta \"leftin\""
  "arightin inleta \"rightin\""
  "idelay = 0.92"
  "icutoff = 12000"
  "aleftout, arightout reverbsc aleftin, arightin, idelay, icutoff"
  "outleta \"leftout\", aleftout"
  "outleta \"rightout\", arightout")

(def-simple-stereo-fx reverberator90
  "aleftin inleta \"leftin\""
  "arightin inleta \"rightin\""
  "idelay = 0.90"
  "icutoff = 12000"
  "aleftout, arightout reverbsc aleftin, arightin, idelay, icutoff"
  "outleta \"leftout\", aleftout"
  "outleta \"rightout\", arightout")

(def-simple-stereo-fx reverberator70
  "aleftin inleta \"leftin\""
  "arightin inleta \"rightin\""
  "idelay = 0.70"
  "icutoff = 12000"
  "aleftout, arightout reverbsc aleftin, arightin, idelay, icutoff"
  "outleta \"leftout\", aleftout"
  "outleta \"rightout\", arightout")

(def-simple-stereo-fx reverberator50
  "aleftin inleta \"leftin\""
  "arightin inleta \"rightin\""
  "idelay = 0.50"
  "icutoff = 12000"
  "aleftout, arightout reverbsc aleftin, arightin, idelay, icutoff"
  "outleta \"leftout\", aleftout"
  "outleta \"rightout\", arightout")

(def-simple-stereo-fx reverberator85
  "aleftin inleta \"leftin\""
  "arightin inleta \"rightin\""
  "idelay = 0.85"
  "icutoff = 12000"
  "aleftout, arightout reverbsc aleftin, arightin, idelay, icutoff"
  "outleta \"leftout\", aleftout"
  "outleta \"rightout\", arightout")

(def-simple-stereo-fx reverberator7
  "aleftin inleta \"leftin\""
  "arightin inleta \"rightin\""
  "idelay = 0.7"
  "icutoff = 12000"
  "aleftout, arightout reverbsc aleftin, arightin, idelay, icutoff"
  "outleta \"leftout\", aleftout"
  "outleta \"rightout\", arightout")

(def-simple-stereo-fx reverberator5
  "aleftin inleta \"leftin\""
  "arightin inleta \"rightin\""
  "idelay = 0.5"
  "icutoff = 12000"
  "aleftout, arightout reverbsc aleftin, arightin, idelay, icutoff"
  "outleta \"leftout\", aleftout"
  "outleta \"rightout\", arightout")

(def-simple-stereo-fx reverberator4
  "aleftin inleta \"leftin\""
  "arightin inleta \"rightin\""
  "idelay = 0.4"
  "icutoff = 12000"
  "aleftout, arightout reverbsc aleftin, arightin, idelay, icutoff"
  "outleta \"leftout\", aleftout"
  "outleta \"rightout\", arightout")

(def-simple-stereo-fx compressor
  "aleftin inleta \"leftin\""
  "arightin inleta \"rightin\""
  "kthreshold = 25000"
  "icomp1 = 0.5"
  "icomp2 = 0.763"
  "irtime = 0.1"
  "iftime = 0.1"
  "aleftout dam aleftin, kthreshold, icomp1, icomp2, irtime, iftime"
  "arightout dam arightin, kthreshold, icomp1, icomp2, irtime, iftime"
  "outleta \"leftout\", aleftout"
  "outleta \"rightout\", arightout")

;; Output avec soft limiter
(def-simple-output output
  "aleftin inleta \"leftin\""
  "arightin inleta \"rightin\""

  "kgain = 1"
  "kdrive = 2.5"

  "aL = tanh(aleftin * kdrive) * kgain"
  "aR = tanh(arightin * kdrive) * kgain"

  "outs aL, aR")
