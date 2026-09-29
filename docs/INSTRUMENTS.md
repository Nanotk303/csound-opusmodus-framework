# Catalogue des instruments

Ce catalogue est genere depuis les definitions `defcsinstr`.

Chaque parametre s'utilise comme mot-cle Lisp : `freq` devient `:freq`.

Pour chaque instrument, `:start` (p2) et `:dur` (p3) sont obligatoires, en secondes. Les tableaux listent les p-fields a partir de p4, dans leur ordre exact.

Les valeurs par defaut sont celles du code, avant les limites internes eventuelles de Csound. Une unite `-` signifie non renseignee, pas necessairement sans dimension. Les champs deprecies sont sans effet, quelle que soit l'unite affichee.

Les effets et sorties sont lances par le routage et ne recoivent pas de `cs-event`. Les tables externes et fichiers audio requis ne sont pas fournis.

77 entrees : 64 instruments, 12 effets, 1 sortie(s).

## `analog1`

Type: `instrument`  
Analog1: single-vco2 synth with AHDSR and selectable LP/BP/HP filter.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `wave` | `0` | - | optionnel |
| p7 | `pw` | `0.5` | - | optionnel |
| p8 | `att` | `0.01` | seconds | optionnel |
| p9 | `hold` | `0` | seconds | optionnel |
| p10 | `dec` | `0.2` | seconds | optionnel |
| p11 | `sus` | `0.7` | 0..1 | optionnel |
| p12 | `rel` | `0.2` | seconds | optionnel |
| p13 | `cutoff` | `8000` | Hz | optionnel |
| p14 | `res` | `0.2` | - | optionnel |
| p15 | `filttype` | `0` | - | optionnel |
| p16 | `pan1` | `0.5` | 0..1 | optionnel |
| p17 | `pan2` | `0.5` | 0..1 | optionnel |

## `analog1b`

Type: `instrument`  
Analog1b: one-vco2 synth with amp/filter envelopes, drive, selectable LP/BP/HP filter, cutoff LFO and portamento.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `wave` | `0` | - | optionnel |
| p7 | `pw` | `0.5` | - | optionnel |
| p8 | `porta` | `0.01` | - | optionnel |
| p9 | `att` | `0.01` | seconds | optionnel |
| p10 | `hold` | `0` | seconds | optionnel |
| p11 | `dec` | `0.2` | seconds | optionnel |
| p12 | `sus` | `0.7` | 0..1 | optionnel |
| p13 | `rel` | `0.2` | seconds | optionnel |
| p14 | `fatt` | `0.01` | - | optionnel |
| p15 | `fhold` | `0` | - | optionnel |
| p16 | `fdec` | `0.2` | - | optionnel |
| p17 | `fsus` | `0.7` | - | optionnel |
| p18 | `frel` | `0.2` | - | optionnel |
| p19 | `cutoff` | `8000` | Hz | optionnel |
| p20 | `envamt` | `0` | - | optionnel |
| p21 | `res` | `0.2` | - | optionnel |
| p22 | `filttype` | `0` | - | optionnel |
| p23 | `lforate` | `5` | Hz | optionnel |
| p24 | `lfodepth` | `0` | - | optionnel |
| p25 | `drive` | `0` | - | optionnel |
| p26 | `pan1` | `0.5` | 0..1 | optionnel |
| p27 | `pan2` | `0.5` | 0..1 | optionnel |

## `analog1c`

Type: `instrument`  
Analog1c: vco2 synth with sub oscillator, noise, PWM, amp/filter AHDSR, pitch envelope, selectable LP/BP/HP filter, drive, filter LFO and portamento.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `wave` | `0` | - | optionnel |
| p7 | `pw` | `0.5` | - | optionnel |
| p8 | `pwmrate` | `0.5` | Hz | optionnel |
| p9 | `pwmdepth` | `0` | - | optionnel |
| p10 | `porta` | `0.01` | - | optionnel |
| p11 | `submix` | `0` | - | optionnel |
| p12 | `noisemix` | `0` | - | optionnel |
| p13 | `att` | `0.01` | seconds | optionnel |
| p14 | `hold` | `0` | seconds | optionnel |
| p15 | `dec` | `0.2` | seconds | optionnel |
| p16 | `sus` | `0.7` | 0..1 | optionnel |
| p17 | `rel` | `0.2` | seconds | optionnel |
| p18 | `fatt` | `0.01` | - | optionnel |
| p19 | `fhold` | `0` | - | optionnel |
| p20 | `fdec` | `0.2` | - | optionnel |
| p21 | `fsus` | `0.7` | - | optionnel |
| p22 | `frel` | `0.2` | - | optionnel |
| p23 | `cutoff` | `8000` | Hz | optionnel |
| p24 | `envamt` | `0` | - | optionnel |
| p25 | `res` | `0.2` | - | optionnel |
| p26 | `filttype` | `0` | - | optionnel |
| p27 | `penvamt` | `0` | - | optionnel |
| p28 | `patt` | `0.01` | - | optionnel |
| p29 | `phold` | `0` | - | optionnel |
| p30 | `pdec` | `0.2` | - | optionnel |
| p31 | `lforate` | `5` | Hz | optionnel |
| p32 | `lfodepth` | `0` | - | optionnel |
| p33 | `drive` | `0` | - | optionnel |
| p34 | `pan1` | `0.5` | 0..1 | optionnel |
| p35 | `pan2` | `0.5` | 0..1 | optionnel |

## `analog2`

Type: `instrument`  
Analog2: two-vco2 synth with selectable LP/BP/HP filter, AHDSR envelope, and VCO2 detune in cents.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `wave1` | `0` | - | optionnel |
| p7 | `pw1` | `0.5` | - | optionnel |
| p8 | `wave2` | `0` | - | optionnel |
| p9 | `pw2` | `0.5` | - | optionnel |
| p10 | `detune` | `0` | cents | optionnel |
| p11 | `att` | `0.01` | seconds | optionnel |
| p12 | `hold` | `0` | seconds | optionnel |
| p13 | `dec` | `0.2` | seconds | optionnel |
| p14 | `sus` | `0.7` | 0..1 | optionnel |
| p15 | `rel` | `0.2` | seconds | optionnel |
| p16 | `cutoff` | `8000` | Hz | optionnel |
| p17 | `res` | `0.2` | - | optionnel |
| p18 | `filttype` | `0` | - | optionnel |
| p19 | `pan1` | `0.5` | 0..1 | optionnel |
| p20 | `pan2` | `0.5` | 0..1 | optionnel |

## `analog2b`

Type: `instrument`  
Analog2b: dual-vco2 synth with independent PWM, VCO2 interval and detune, amp/filter AHDSR, selectable LP/BP/HP filter, drive, cutoff LFO and portamento.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `wave1` | `0` | - | optionnel |
| p7 | `pw1` | `0.5` | - | optionnel |
| p8 | `pwmrate1` | `0.5` | Hz | optionnel |
| p9 | `pwmdepth1` | `0` | - | optionnel |
| p10 | `wave2` | `0` | - | optionnel |
| p11 | `pw2` | `0.5` | - | optionnel |
| p12 | `pwmrate2` | `0.5` | Hz | optionnel |
| p13 | `pwmdepth2` | `0` | - | optionnel |
| p14 | `vco2interval` | `0` | - | optionnel |
| p15 | `detune` | `0` | cents | optionnel |
| p16 | `mix2` | `0.5` | - | optionnel |
| p17 | `porta` | `0.01` | - | optionnel |
| p18 | `att` | `0.01` | seconds | optionnel |
| p19 | `hold` | `0` | seconds | optionnel |
| p20 | `dec` | `0.2` | seconds | optionnel |
| p21 | `sus` | `0.7` | 0..1 | optionnel |
| p22 | `rel` | `0.2` | seconds | optionnel |
| p23 | `fatt` | `0.01` | - | optionnel |
| p24 | `fhold` | `0` | - | optionnel |
| p25 | `fdec` | `0.2` | - | optionnel |
| p26 | `fsus` | `0.7` | - | optionnel |
| p27 | `frel` | `0.2` | - | optionnel |
| p28 | `cutoff` | `8000` | Hz | optionnel |
| p29 | `envamt` | `0` | - | optionnel |
| p30 | `res` | `0.2` | - | optionnel |
| p31 | `filttype` | `0` | - | optionnel |
| p32 | `lforate` | `5` | Hz | optionnel |
| p33 | `lfodepth` | `0` | - | optionnel |
| p34 | `drive` | `0` | - | optionnel |
| p35 | `pan1` | `0.5` | 0..1 | optionnel |
| p36 | `pan2` | `0.5` | 0..1 | optionnel |

