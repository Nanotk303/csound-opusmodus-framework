# csound-opusmodus-framework
![Status](https://img.shields.io/badge/status-active-brightgreen)
![License](https://img.shields.io/badge/license-MIT-blue)
Csound–Opusmodus Framework

A Unified DSL for Algorithmic Composition and Sound Synthesis

Author: Stéphane Boussuge
Year: 2026

⸻

Overview

The Csound–Opusmodus Framework is a Common Lisp domain-specific language (DSL) designed to unify algorithmic composition and sound synthesis within a single environment.

It enables composers to:
	•	Define Csound instruments using structured Lisp abstractions
	•	Generate musical material algorithmically in Opusmodus
	•	Control synthesis parameters through named fields
	•	Automatically construct audio routing graphs
	•	Render complete .csd files directly from Lisp
	•	Seamlessly switch between real-time playback and offline rendering

This framework bridges the gap between symbolic composition systems and low-level synthesis environments.

⸻

Core Philosophy

Rather than writing raw Csound code manually, the framework introduces a layered workflow:
	1.	Instruments are declared using a Lisp DSL
	2.	Musical events are generated via parameterized structures
	3.	A full Csound score is assembled automatically
	4.	Rendering and playback are controlled from within Opusmodus

Advantages
	•	Structural validation before rendering
	•	High reusability of instruments
	•	Clear separation between composition and synthesis
	•	Full compatibility with algorithmic processes

⸻

Architecture

Core Engine

src/Csound.lisp

Contains:
	•	DSL for instrument definition (defcsinstr)
	•	Event system (cs-event)
	•	Score generation (def-csound-score)
	•	Audio routing system
	•	Csound process management

⸻

Instrument Library

src/CsoundInstrumentsLib.lisp

	•	Drones and pads
	•	Granular synthesis
	•	FM synthesis
	•	Analog synthesis
	•	Sampling and spectral processing
	•	Noise and vocoder systems
	•	Effects (including plateau1 reverb)

⸻

Installation

Requirements
	•	Opusmodus
	•	Csound 6+
	•	Common Lisp (LispWorks recommended)

⸻

Setup

Clone the repository:

git clone https://github.com/YOUR_USERNAME/csound-opusmodus-framework.git

Load the framework:

(load "Csound.lisp")
(load "CsoundInstrumentsLib.lisp")

Basic Usage

Minimal Example

(in-package :opusmodus)

(def-csound-score
  :file "example.csd"
  :instruments '("sinedrone")
  :fx '("plateau1" "output")

  :score-headers
  '("f 0 60")

  :events
  (list
   (cs-event "sinedrone"
     :start '(0 10 20)
     :dur 8
     :amp -24
     :midi '(48 55 60)
     :pan1 0.2
     :pan2 0.8))

  :play nil)

(render-last-score :open t)

Key Concepts

Instrument Definition

(defcsinstr myinstrument
  (:type :instrument)
  (:pfields amp freq pan1 pan2)
  (:body
    (asig oscili amp freq 1)
    (outleta leftout asig)
    (outleta rightout asig)))


    Event Generation


    (cs-event "myinstrument"
  :start '(0 1 2 3)
  :dur 4
  :amp -20
  :freq '(220 330 440 550))

  Automatic Features
	•	Parameter validation
	•	List broadcasting
	•	Audio routing generation
	•	FX chain activation
	•	Score formatting

⸻

Audio Routing

Routing is automatically generated:


Instrument → FX → Output

Example:

:fx '("plateau1" "output")

Produces:

sinedrone → plateau1 → output


Rendering

Real-time playback

:play t

Offline rendering

(render-last-score :open t)

Example Content

examples/

Includes:
	•	Basic tests
	•	Algorithmic compositions
	•	Just intonation studies
	•	Granular textures

⸻

Best Practices
	•	Use absolute paths for production
	•	Keep output as the final FX stage
	•	Do not send events to FX or output modules
	•	Control amplitude to avoid signal overload
	•	Prefer offline rendering for debugging

⸻

Known Limitations
	•	Strict pfield mapping required
	•	No automatic amplitude normalization
	•	Requires external Csound installation

⸻

Applications
	•	Algorithmic composition
	•	Electroacoustic music
	•	Generative systems
	•	Research in computer-assisted composition
	•	Hybrid symbolic/audio workflows

⸻

Academic Context

This framework contributes to research in:
	•	Unified composition/synthesis environments
	•	DSL design for music systems
	•	Integration of symbolic and audio domains

⸻

License

MIT License

⸻

Author

Stéphane Boussuge
Composer — Algorithmic Composition Specialist

⸻

Acknowledgements
	•	Opusmodus
	•	Csound community
  
