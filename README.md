# Csound–Opusmodus Framework
### A Unified DSL for Algorithmic Composition and Sound Synthesis

![Status](https://img.shields.io/badge/status-active-brightgreen)
![License](https://img.shields.io/badge/license-MIT-blue)

**Author:** Stéphane Boussuge  
**Year:** 2026

---

## Overview

The **Csound–Opusmodus Framework** is a Common Lisp domain-specific language (DSL) designed to unify **algorithmic composition** and **sound synthesis** within a single environment.

It enables composers to:

- Define Csound instruments using structured Lisp abstractions
- Generate musical material algorithmically in Opusmodus
- Control synthesis parameters through named fields
- Automatically construct audio routing graphs
- Render complete `.csd` files directly from Lisp
- Seamlessly switch between real-time playback and offline rendering

This framework bridges the gap between **symbolic composition systems** and **low-level synthesis environments**.

---

## Core Philosophy

Rather than writing raw Csound code manually, the framework introduces a layered workflow:

1. Instruments are declared using a Lisp DSL
2. Musical events are generated via parameterized structures
3. A full Csound score is assembled automatically
4. Rendering and playback are controlled from within Opusmodus

### Advantages

- Structural validation before rendering
- High reusability of instruments
- Clear separation between composition and synthesis
- Full compatibility with algorithmic processes

---

## Repository Structure

```text
csound-opusmodus-framework/
├── src/
│   ├── Csound.lisp
│   └── CsoundInstrumentsLib.lisp
├── examples/
│   ├── 01_basic_test.lisp
│   ├── 02_vco2pad_demo.lisp
│   └── audio/
├── docs/
│   └── manual.pdf
├── .gitignore
├── LICENSE
├── CHANGELOG.md
└── README.md
```

---

## Architecture

### Core Engine
```text
src/Csound.lisp
```

Contains:

- DSL for instrument definition (`defcsinstr`)
- Event system (`cs-event`)
- Score generation (`def-csound-score`)
- Audio routing system
- Csound process management

### Instrument Library
```text
src/CsoundInstrumentsLib.lisp
```

Includes:

- Drones and pads
- Granular synthesis
- FM synthesis
- Analog synthesis
- Sampling and spectral processing
- Noise and vocoder systems
- Effects (including `plateau1`)

---

## Requirements

- Opusmodus
- Csound 6+
- Common Lisp environment (LispWorks recommended)

---

## Installation

Clone the repository:

```bash
git clone https://github.com/YOUR_USERNAME/csound-opusmodus-framework.git
```

Evaluate the Csound.lisp and CsoundInstrumentsLib.lisp in Opusmodus for a quick test. For installation, copy Csound.lisp in Opusmodus/User Source/Extensions directory and CsoundInstrumentsLib.lisp in Opusmodus/User Source/Libraries 
and restart Opusmodus


---

## Quick Start

Open `examples/01_basic_test.lisp`, adjust the `:file` path if needed, then evaluate.

```lisp
(in-package :opusmodus)


(def-csound-score
  :file "/absolute/path/to/Basic_Test.csd"
  :instruments '("sinedrone")
  :fx '("plateau1" "output")
  :score-headers '("f 0 30")
  :events
  (list
   (cs-event "sinedrone"
     :start '(0 5 10)
     :dur 8
     :amp '(-24 -25 -26)
     :midi '(48 55 60)
     :pan1 0.2
     :pan2 0.8))
  :play nil)

(render-last-score :open t)
```

---

## Included Examples

- `examples/01_basic_test.lisp` — minimal test using `sinedrone`
- `examples/02_vco2pad_demo.lisp` — simple texture with `vco2pad1`

---

## Documentation

Full manual available in:

```text
docs/manual.pdf
```

---

## Best Practices

- Use absolute paths for production score files
- Keep `output` as the final FX stage
- Do not send events directly to FX or output modules
- Control amplitude carefully in dense textures
- Prefer offline rendering for debugging and waveform inspection

---

## Known Limitations

- Strict pfield mapping is required
- External Csound installation is necessary
- Signal normalization remains the composer's responsibility

---

## Applications

- Algorithmic composition
- Electroacoustic music
- Generative systems
- Research in computer-assisted composition
- Hybrid symbolic/audio workflows

---

## Academic Context

This framework contributes to research in:

- Unified composition/synthesis environments
- DSL design for music systems
- Integration of symbolic and audio domains

---

## License

This project is released under the MIT License. See `LICENSE`.

---

## Author

**Stéphane Boussuge**  
Composer — Algorithmic Composition Specialist

---

## Acknowledgements

- Opusmodus
- The Csound community
- Research in computer-assisted composition