## `analog2c`

Type: `instrument`  
Analog2c: dual-vco2 synth with interval/detune, independent PWM, sub osc, noise, amp/filter AHDSR, pitch envelope, selectable LP/BP/HP filter, drive, cutoff LFO and portamento.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `wave1` | `0` | - | optionnel |
| p7 | `pw1` | `0.5` | - | optionnel |
| p8 | `pwmrate1` | `0.5` | Hz | optionnel |
| p9 | `pwmdepth1` | `0` | - | optionnel |
| p10 | `wave2` | `0` | - | optionnel |
| p11 | `pw2` | `0.5` | - | optionnel |
| p12 | `pwmrate2` | `0.5` | Hz | optionnel |
| p13 | `pwmdepth2` | `0` | - | optionnel |
| p14 | `vco2interval` | `0` | - | optionnel |
| p15 | `detune` | `0` | cents | optionnel |
| p16 | `mix2` | `0.5` | - | optionnel |
| p17 | `porta` | `0.01` | - | optionnel |
| p18 | `submix` | `0` | - | optionnel |
| p19 | `subwave` | `0` | - | optionnel |
| p20 | `noisemix` | `0` | - | optionnel |
| p21 | `att` | `0.01` | seconds | optionnel |
| p22 | `hold` | `0` | seconds | optionnel |
| p23 | `dec` | `0.2` | seconds | optionnel |
| p24 | `sus` | `0.7` | 0..1 | optionnel |
| p25 | `rel` | `0.2` | seconds | optionnel |
| p26 | `fatt` | `0.01` | - | optionnel |
| p27 | `fhold` | `0` | - | optionnel |
| p28 | `fdec` | `0.2` | - | optionnel |
| p29 | `fsus` | `0.7` | - | optionnel |
| p30 | `frel` | `0.2` | - | optionnel |
| p31 | `cutoff` | `8000` | Hz | optionnel |
| p32 | `envamt` | `0` | - | optionnel |
| p33 | `res` | `0.2` | - | optionnel |
| p34 | `filttype` | `0` | - | optionnel |
| p35 | `penvamt` | `0` | - | optionnel |
| p36 | `patt` | `0.01` | - | optionnel |
| p37 | `phold` | `0` | - | optionnel |
| p38 | `pdec` | `0.2` | - | optionnel |
| p39 | `lforate` | `5` | Hz | optionnel |
| p40 | `lfodepth` | `0` | - | optionnel |
| p41 | `drive` | `0` | - | optionnel |
| p42 | `pan1` | `0.5` | 0..1 | optionnel |
| p43 | `pan2` | `0.5` | 0..1 | optionnel |

## `analog2d`

Type: `instrument`  
Analog2d: dual-vco2 synth with interval/detune, PWM, sub, noise, pitch env, amp/filter AHDSR, selectable LP/BP/HP filter, drive, cutoff LFO, light k-rate FM, sync-like shaping, and portamento.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `wave1` | `0` | - | optionnel |
| p7 | `pw1` | `0.5` | - | optionnel |
| p8 | `pwmrate1` | `0.5` | Hz | optionnel |
| p9 | `pwmdepth1` | `0` | - | optionnel |
| p10 | `wave2` | `0` | - | optionnel |
| p11 | `pw2` | `0.5` | - | optionnel |
| p12 | `pwmrate2` | `0.5` | Hz | optionnel |
| p13 | `pwmdepth2` | `0` | - | optionnel |
| p14 | `vco2interval` | `0` | - | optionnel |
| p15 | `detune` | `0` | cents | optionnel |
| p16 | `mix2` | `0.5` | - | optionnel |
| p17 | `porta` | `0.01` | - | optionnel |
| p18 | `submix` | `0` | - | optionnel |
| p19 | `subwave` | `0` | - | optionnel |
| p20 | `noisemix` | `0` | - | optionnel |
| p21 | `att` | `0.01` | seconds | optionnel |
| p22 | `hold` | `0` | seconds | optionnel |
| p23 | `dec` | `0.2` | seconds | optionnel |
| p24 | `sus` | `0.7` | 0..1 | optionnel |
| p25 | `rel` | `0.2` | seconds | optionnel |
| p26 | `fatt` | `0.01` | - | optionnel |
| p27 | `fhold` | `0` | - | optionnel |
| p28 | `fdec` | `0.2` | - | optionnel |
| p29 | `fsus` | `0.7` | - | optionnel |
| p30 | `frel` | `0.2` | - | optionnel |
| p31 | `cutoff` | `8000` | Hz | optionnel |
| p32 | `envamt` | `0` | - | optionnel |
| p33 | `res` | `0.2` | - | optionnel |
| p34 | `filttype` | `0` | - | optionnel |
| p35 | `penvamt` | `0` | - | optionnel |
| p36 | `patt` | `0.01` | - | optionnel |
| p37 | `phold` | `0` | - | optionnel |
| p38 | `pdec` | `0.2` | - | optionnel |
| p39 | `lforate` | `5` | Hz | optionnel |
| p40 | `lfodepth` | `0` | - | optionnel |
| p41 | `drive` | `0` | - | optionnel |
| p42 | `fmamt` | `0` | - | optionnel |
| p43 | `syncamt` | `0` | - | optionnel |
| p44 | `pan1` | `0.5` | 0..1 | optionnel |
| p45 | `pan2` | `0.5` | 0..1 | optionnel |

## `ckanalog`

Type: `instrument`  
Cook-style analog synth: 2 VCO, 2 LFO PWM, glide, ringmod, resonant filter, stereo k-rate pan. Best used monophonically for authentic glide behaviour.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `porta` | `0.01` | - | optionnel |
| p7 | `vco2ratio` | `1` | - | optionnel |
| p8 | `detunehz` | `0` | Hz | optionnel |
| p9 | `vcf1` | `8000` | Hz | optionnel |
| p10 | `vcf2` | `2000` | Hz | optionnel |
| p11 | `rez` | `0.2` | - | optionnel |
| p12 | `wav1` | `0` | - | optionnel |
| p13 | `wav2` | `0` | - | optionnel |
| p14 | `lfowave` | `0` | - | optionnel |
| p15 | `lforate1` | `5` | Hz | optionnel |
| p16 | `lforate2` | `5` | Hz | optionnel |
| p17 | `ring` | `0` | - | optionnel |
| p18 | `pan1` | `0.5` | 0..1 | optionnel |
| p19 | `pan2` | `0.5` | 0..1 | optionnel |

## `cmjanalogpad`

Type: `instrument`  
AnalogPad adapted faithfully from Comajuncosas AnalogPad CSD version, using frequency input and k-rate stereo panning.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `pan1` | `0.5` | 0..1 | optionnel |
| p7 | `pan2` | `0.5` | 0..1 | optionnel |

