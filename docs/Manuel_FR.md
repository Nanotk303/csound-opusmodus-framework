---
title: "Framework Csound pour Opusmodus"
subtitle: "Manuel utilisateur et reference"
author: "Stephane Boussuge"
date: "2026"
lang: fr-FR
geometry: margin=2cm
toc: true
toc-depth: 2
fontsize: 10pt
---

# Vue d'ensemble

Le framework relie la composition algorithmique d'Opusmodus a la synthese
Csound. Les instruments sont declares avec `defcsinstr`, les evenements avec
`cs-event`, puis `def-csound-score` produit un fichier CSD complet avec routage
audio.

Les fichiers principaux sont :

- `src/Csound.lisp` : moteur, DSL, validation, rendu et gestion de Csound ;
- `src/CsoundInstrumentsLib.lisp` : instruments, effets et sortie ;
- `docs/INSTRUMENTS.md` : catalogue genere depuis la bibliotheque ;
- `examples/` : exemples minimaux.

# Configuration LispWorks

LispWorks n'herite pas toujours du `PATH` et des variables du shell. Les
chemins Csound restent donc explicites dans `*csound-config*` :

```lisp
(defparameter *csound-config*
  (list :csound-bin "/usr/local/bin/csound"
        :ssdir "/Users/stephaneboussuge/Samples"
        :sfdir "/Users/stephaneboussuge/CsoundOutput"
        :sadir "/Users/stephaneboussuge/CsoundAnalyses"
        :incdir "/Users/stephaneboussuge/CsoundInclude"))
```

`build-cs-options` transforme cette configuration en options Csound. La
variable d'environnement `CSOUND_BIN` peut uniquement remplacer le chemin de
l'executable si necessaire.

# Definition d'un instrument

```lisp
(defcsinstr exemple
  (:type :instrument)
  (:pfields amp freq pan1 pan2)
  (:defaults :amp -24 :freq 440 :pan1 0.5 :pan2 0.5)
  (:outputs (leftout rightout))
  (:body
   "aSig poscil ampdb(p4), p5"
   "kPan line p6, p3, p7"
   "aL, aR pan2 aSig, kPan"
   "outleta \"leftout\", aL"
   "outleta \"rightout\", aR")
  (:doc "Instrument de demonstration."))
```

## Clauses disponibles

`(:type ...)`
: Type `:instrument`, `:fx` ou `:output`.

`(:pfields ...)`
: Ordre des parametres correspondant a `p4`, `p5`, etc.

`(:defaults ...)`
: Plist des valeurs utilisees lorsque l'evenement omet un parametre.

`(:required ...)`
: Parametres qui doivent toujours etre fournis, notamment les fichiers audio.

`(:deprecated ...)`
: Parametres conserves pour compatibilite mais sans effet sonore.

`(:globals ...)`, `(:inputs ...)`, `(:outputs ...)`, `(:body ...)`, `(:doc ...)`
: Code global, routage, corps Csound et documentation.

# Evenements et valeurs par defaut

Les seuls mots-cles toujours obligatoires pour un instrument autonome sont
`:start` et `:dur`. Les autres parametres utilisent les valeurs de la
definition :

```lisp
(cs-event "sinedrone"
  :start '(0 2 4)
  :dur 1.5
  :freq '(220 330 440))
```

Ici, `amp`, `pan1` et `pan2` prennent leurs valeurs par defaut. Le framework
refuse de produire un score contenant une valeur `NIL`.

Les lecteurs de fichiers declarent `file`, `filea`, `fileb` ou `analysis`
comme parametres obligatoires :

```lisp
(cs-event "samplerraw"
  :start 0
  :dur 4
  :file "/chemin/son.wav")
```

# Frequences et compatibilite MIDI

Les instruments synthetiques utilisent maintenant `:freq` en hertz. Pour les
anciens projets, `:midi` reste accepte lorsqu'un instrument declare `freq` :

```lisp
(cs-event "sinedrone" :start 0 :dur 2 :midi 69)
```

La valeur MIDI 69 est convertie en 440 Hz avant le rendu. Il ne faut pas
fournir simultanement `:midi` et `:freq`.

Certains anciens instruments de sampling, bruit et vocodeur conservaient un
champ MIDI qui n'a jamais influence leur son. Ce champ est maintenu sous le nom
`freq` pour ne pas decaler les p-fields historiques, mais il est indique comme
deprecie et sans effet dans le catalogue.

# Generation d'un score

```lisp
(def-csound-score
  :file "/Users/stephaneboussuge/Csoundscores/Test.csd"
  :instruments '("sinedrone")
  :fx '("plateau1" "output")
  :score-headers '("f 0 10")
  :events
  (list
   (cs-event "sinedrone"
     :start '(0 2 4)
     :dur 2
     :freq '(220 330 440)))
  :play nil)
```

Le routage par defaut relie tous les instruments au premier effet, puis chaque
effet au suivant. `output` doit rester le dernier element de `:fx`.

`plateau1` utilise actuellement des reglages internes fixes. Il ne recoit donc
pas de p-fields de score, contrairement a ce qu'indiquait l'ancien manuel.

# Rendu offline

`def-csound-score` memorise le dernier fichier ecrit. Deux fonctions permettent
ensuite le rendu WAV :

```lisp
(render-score "/chemin/score.csd")
(render-last-score :open t :print-command t)
```

Le fichier WAV est place par defaut a cote du CSD.

# Inspection et documentation

```lisp
(list-csound-instruments)
(describe-csound-instrument "vco2pad1")
(generate-instrument-catalog "docs/INSTRUMENTS.md")
```

Le catalogue ne doit pas etre corrige a la main. Il est regenere par :

```bash
sbcl --noinform --non-interactive --load scripts/generate-catalog.lisp
```

# Tests

```bash
./scripts/run-tests.sh
```

Les tests verifient le chargement de la bibliotheque, la couverture des
valeurs par defaut, les parametres obligatoires, l'alias MIDI, la generation
du catalogue, les plages communes, la compilation Csound de l'ensemble des
instruments et un rendu audio de plusieurs familles de synthese.

Les panoramiques et proportions courantes doivent rester entre `0` et `1`, les
frequences doivent etre strictement positives et les temps courants ne peuvent
pas etre negatifs. Un parametre deprecie explicitement fourni produit un
avertissement, sans interrompre les anciens projets.

# Catalogue genere

Le contenu suivant est ajoute automatiquement lors de la construction du PDF.
