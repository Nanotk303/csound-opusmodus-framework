# Csound–Opusmodus Framework
### A Unified DSL for Algorithmic Composition and Sound Synthesis

![Status](https://img.shields.io/badge/status-active-brightgreen)
![License](https://img.shields.io/badge/license-MIT-blue)

**Author:** Stéphane Boussuge  
**Year:** 2026

---

**Requires Csound 7.**

**Updated: 2026-09-29.** The instrument catalogue is generated from this revision of the source.

## Overview

The **Csound–Opusmodus Framework** is a Common Lisp domain-specific language (DSL) designed to unify **algorithmic composition** and **sound synthesis** within a single environment.

It enables composers to:

- Define Csound instruments using structured Lisp abstractions
- Generate musical material algorithmically in Opusmodus
- Control synthesis parameters through named fields
- Declare safe defaults and required parameters per instrument
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
│   ├── Manuel_FR.md
│   ├── Manuel_FR.pdf
│   └── INSTRUMENTS.md
├── scripts/
│   ├── build-docs.sh
│   └── generate-catalog.lisp
├── tests/
│   └── run-tests.lisp
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
- **Csound 7** (required; this version of the framework targets Csound 7)
- Common Lisp environment (LispWorks recommended)

---

## Installation

Clone the repository:

```bash
git clone https://github.com/Nanotk303/csound-opusmodus-framework.git
```

Evaluate `Csound.lisp` and `CsoundInstrumentsLib.lisp` in Opusmodus for a quick
test. For installation, load `src/Csound.lisp` first, then `src/CsoundInstrumentsLib.lisp`.
Use absolute paths when loading from Opusmodus, or set the working directory
to the repository root. Avoid loading an older installed copy afterwards.

The explicit paths in `*csound-config*` are intentional: LispWorks may not
inherit the shell `PATH` and Csound environment variables. Adjust that plist to
match your machine.


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
     :freq '(130.81 196.00 261.63)))
  :play nil)

(render-last-score :open t)
```

---

## Included Examples

- `examples/01_basic_test.lisp` — minimal test using `sinedrone`
- `examples/02_vco2pad_demo.lisp` — simple texture with `vco2pad1`; brightness in Hz, detune in cents
- `examples/03_mysterious_meditation_10min.lisp` — ten-minute composition; requires your own sample files and edited paths. Load the framework first.

The first two examples write to `~/Csoundscores/` and render WAV without opening
another application. Run their relative `load` forms from the repository root.

---

## Documentation

The manual and generated instrument reference are available in:

```text
docs/Manuel_FR.md
docs/Manuel_FR.pdf
docs/INSTRUMENTS.md
```

Instrument parameters, defaults and required/deprecated status are generated
directly from the `defcsinstr` definitions. Rebuild the documentation with:

```bash
./scripts/build-docs.sh
```

Building the PDF requires SBCL, Pandoc, XeLaTeX, Helvetica Neue and Menlo.
The checks require SBCL, Csound and `sndfile-info` (libsndfile).

Run the framework checks with:

```bash
./scripts/run-tests.sh
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

- Some legacy sampling/noise/vocoder `freq` fields remain accepted but are
  deprecated because they never affected the original instruments
- `plateau1` currently uses fixed internal settings
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

## Emacs integration

The core provides `csound-emacs-instrument-names`,
`csound-event-parameter-keywords`, `csound-emacs-instrument-details` and
`csound-emacs-metadata` for completion and Eldoc clients. An Emacs mode is not
bundled in this repository.

## Sharing and compatibility

See the [French manual](docs/Manuel_FR.md) and the
[complete instrument and parameter catalogue](docs/INSTRUMENTS.md).
Personal sample files are not included. `*csound-config*` contains the author's
installation paths; edit them before use. After changing the executable path
at runtime, also set `*csound-bin*`. The latest validation environment is
recorded in [VALIDATION.md](docs/VALIDATION.md).