## `compressor`

Type: `fx`  

Aucun p-field de score.

## `diskgrain1`

Type: `instrument`  
Synchronous granular synthesis from a soundfile using the Csound diskgrain opcode.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `file` | - | path | obligatoire |
| p5 | `amp` | `-24` | dBFS | optionnel |
| p6 | `freq` | `440` | Hz | optionnel |
| p7 | `pitch` | `1` | - | optionnel |
| p8 | `grsize` | `0.1` | - | optionnel |
| p9 | `prate` | `1` | ratio | optionnel |
| p10 | `envfn` | `1` | - | optionnel |
| p11 | `overlaps` | `4` | - | optionnel |
| p12 | `maxgrsize` | `0.1` | - | optionnel |
| p13 | `offset` | `0` | - | optionnel |
| p14 | `pan1` | `0.5` | 0..1 | optionnel |
| p15 | `pan2` | `0.5` | 0..1 | optionnel |

## `diskin2`

Type: `instrument`  
Audio-file player with variable speed, start offset, wrapping, envelope and stereo pan.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `file` | - | path | obligatoire |
| p5 | `amp` | `-24` | dBFS | optionnel |
| p6 | `speed` | `1` | - | optionnel |
| p7 | `skiptime` | `0` | seconds | optionnel |
| p8 | `wrap` | `0` | - | optionnel |
| p9 | `atk` | `0.01` | seconds | optionnel |
| p10 | `rel` | `0.2` | seconds | optionnel |
| p11 | `pan1` | `0.5` | 0..1 | optionnel |
| p12 | `pan2` | `0.5` | 0..1 | optionnel |

## `fm1`

Type: `instrument`  
Simple FM instrument.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `mod` | `1` | - | optionnel |
| p7 | `index1` | `1` | - | optionnel |
| p8 | `index2` | `1` | - | optionnel |
| p9 | `rise` | `0.01` | seconds | optionnel |
| p10 | `dec` | `0.2` | seconds | optionnel |
| p11 | `pan1` | `0.5` | 0..1 | optionnel |
| p12 | `pan2` | `0.5` | 0..1 | optionnel |

## `fmbasic`

Type: `instrument`  
Basic two-operator FM voice with controllable ratio and modulation index.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `pan1` | `0.5` | 0..1 | optionnel |
| p7 | `pan2` | `0.5` | 0..1 | optionnel |
| p8 | `factor` | `1` | - | optionnel |
| p9 | `index` | `1` | - | optionnel |

## `fmclarinet`

Type: `instrument`  
FM clarinet model with a controllable maximum modulation index.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `pan1` | `0.5` | 0..1 | optionnel |
| p7 | `pan2` | `0.5` | 0..1 | optionnel |
| p8 | `imax` | `1` | - | optionnel |

## `fmstring`

Type: `instrument`  
Evolving FM string voice with attack, decay and delayed vibrato.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `pan1` | `0.5` | 0..1 | optionnel |
| p7 | `pan2` | `0.5` | 0..1 | optionnel |
| p8 | `rise` | `0.01` | seconds | optionnel |
| p9 | `dec` | `0.2` | seconds | optionnel |
| p10 | `vibdel` | `5` | - | optionnel |
| p11 | `vibwth` | `0` | - | optionnel |
| p12 | `vibrate` | `5` | Hz | optionnel |

## `fmwooddrum`

Type: `instrument`  
Short percussive FM voice designed for wooden-drum timbres.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `pan1` | `0.5` | 0..1 | optionnel |
| p7 | `pan2` | `0.5` | 0..1 | optionnel |

## `grain1`

Type: `instrument`  
Granulator for soundfiles loaded in ftables.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `ft` | `1` | - | optionnel |
| p6 | `dens1` | `20` | - | optionnel |
| p7 | `dens2` | `20` | - | optionnel |
| p8 | `rise` | `0.01` | seconds | optionnel |
| p9 | `dec` | `0.2` | seconds | optionnel |
| p10 | `pan1` | `0.5` | 0..1 | optionnel |
| p11 | `pan2` | `0.5` | 0..1 | optionnel |

## `grain1b`

Type: `instrument`  
Granulator for soundfiles with fixed pitch-factor control.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `ft` | `1` | - | optionnel |
| p6 | `dens1` | `20` | - | optionnel |
| p7 | `dens2` | `20` | - | optionnel |
| p8 | `rise` | `0.01` | seconds | optionnel |
| p9 | `dec` | `0.2` | seconds | optionnel |
| p10 | `pan1` | `0.5` | 0..1 | optionnel |
| p11 | `pan2` | `0.5` | 0..1 | optionnel |
| p12 | `pitchfact` | `1` | - | optionnel |

## `grain2`

Type: `instrument`  
Granulator for generated ftables, not soundfiles.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `fn` | `1` | - | optionnel |
| p7 | `gdur` | `0.1` | - | optionnel |
| p8 | `ovrlp` | `4` | - | optionnel |
| p9 | `rise` | `0.01` | seconds | optionnel |
| p10 | `dec` | `0.2` | seconds | optionnel |
| p11 | `rndvarfrq1` | `1` | - | optionnel |
| p12 | `rndvarfrq2` | `1` | - | optionnel |
| p13 | `pan1` | `0.5` | 0..1 | optionnel |
| p14 | `pan2` | `0.5` | 0..1 | optionnel |

## `lposcil`

Type: `instrument`  
Looping audio file player based on lposcil. The file is passed in :file, loop points are in samples, and mono/stereo files are handled automatically.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `file` | - | path | obligatoire |
| p5 | `amp` | `-24` | dBFS | optionnel |
| p6 | `speed` | `1` | - | optionnel |
| p7 | `loopstart` | `0` | - | optionnel |
| p8 | `loopend` | `44100` | - | optionnel |
| p9 | `atk` | `0.01` | seconds | optionnel |
| p10 | `rel` | `0.2` | seconds | optionnel |
| p11 | `pan1` | `0.5` | 0..1 | optionnel |
| p12 | `pan2` | `0.5` | 0..1 | optionnel |

## `mincer1`

Type: `instrument`  
Mincer1: mono file playback via ftgen + mincer, with k-rate panning.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `file` | - | path | obligatoire |
| p6 | `pos1` | `0` | - | optionnel |
| p7 | `pos2` | `1` | - | optionnel |
| p8 | `pitch` | `1` | - | optionnel |
| p9 | `lock` | `1` | 0..1 | optionnel |
| p10 | `fftsize` | `1024` | - | optionnel |
| p11 | `decim` | `4` | - | optionnel |
| p12 | `pan1` | `0.5` | 0..1 | optionnel |
| p13 | `pan2` | `0.5` | 0..1 | optionnel |

## `mincer2`

Type: `instrument`  
Mincer2: file-based mincer instrument with AHDSR amplitude envelope, speed scan, freeze, position jitter, post-filter, and manual/autopan/random k-rate panning.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `file` | - | path | obligatoire |
| p6 | `startpos` | `0` | seconds | optionnel |
| p7 | `speed` | `1` | - | optionnel |
| p8 | `pitch` | `1` | - | optionnel |
| p9 | `lock` | `1` | 0..1 | optionnel |
| p10 | `fftsize` | `1024` | - | optionnel |
| p11 | `decim` | `4` | - | optionnel |
| p12 | `freeze` | `0` | 0..1 | optionnel |
| p13 | `jitterdepth` | `0` | - | optionnel |
| p14 | `jitterrate` | `5` | Hz | optionnel |
| p15 | `att` | `0.01` | seconds | optionnel |
| p16 | `hold` | `0` | seconds | optionnel |
| p17 | `dec` | `0.2` | seconds | optionnel |
| p18 | `sus` | `0.7` | 0..1 | optionnel |
| p19 | `rel` | `0.2` | seconds | optionnel |
| p20 | `cutoff` | `8000` | Hz | optionnel |
| p21 | `res` | `0.2` | - | optionnel |
| p22 | `filttype` | `0` | - | optionnel |
| p23 | `panmode` | `0` | selecteur 0/1/2 | optionnel |
| p24 | `pan1` | `0.5` | 0..1 | optionnel |
| p25 | `pan2` | `0.5` | 0..1 | optionnel |
| p26 | `panrate` | `5` | Hz | optionnel |
| p27 | `pandepth` | `0` | 0..1 | optionnel |

