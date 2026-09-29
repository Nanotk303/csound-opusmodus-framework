---
title: "Framework Csound pour Opusmodus"
subtitle: "Manuel utilisateur et reference"
author: "Stephane Boussuge"
date: "29 septembre 2026"
lang: fr-FR
geometry: margin=2cm
toc: true
toc-depth: 2
fontsize: 10pt
---

# Vue d'ensemble

**Prerequis : Csound 7 et Opusmodus.** Cette version du framework cible
Csound 7. Installez Csound 7 avant de configurer le chemin de l'executable.


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
  (list :csound-bin "/Applications/Csound/csound"
        :ssdir "/Users/stephaneboussuge/Samples"
        :sfdir "/Users/stephaneboussuge/CsoundOutput"
        :sadir "/Users/stephaneboussuge/CsoundAnalyses"
        :incdir "/Users/stephaneboussuge/CsoundInclude"))
```

`build-cs-options` transforme cette configuration en options Csound. La
variable d'environnement `CSOUND_BIN` peut uniquement remplacer le chemin de
l'executable si necessaire.

# Installation et exemples

Chargez `src/Csound.lisp`, puis `src/CsoundInstrumentsLib.lisp`, dans cet ordre.
Utilisez des chemins absolus, ou placez le repertoire de travail a la racine
du depot. Evitez de recharger une ancienne copie installee ensuite.
Les chemins de configuration ci-dessus sont ceux de l'auteur : adaptez-les.
Si vous modifiez le chemin de Csound apres le chargement, executez aussi :

```lisp
(setf *csound-bin* (getf *csound-config* :csound-bin))
```

Les exemples 01 et 02 ecrivent dans `~/Csoundscores/` et rendent un WAV sans
ouvrir d'application. L'exemple 03 est une composition de dix minutes qui
necessite vos propres fichiers audio et l'adaptation des chemins en tete de
fichier ; ces echantillons ne sont pas distribues.

Dans l'exemple `vco2pad1`, `:bright` est en Hz (2500), `:detune` en cents (7),
et `:vibdepth` est une modulation relative (0.003). Ce ne sont pas trois
controles normalises interchangeables.

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

Csound 7 est requis. Mise a jour validee avec Csound 7.0 sur macOS ARM64. La compilation couvre les 64 instruments et
les 12 effets ; le rendu audio teste une selection de familles, pas toutes
les combinaisons de parametres ni tous les fichiers utilisateurs.


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

# Integration Emacs et Eldoc

Le moteur expose `csound-emacs-instrument-names` (noms),
`csound-event-parameter-keywords` (mots-cles),
`csound-emacs-instrument-details` (fiche lisible) et
`csound-emacs-metadata` (plist pour un client Emacs). Le mode Emacs lui-meme
n'est pas inclus dans ce depot.

# Declarations globales

Les lignes `:globals` identiques sont emises une seule fois, avant les
instruments et les effets. Les oscillateurs partagent ainsi leurs tables.
Plusieurs instruments utilisent maintenant `ftgen` au lieu de `ftgenonce`.
Les lecteurs de fichiers concernes peuvent allouer une table par evenement :
surveillez la memoire pour les longues partitions avec beaucoup de samples.

# Lecture du catalogue

Le catalogue donne tous les noms, l'ordre exact des p-fields, les valeurs
par defaut et les champs obligatoires ou deprecies. `:start` et `:dur` sont
communs aux instruments et sont en secondes. Un tiret dans la colonne unite
signifie que l'unite n'est pas renseignee ; consultez le corps de l'instrument
pour ses controles specifiques. Les valeurs par defaut sont celles de l'API,
avant les bornages internes de l'instrument. Une valeur indiquee en Hz pour
un ancien champ `freq` deprecie reste sans effet sonore.

`panmode` de `mincer2` et `mincer3` selectionne 0 (trajectoire), 1 (LFO) ou
2 (aleatoire). `detunehz` est en Hz ; `detune` est en cents. `lpfq` est un
facteur Q. `xfade` de `synthwaveformvibrato` est une fraction de duree,
contrairement au temps de fondu en secondes de `mincer3`.

# Catalogue genere

Le contenu suivant est ajoute automatiquement lors de la construction du PDF.