## `mincer3`

Type: `instrument`  
Mincer3: file-based mincer instrument with local loop window, crossfaded loop read, AHDSR amplitude envelope, speed, freeze, jitter, post-filter, and manual/autopan/random k-rate panning.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `file` | - | path | obligatoire |
| p6 | `startpos` | `0` | seconds | optionnel |
| p7 | `speed` | `1` | - | optionnel |
| p8 | `pitch` | `1` | - | optionnel |
| p9 | `lock` | `1` | 0..1 | optionnel |
| p10 | `fftsize` | `1024` | - | optionnel |
| p11 | `decim` | `4` | - | optionnel |
| p12 | `freeze` | `0` | 0..1 | optionnel |
| p13 | `jitterdepth` | `0` | - | optionnel |
| p14 | `jitterrate` | `5` | Hz | optionnel |
| p15 | `looplen` | `1` | seconds | optionnel |
| p16 | `xfade` | `0.05` | seconds | optionnel |
| p17 | `att` | `0.01` | seconds | optionnel |
| p18 | `hold` | `0` | seconds | optionnel |
| p19 | `dec` | `0.2` | seconds | optionnel |
| p20 | `sus` | `0.7` | 0..1 | optionnel |
| p21 | `rel` | `0.2` | seconds | optionnel |
| p22 | `cutoff` | `8000` | Hz | optionnel |
| p23 | `res` | `0.2` | - | optionnel |
| p24 | `filttype` | `0` | - | optionnel |
| p25 | `panmode` | `0` | selecteur 0/1/2 | optionnel |
| p26 | `pan1` | `0.5` | 0..1 | optionnel |
| p27 | `pan2` | `0.5` | 0..1 | optionnel |
| p28 | `panrate` | `5` | Hz | optionnel |
| p29 | `pandepth` | `0` | 0..1 | optionnel |

## `night`

Type: `instrument`  
String-pad borrowed from Bay at Night.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `pan1` | `0.5` | 0..1 | optionnel |
| p7 | `pan2` | `0.5` | 0..1 | optionnel |

## `noisesahenv`

Type: `instrument`  
Filtered noise texture with a unit envelope, moving LP/HP filters and sample-and-hold modulation.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | deprecie, sans effet |
| p6 | `pan1` | `0.5` | 0..1 | optionnel |
| p7 | `pan2` | `0.5` | 0..1 | optionnel |
| p8 | `sustain` | `0.7` | 0..1 | optionnel |
| p9 | `center` | `0.5` | 0..1 | optionnel |
| p10 | `lpf1` | `8000` | Hz | optionnel |
| p11 | `lpf2` | `2000` | Hz | optionnel |
| p12 | `lpfq` | `1` | Q | optionnel |
| p13 | `hpf1` | `20` | Hz | optionnel |
| p14 | `hpf2` | `20` | Hz | optionnel |
| p15 | `rate1lo` | `1` | Hz | optionnel |
| p16 | `rate1hi` | `10` | Hz | optionnel |
| p17 | `rate2lo` | `1` | Hz | optionnel |
| p18 | `rate2hi` | `10` | Hz | optionnel |
| p19 | `rate3` | `1` | Hz | optionnel |

## `noisesahenvdist`

Type: `instrument`  
Sample-and-hold noise texture with moving filters, resonance and distortion.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | deprecie, sans effet |
| p6 | `pan1` | `0.5` | 0..1 | optionnel |
| p7 | `pan2` | `0.5` | 0..1 | optionnel |
| p8 | `sustain` | `0.7` | 0..1 | optionnel |
| p9 | `center` | `0.5` | 0..1 | optionnel |
| p10 | `lpf1` | `8000` | Hz | optionnel |
| p11 | `lpf2` | `2000` | Hz | optionnel |
| p12 | `lpfq` | `1` | Q | optionnel |
| p13 | `hpf1` | `20` | Hz | optionnel |
| p14 | `hpf2` | `20` | Hz | optionnel |
| p15 | `rate1lo` | `1` | Hz | optionnel |
| p16 | `rate1hi` | `10` | Hz | optionnel |
| p17 | `rate2lo` | `1` | Hz | optionnel |
| p18 | `rate2hi` | `10` | Hz | optionnel |
| p19 | `rate3` | `1` | Hz | optionnel |
| p20 | `rescf1` | `1000` | Hz | optionnel |
| p21 | `rescf2` | `2000` | Hz | optionnel |
| p22 | `res1` | `0.2` | - | optionnel |
| p23 | `res2` | `0.2` | - | optionnel |
| p24 | `dist1` | `0` | - | optionnel |
| p25 | `dist2` | `0` | - | optionnel |

## `noisetambourine`

Type: `instrument`  
Percussive filtered-noise voice for tambourine-like attacks.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | deprecie, sans effet |
| p6 | `pan1` | `0.5` | 0..1 | optionnel |
| p7 | `pan2` | `0.5` | 0..1 | optionnel |

## `noiseunitenv`

Type: `instrument`  
White-noise voice with proportional envelope and moving low-pass filter.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | deprecie, sans effet |
| p6 | `pan1` | `0.5` | 0..1 | optionnel |
| p7 | `pan2` | `0.5` | 0..1 | optionnel |
| p8 | `sustain` | `0.7` | 0..1 | optionnel |
| p9 | `center` | `0.5` | 0..1 | optionnel |
| p10 | `cutoff1` | `8000` | Hz | optionnel |
| p11 | `cutoff2` | `2000` | Hz | optionnel |
| p12 | `q` | `1` | Q | optionnel |

## `noiseunitenvbp`

Type: `instrument`  
White-noise voice with proportional envelope and moving band-pass filter.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | deprecie, sans effet |
| p6 | `pan1` | `0.5` | 0..1 | optionnel |
| p7 | `pan2` | `0.5` | 0..1 | optionnel |
| p8 | `sustain` | `0.7` | 0..1 | optionnel |
| p9 | `center` | `0.5` | 0..1 | optionnel |
| p10 | `cf1` | `1000` | Hz | optionnel |
| p11 | `cf2` | `2000` | Hz | optionnel |
| p12 | `bw1` | `200` | - | optionnel |
| p13 | `bw2` | `200` | - | optionnel |

## `noisewhite`

Type: `instrument`  
Envelope-shaped stereo white-noise source.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | deprecie, sans effet |
| p6 | `pan1` | `0.5` | 0..1 | optionnel |
| p7 | `pan2` | `0.5` | 0..1 | optionnel |

## `noispitched`

Type: `instrument`  
Band-pass filtered noise with controllable center frequency and bandwidth.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | deprecie, sans effet |
| p6 | `pan1` | `0.5` | 0..1 | optionnel |
| p7 | `pan2` | `0.5` | 0..1 | optionnel |
| p8 | `cf` | `1000` | Hz | optionnel |
| p9 | `bw` | `200` | - | optionnel |

## `output`

Type: `output`  

Aucun p-field de score.

## `pad1`

Type: `instrument`  
Versatile pad using an externally defined wavetable.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `rise` | `0.01` | seconds | optionnel |
| p7 | `dec` | `0.2` | seconds | optionnel |
| p8 | `wave` | `0` | - | optionnel |

## `phasevocoderead`

Type: `instrument`  
Reads a phase-vocoder analysis file with bin, start and fade controls.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `analysis` | - | path | obligatoire |
| p5 | `amp` | `-24` | dBFS | optionnel |
| p6 | `freq` | `440` | Hz | deprecie, sans effet |
| p7 | `pan1` | `0.5` | 0..1 | optionnel |
| p8 | `pan2` | `0.5` | 0..1 | optionnel |
| p9 | `bin` | `0` | - | optionnel |
| p10 | `start` | `0` | - | optionnel |
| p11 | `fadein` | `0.01` | seconds | optionnel |
| p12 | `fadeout` | `0.2` | seconds | optionnel |

## `plateau1`

Type: `fx`  
Stereo plateau reverb with fixed internal settings; FX instances do not receive score pfields.

Aucun p-field de score.

## `pluckformant`

Type: `instrument`  
A pluck that slowly morphs into a vocal, formant derived sound.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `pan` | `0.5` | 0..1 | optionnel |
| p7 | `pluckamp` | `1` | - | optionnel |
| p8 | `pluckdur` | `0.2` | - | optionnel |
| p9 | `fmamp` | `1` | - | optionnel |
| p10 | `fmrise` | `0.01` | - | optionnel |
| p11 | `fmdec` | `0.2` | - | optionnel |
| p12 | `index` | `1` | - | optionnel |
| p13 | `vibdepth` | `0` | - | optionnel |
| p14 | `vibrate` | `5` | Hz | optionnel |
| p15 | `formantamp` | `1` | - | optionnel |
| p16 | `formantrise` | `0.01` | - | optionnel |

## `plucktamhats`

Type: `instrument`  
Percussive sound somewhere between tam-tam and high-hat.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `pan` | `0.5` | 0..1 | optionnel |
| p7 | `parm` | `0.5` | - | optionnel |
| p8 | `lpfreq` | `1000` | Hz | optionnel |

## `pluckunitenvelope`

Type: `instrument`  
A single pluck with a unit envelope and variable low pass filter.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `pan` | `0.5` | 0..1 | optionnel |
| p7 | `function` | `0` | - | optionnel |
| p8 | `method` | `0` | - | optionnel |
| p9 | `parm1` | `0.5` | - | optionnel |
| p10 | `parm2` | `0.5` | - | optionnel |
| p11 | `suspct` | `0.7` | - | optionnel |
| p12 | `suscenter` | `0.5` | - | optionnel |
| p13 | `lpfstart` | `8000` | Hz | optionnel |
| p14 | `lpfend` | `2000` | Hz | optionnel |
| p15 | `lpfq` | `1` | Q | optionnel |

## `poscilx2mod1`

Type: `instrument`  
Wavetable pad with two oscillators, sub oscillator, noise, drift, vibrato and selectable tables.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `atk` | `0.01` | seconds | optionnel |
| p7 | `rel` | `0.2` | seconds | optionnel |
| p8 | `detune` | `0` | cents | optionnel |
| p9 | `bright` | `8000` | Hz | optionnel |
| p10 | `vibdepth` | `0` | - | optionnel |
| p11 | `vibrate` | `5` | Hz | optionnel |
| p12 | `submix` | `0` | - | optionnel |
| p13 | `noisemix` | `0` | - | optionnel |
| p14 | `drift` | `0` | - | optionnel |
| p15 | `osc1fn` | `1` | - | optionnel |
| p16 | `osc2fn` | `1` | - | optionnel |
| p17 | `subfn` | `1` | - | optionnel |
| p18 | `vibfn` | `5` | - | optionnel |
| p19 | `pan1` | `0.5` | 0..1 | optionnel |
| p20 | `pan2` | `0.5` | 0..1 | optionnel |

## `reverberator4`

Type: `fx`  

Aucun p-field de score.

## `reverberator5`

Type: `fx`  

Aucun p-field de score.

## `reverberator50`

Type: `fx`  

Aucun p-field de score.

## `reverberator7`

Type: `fx`  

Aucun p-field de score.

## `reverberator70`

Type: `fx`  

Aucun p-field de score.

## `reverberator85`

Type: `fx`  

Aucun p-field de score.

## `reverberator90`

Type: `fx`  

Aucun p-field de score.

## `reverberator92`

Type: `fx`  

Aucun p-field de score.

## `reverberator95`

Type: `fx`  

Aucun p-field de score.

## `reverberator98`

Type: `fx`  

Aucun p-field de score.

## `samplercrossenv`

Type: `instrument`  
Cross-synthesis sampler combining two files through a moving spectral envelope.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `filea` | - | path | obligatoire |
| p5 | `fileb` | - | path | obligatoire |
| p6 | `amp` | `-24` | dBFS | optionnel |
| p7 | `freq` | `440` | Hz | deprecie, sans effet |
| p8 | `pan1` | `0.5` | 0..1 | optionnel |
| p9 | `pan2` | `0.5` | 0..1 | optionnel |
| p10 | `sustain` | `0.7` | 0..1 | optionnel |
| p11 | `center` | `0.5` | 0..1 | optionnel |
| p12 | `lpf1` | `8000` | Hz | optionnel |
| p13 | `lpf2` | `2000` | Hz | optionnel |
| p14 | `lpfq` | `1` | Q | optionnel |
| p15 | `skipa` | `0` | seconds | optionnel |
| p16 | `skipb` | `0` | seconds | optionnel |
| p17 | `fftsize` | `1024` | - | optionnel |
| p18 | `bias1` | `0.5` | - | optionnel |
| p19 | `bias2` | `0.5` | - | optionnel |

## `samplerraw`

Type: `instrument`  
Direct mono/stereo sound-file playback with amplitude envelope and moving pan.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `file` | - | path | obligatoire |
| p5 | `amp` | `-24` | dBFS | optionnel |
| p6 | `freq` | `440` | Hz | deprecie, sans effet |
| p7 | `pan1` | `0.5` | 0..1 | optionnel |
| p8 | `pan2` | `0.5` | 0..1 | optionnel |

## `samplerreverb`

Type: `instrument`  
Sound-file player with local reverb, envelope, skip time and moving pan.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `file` | - | path | obligatoire |
| p5 | `amp` | `-24` | dBFS | optionnel |
| p6 | `freq` | `440` | Hz | deprecie, sans effet |
| p7 | `pan1` | `0.5` | 0..1 | optionnel |
| p8 | `pan2` | `0.5` | 0..1 | optionnel |
| p9 | `skiptime` | `0` | seconds | optionnel |
| p10 | `atk` | `0.01` | seconds | optionnel |
| p11 | `rel` | `0.2` | seconds | optionnel |
| p12 | `rvbtime` | `1.5` | seconds | optionnel |
| p13 | `rvbgain` | `0` | - | optionnel |

## `samplersahenv`

Type: `instrument`  
Sound-file processor with proportional envelope, moving LP/HP filters and sample-and-hold modulation.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `file` | - | path | obligatoire |
| p5 | `amp` | `-24` | dBFS | optionnel |
| p6 | `freq` | `440` | Hz | deprecie, sans effet |
| p7 | `pan1` | `0.5` | 0..1 | optionnel |
| p8 | `pan2` | `0.5` | 0..1 | optionnel |
| p9 | `sustain` | `0.7` | 0..1 | optionnel |
| p10 | `center` | `0.5` | 0..1 | optionnel |
| p11 | `lpf1` | `8000` | Hz | optionnel |
| p12 | `lpf2` | `2000` | Hz | optionnel |
| p13 | `lpfq` | `1` | Q | optionnel |
| p14 | `skiptime` | `0` | seconds | optionnel |
| p15 | `hpf1` | `20` | Hz | optionnel |
| p16 | `hpf2` | `20` | Hz | optionnel |
| p17 | `rate1lo` | `1` | Hz | optionnel |
| p18 | `rate1hi` | `10` | Hz | optionnel |
| p19 | `rate2lo` | `1` | Hz | optionnel |
| p20 | `rate2hi` | `10` | Hz | optionnel |
| p21 | `rate3` | `1` | Hz | optionnel |

## `samplerunitenv`

Type: `instrument`  
Sound-file player with proportional envelope and moving low-pass filter.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `file` | - | path | obligatoire |
| p5 | `amp` | `-24` | dBFS | optionnel |
| p6 | `freq` | `440` | Hz | deprecie, sans effet |
| p7 | `pan1` | `0.5` | 0..1 | optionnel |
| p8 | `pan2` | `0.5` | 0..1 | optionnel |
| p9 | `sustain` | `0.7` | 0..1 | optionnel |
| p10 | `center` | `0.5` | 0..1 | optionnel |
| p11 | `cutoff1` | `8000` | Hz | optionnel |
| p12 | `cutoff2` | `2000` | Hz | optionnel |
| p13 | `q` | `1` | Q | optionnel |
| p14 | `skiptime` | `0` | seconds | optionnel |

## `samplerunitenvbp`

Type: `instrument`  
Sound-file player with proportional envelope and moving band-pass filter.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `file` | - | path | obligatoire |
| p5 | `amp` | `-24` | dBFS | optionnel |
| p6 | `freq` | `440` | Hz | deprecie, sans effet |
| p7 | `pan1` | `0.5` | 0..1 | optionnel |
| p8 | `pan2` | `0.5` | 0..1 | optionnel |
| p9 | `sustain` | `0.7` | 0..1 | optionnel |
| p10 | `center` | `0.5` | 0..1 | optionnel |
| p11 | `cf1` | `1000` | Hz | optionnel |
| p12 | `cf2` | `2000` | Hz | optionnel |
| p13 | `bw1` | `200` | - | optionnel |
| p14 | `bw2` | `200` | - | optionnel |
| p15 | `skiptime` | `0` | seconds | optionnel |

## `samplerunitenvdist`

Type: `instrument`  
Sound-file player with proportional envelope, waveshaping distortion and moving low-pass filter.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `file` | - | path | obligatoire |
| p5 | `amp` | `-24` | dBFS | optionnel |
| p6 | `freq` | `440` | Hz | deprecie, sans effet |
| p7 | `pan1` | `0.5` | 0..1 | optionnel |
| p8 | `pan2` | `0.5` | 0..1 | optionnel |
| p9 | `sustain` | `0.7` | 0..1 | optionnel |
| p10 | `center` | `0.5` | 0..1 | optionnel |
| p11 | `distin` | `0` | - | optionnel |
| p12 | `distout` | `0` | - | optionnel |
| p13 | `curvepos` | `1` | - | optionnel |
| p14 | `curveneg` | `1` | - | optionnel |
| p15 | `lpf1` | `8000` | Hz | optionnel |
| p16 | `lpf2` | `2000` | Hz | optionnel |
| p17 | `lpfq` | `1` | Q | optionnel |
| p18 | `skiptime` | `0` | seconds | optionnel |

## `samplerunitenvpeq`

Type: `instrument`  
Sound-file player with proportional envelope and time-varying parametric EQ.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `file` | - | path | obligatoire |
| p5 | `amp` | `-24` | dBFS | optionnel |
| p6 | `freq` | `440` | Hz | deprecie, sans effet |
| p7 | `pan1` | `0.5` | 0..1 | optionnel |
| p8 | `pan2` | `0.5` | 0..1 | optionnel |
| p9 | `sustain` | `0.7` | 0..1 | optionnel |
| p10 | `center` | `0.5` | 0..1 | optionnel |
| p11 | `cf1` | `1000` | Hz | optionnel |
| p12 | `cf2` | `2000` | Hz | optionnel |
| p13 | `q1` | `1` | Q | optionnel |
| p14 | `q2` | `1` | Q | optionnel |
| p15 | `gain1` | `1` | - | optionnel |
| p16 | `gain2` | `1` | - | optionnel |
| p17 | `filtertype` | `0` | - | optionnel |
| p18 | `skiptime` | `0` | seconds | optionnel |

## `sawdrone`

Type: `instrument`  
Saw drone borrowed from Christopher Ariza AthenaCL.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `pan1` | `0.5` | 0..1 | optionnel |
| p7 | `pan2` | `0.5` | 0..1 | optionnel |

## `sawunitenvelope`

Type: `instrument`  
Saw with unit-envelope style shaping.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `pan1` | `0.5` | 0..1 | optionnel |
| p7 | `pan2` | `0.5` | 0..1 | optionnel |
| p8 | `suspcent` | `0.7` | - | optionnel |
| p9 | `suscenterpcent` | `0.5` | - | optionnel |

## `sinedrone`

Type: `instrument`  
Sine drone borrowed from Christopher Ariza AthenaCL.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `pan1` | `0.5` | 0..1 | optionnel |
| p7 | `pan2` | `0.5` | 0..1 | optionnel |

## `sineunitenvelope`

Type: `instrument`  
Sine with unit-envelope style shaping.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `pan1` | `0.5` | 0..1 | optionnel |
| p7 | `pan2` | `0.5` | 0..1 | optionnel |
| p8 | `suspcent` | `0.7` | - | optionnel |
| p9 | `suscenterpcent` | `0.5` | - | optionnel |

## `synthrezzy`

Type: `instrument`  
Resonant synth with selectable waveform, filter sweep and controllable drive.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `sweep` | `2000` | - | optionnel |
| p7 | `rez` | `0.2` | - | optionnel |
| p8 | `wave` | `0` | - | optionnel |
| p9 | `drive` | `0` | - | optionnel |
| p10 | `pan1` | `0.5` | 0..1 | optionnel |
| p11 | `pan2` | `0.5` | 0..1 | optionnel |

## `synthvcoaudioenvelopesinequad`

Type: `instrument`  
VCO voice with proportional envelope, moving low-pass filter and four sine tremolo modulators.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `suspct` | `0.7` | - | optionnel |
| p7 | `suscenter` | `0.5` | - | optionnel |
| p8 | `lpfstart` | `8000` | Hz | optionnel |
| p9 | `lpfend` | `2000` | Hz | optionnel |
| p10 | `lpfq` | `1` | Q | optionnel |
| p11 | `wave` | `0` | - | optionnel |
| p12 | `widthstart` | `0.5` | - | optionnel |
| p13 | `widthend` | `0.5` | - | optionnel |
| p14 | `trem1start` | `1` | - | optionnel |
| p15 | `trem1end` | `1` | - | optionnel |
| p16 | `trem1amp` | `0` | - | optionnel |
| p17 | `trem2start` | `1` | - | optionnel |
| p18 | `trem2end` | `1` | - | optionnel |
| p19 | `trem2amp` | `0` | - | optionnel |
| p20 | `trem3start` | `1` | - | optionnel |
| p21 | `trem3end` | `1` | - | optionnel |
| p22 | `trem3amp` | `0` | - | optionnel |
| p23 | `trem4start` | `1` | - | optionnel |
| p24 | `trem4end` | `1` | - | optionnel |
| p25 | `trem4amp` | `0` | - | optionnel |
| p26 | `pan1` | `0.5` | 0..1 | optionnel |
| p27 | `pan2` | `0.5` | 0..1 | optionnel |

## `synthvcoaudioenvelopesquarequad`

Type: `instrument`  
VCO instrument with proportional macro envelope, low-pass filter and four square-based audio-rate tremolo modulators.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `suspct` | `0.7` | - | optionnel |
| p7 | `suscenter` | `0.5` | - | optionnel |
| p8 | `lpfstart` | `8000` | Hz | optionnel |
| p9 | `lpfend` | `2000` | Hz | optionnel |
| p10 | `lpfq` | `1` | Q | optionnel |
| p11 | `wave` | `0` | - | optionnel |
| p12 | `widthstart` | `0.5` | - | optionnel |
| p13 | `widthend` | `0.5` | - | optionnel |
| p14 | `trem1start` | `1` | - | optionnel |
| p15 | `trem1end` | `1` | - | optionnel |
| p16 | `trem1amp` | `0` | - | optionnel |
| p17 | `trem2start` | `1` | - | optionnel |
| p18 | `trem2end` | `1` | - | optionnel |
| p19 | `trem2amp` | `0` | - | optionnel |
| p20 | `trem3start` | `1` | - | optionnel |
| p21 | `trem3end` | `1` | - | optionnel |
| p22 | `trem3amp` | `0` | - | optionnel |
| p23 | `trem4start` | `1` | - | optionnel |
| p24 | `trem4end` | `1` | - | optionnel |
| p25 | `trem4amp` | `0` | - | optionnel |
| p26 | `pan1` | `0.5` | 0..1 | optionnel |
| p27 | `pan2` | `0.5` | 0..1 | optionnel |

## `synthvcodistort`

Type: `instrument`  
VCO instrument with proportional macro envelope, resonant lpf18 distortion stage and final low-pass filtering.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `suspct` | `0.7` | - | optionnel |
| p7 | `suscenter` | `0.5` | - | optionnel |
| p8 | `lpfstart` | `8000` | Hz | optionnel |
| p9 | `lpfend` | `2000` | Hz | optionnel |
| p10 | `lpfq` | `1` | Q | optionnel |
| p11 | `wave` | `0` | - | optionnel |
| p12 | `widthstart` | `0.5` | - | optionnel |
| p13 | `widthend` | `0.5` | - | optionnel |
| p14 | `rcfstart` | `1000` | Hz | optionnel |
| p15 | `rcfend` | `2000` | Hz | optionnel |
| p16 | `resstart` | `0.2` | - | optionnel |
| p17 | `resend` | `0.2` | - | optionnel |
| p18 | `diststart` | `0` | - | optionnel |
| p19 | `distend` | `0` | - | optionnel |
| p20 | `pan1` | `0.5` | 0..1 | optionnel |
| p21 | `pan2` | `0.5` | 0..1 | optionnel |

## `synthwaveformvibrato`

Type: `instrument`  
Waveform-morphing synth with delayed vibrato and layered detuned oscillators.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `atk` | `0.01` | seconds | optionnel |
| p7 | `rel` | `0.2` | seconds | optionnel |
| p8 | `vibdepth` | `0` | - | optionnel |
| p9 | `vibdelay` | `5` | - | optionnel |
| p10 | `vibrate` | `5` | Hz | optionnel |
| p11 | `wave1` | `0` | - | optionnel |
| p12 | `wave2` | `0` | - | optionnel |
| p13 | `xfade` | `0.05` | fraction de duree | optionnel |
| p14 | `pan1` | `0.5` | 0..1 | optionnel |
| p15 | `pan2` | `0.5` | 0..1 | optionnel |

## `trombone`

Type: `instrument`  
Trombone derived from Iain McCurdy's Csound Haiku I.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `note1` | `110` | - | optionnel |
| p6 | `note2` | `220` | - | optionnel |

## `vco2pad1`

Type: `instrument`  
Warm dual-VCO pad with detune, brightness, vibrato, sub oscillator and moving stereo pan.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `atk` | `0.01` | seconds | optionnel |
| p7 | `rel` | `0.2` | seconds | optionnel |
| p8 | `detune` | `0` | cents | optionnel |
| p9 | `bright` | `8000` | Hz | optionnel |
| p10 | `vibdepth` | `0` | - | optionnel |
| p11 | `vibrate` | `5` | Hz | optionnel |
| p12 | `submix` | `0` | - | optionnel |
| p13 | `pan1` | `0.5` | 0..1 | optionnel |
| p14 | `pan2` | `0.5` | 0..1 | optionnel |

## `vco2x2mod1`

Type: `instrument`  
Dual-VCO pad with PWM, detune, sub/noise mix, drift, vibrato and moving stereo pan.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `amp` | `-24` | dBFS | optionnel |
| p5 | `freq` | `440` | Hz | optionnel |
| p6 | `atk` | `0.01` | seconds | optionnel |
| p7 | `rel` | `0.2` | seconds | optionnel |
| p8 | `detune` | `0` | cents | optionnel |
| p9 | `bright` | `8000` | Hz | optionnel |
| p10 | `vibdepth` | `0` | - | optionnel |
| p11 | `vibrate` | `5` | Hz | optionnel |
| p12 | `pwm` | `0.5` | - | optionnel |
| p13 | `submix` | `0` | - | optionnel |
| p14 | `noisemix` | `0` | - | optionnel |
| p15 | `drift` | `0` | - | optionnel |
| p16 | `pan1` | `0.5` | 0..1 | optionnel |
| p17 | `pan2` | `0.5` | 0..1 | optionnel |

## `vocodenoiseoctscale`

Type: `instrument`  
Eight-band noise vocoder with scalable analysis and synthesis filter banks.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `file` | - | path | obligatoire |
| p5 | `amp` | `-24` | dBFS | optionnel |
| p6 | `freq` | `440` | Hz | deprecie, sans effet |
| p7 | `pan1` | `0.5` | 0..1 | optionnel |
| p8 | `pan2` | `0.5` | 0..1 | optionnel |
| p9 | `sustain` | `0.7` | 0..1 | optionnel |
| p10 | `center` | `0.5` | 0..1 | optionnel |
| p11 | `skiptime` | `0` | seconds | optionnel |
| p12 | `speed` | `1` | - | optionnel |
| p13 | `analysiscutoff` | `20` | Hz | optionnel |
| p14 | `bw` | `200` | - | optionnel |
| p15 | `analysisbase` | `200` | - | optionnel |
| p16 | `analysisscalar` | `1` | - | optionnel |
| p17 | `genbase` | `200` | - | optionnel |
| p18 | `genscalar` | `1` | - | optionnel |
| p19 | `lpf1` | `8000` | Hz | optionnel |
| p20 | `lpf2` | `2000` | Hz | optionnel |

## `vocodenoiseoctscaleremap`

Type: `instrument`  
Eight-band noise vocoder with scalable banks and explicit source-to-output remapping.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `file` | - | path | obligatoire |
| p5 | `amp` | `-24` | dBFS | optionnel |
| p6 | `freq` | `440` | Hz | deprecie, sans effet |
| p7 | `pan1` | `0.5` | 0..1 | optionnel |
| p8 | `pan2` | `0.5` | 0..1 | optionnel |
| p9 | `sustain` | `0.7` | 0..1 | optionnel |
| p10 | `center` | `0.5` | 0..1 | optionnel |
| p11 | `skiptime` | `0` | seconds | optionnel |
| p12 | `speed` | `1` | - | optionnel |
| p13 | `analysiscutoff` | `20` | Hz | optionnel |
| p14 | `bw` | `200` | - | optionnel |
| p15 | `analysisbase` | `200` | - | optionnel |
| p16 | `analysisscalar` | `1` | - | optionnel |
| p17 | `genbase` | `200` | - | optionnel |
| p18 | `genscalar` | `1` | - | optionnel |
| p19 | `src1` | `1` | - | optionnel |
| p20 | `src2` | `2` | - | optionnel |
| p21 | `src3` | `3` | - | optionnel |
| p22 | `src4` | `4` | - | optionnel |
| p23 | `src5` | `5` | - | optionnel |
| p24 | `src6` | `6` | - | optionnel |
| p25 | `src7` | `7` | - | optionnel |
| p26 | `src8` | `8` | - | optionnel |
| p27 | `post1` | `1` | - | optionnel |
| p28 | `post2` | `2` | - | optionnel |
| p29 | `post3` | `3` | - | optionnel |
| p30 | `post4` | `4` | - | optionnel |
| p31 | `post5` | `5` | - | optionnel |
| p32 | `post6` | `6` | - | optionnel |
| p33 | `post7` | `7` | - | optionnel |
| p34 | `post8` | `8` | - | optionnel |
| p35 | `lpf1` | `8000` | Hz | optionnel |
| p36 | `lpf2` | `2000` | Hz | optionnel |

## `vocodenoisequadremap`

Type: `instrument`  
Four-band noise vocoder with explicit analysis and synthesis center frequencies.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `file` | - | path | obligatoire |
| p5 | `amp` | `-24` | dBFS | optionnel |
| p6 | `freq` | `440` | Hz | deprecie, sans effet |
| p7 | `pan1` | `0.5` | 0..1 | optionnel |
| p8 | `pan2` | `0.5` | 0..1 | optionnel |
| p9 | `sustain` | `0.7` | 0..1 | optionnel |
| p10 | `center` | `0.5` | 0..1 | optionnel |
| p11 | `skiptime` | `0` | seconds | optionnel |
| p12 | `speed` | `1` | - | optionnel |
| p13 | `analysiscutoff` | `20` | Hz | optionnel |
| p14 | `bw` | `200` | - | optionnel |
| p15 | `acf1` | `200` | Hz | optionnel |
| p16 | `acf2` | `400` | Hz | optionnel |
| p17 | `acf3` | `800` | Hz | optionnel |
| p18 | `acf4` | `1600` | Hz | optionnel |
| p19 | `gcf1` | `200` | Hz | optionnel |
| p20 | `gcf2` | `400` | Hz | optionnel |
| p21 | `gcf3` | `800` | Hz | optionnel |
| p22 | `gcf4` | `1600` | Hz | optionnel |
| p23 | `lpf1` | `8000` | Hz | optionnel |
| p24 | `lpf2` | `2000` | Hz | optionnel |

## `vocodenoisequadscale`

Type: `instrument`  
Four-band noise vocoder with scalable analysis and synthesis filter banks.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `file` | - | path | obligatoire |
| p5 | `amp` | `-24` | dBFS | optionnel |
| p6 | `freq` | `440` | Hz | deprecie, sans effet |
| p7 | `pan1` | `0.5` | 0..1 | optionnel |
| p8 | `pan2` | `0.5` | 0..1 | optionnel |
| p9 | `sustain` | `0.7` | 0..1 | optionnel |
| p10 | `center` | `0.5` | 0..1 | optionnel |
| p11 | `skiptime` | `0` | seconds | optionnel |
| p12 | `speed` | `1` | - | optionnel |
| p13 | `analysiscutoff` | `20` | Hz | optionnel |
| p14 | `bw` | `200` | - | optionnel |
| p15 | `analysisbase` | `200` | - | optionnel |
| p16 | `analysisscalar` | `1` | - | optionnel |
| p17 | `genbase` | `200` | - | optionnel |
| p18 | `genscalar` | `1` | - | optionnel |
| p19 | `lpf1` | `8000` | Hz | optionnel |
| p20 | `lpf2` | `2000` | Hz | optionnel |

## `vocodenoisequadscaleremap`

Type: `instrument`  
Four-band scalable noise vocoder with explicit band remapping.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `file` | - | path | obligatoire |
| p5 | `amp` | `-24` | dBFS | optionnel |
| p6 | `freq` | `440` | Hz | deprecie, sans effet |
| p7 | `pan1` | `0.5` | 0..1 | optionnel |
| p8 | `pan2` | `0.5` | 0..1 | optionnel |
| p9 | `sustain` | `0.7` | 0..1 | optionnel |
| p10 | `center` | `0.5` | 0..1 | optionnel |
| p11 | `skiptime` | `0` | seconds | optionnel |
| p12 | `speed` | `1` | - | optionnel |
| p13 | `analysiscutoff` | `20` | Hz | optionnel |
| p14 | `bw` | `200` | - | optionnel |
| p15 | `analysisbase` | `200` | - | optionnel |
| p16 | `analysisscalar` | `1` | - | optionnel |
| p17 | `genbase` | `200` | - | optionnel |
| p18 | `genscalar` | `1` | - | optionnel |
| p19 | `src1` | `1` | - | optionnel |
| p20 | `src2` | `2` | - | optionnel |
| p21 | `src3` | `3` | - | optionnel |
| p22 | `src4` | `4` | - | optionnel |
| p23 | `post1` | `1` | - | optionnel |
| p24 | `post2` | `2` | - | optionnel |
| p25 | `post3` | `3` | - | optionnel |
| p26 | `post4` | `4` | - | optionnel |
| p27 | `lpf1` | `8000` | Hz | optionnel |
| p28 | `lpf2` | `2000` | Hz | optionnel |

## `vocodenoisesingle`

Type: `instrument`  
Single-band noise vocoder driven by a sound file.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `file` | - | path | obligatoire |
| p5 | `amp` | `-24` | dBFS | optionnel |
| p6 | `freq` | `440` | Hz | deprecie, sans effet |
| p7 | `pan1` | `0.5` | 0..1 | optionnel |
| p8 | `pan2` | `0.5` | 0..1 | optionnel |
| p9 | `sustain` | `0.7` | 0..1 | optionnel |
| p10 | `center` | `0.5` | 0..1 | optionnel |
| p11 | `skiptime` | `0` | seconds | optionnel |
| p12 | `analysiscutoff` | `20` | Hz | optionnel |
| p13 | `bw` | `200` | - | optionnel |
| p14 | `analysiscf` | `1000` | Hz | optionnel |
| p15 | `gencf` | `1000` | Hz | optionnel |

## `vocodenoisesinglegliss`

Type: `instrument`  
Single-band noise vocoder with a glissando between synthesis center frequencies.

| P-field | Parametre | Defaut | Unite | Statut |
|---:|---|---:|---|---|
| p4 | `file` | - | path | obligatoire |
| p5 | `amp` | `-24` | dBFS | optionnel |
| p6 | `freq` | `440` | Hz | deprecie, sans effet |
| p7 | `pan1` | `0.5` | 0..1 | optionnel |
| p8 | `pan2` | `0.5` | 0..1 | optionnel |
| p9 | `sustain` | `0.7` | 0..1 | optionnel |
| p10 | `center` | `0.5` | 0..1 | optionnel |
| p11 | `skiptime` | `0` | seconds | optionnel |
| p12 | `analysiscutoff` | `20` | Hz | optionnel |
| p13 | `bw` | `200` | - | optionnel |
| p14 | `analysiscf` | `1000` | Hz | optionnel |
| p15 | `gencf1` | `1000` | Hz | optionnel |
| p16 | `gencf2` | `2000` | Hz | optionnel |

