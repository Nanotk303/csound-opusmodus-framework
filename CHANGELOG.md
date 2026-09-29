# Changelog

## 2026-09-29

- Synchronised the installed July core and instrument library.
- Added Emacs/Eldoc metadata helpers and unique global orchestra rendering.
- Replaced legacy ftgenonce usage in affected instruments.
- Renamed the FM violin label `continue`, a reserved word in Csound 7.
- Extended compilation coverage to all 12 effects as well as 64 instruments.
- Regenerated the full instrument catalogue and French PDF manual.
- Corrected documentation units for detunehz, lpfq, panmode, prate and xfade.
- Made minimal example output paths portable and corrected the pad example units.
- Added catalogue/source parity and shared-global regression checks.

## 2026-06-15

- Added per-instrument `:defaults`, `:required`, and `:deprecated` metadata
- Added legacy `:midi` to `:freq` conversion for frequency-native instruments
- Added offline rendering helpers and centralized LispWorks Csound paths
- Removed duplicate instrument definitions and active examples from the core
- Added generated instrument documentation and automated framework tests
- Added conservative parameter-range validation and audio smoke tests
- Corrected the manual and examples for the frequency-native API
- Made `lposcil` playback speed safe on Csound versions that crash in reverse
- Fixed `samplerreverb` so the wet signal follows the event amplitude
- Added the ten-minute `Les Seuils du Silence` demonstration score

## v1.0.0 — Initial Release

- Initial public release of the Csound–Opusmodus Framework
- Core DSL included in `src/Csound.lisp`
- Instrument library included in `src/CsoundInstrumentsLib.lisp`
- Full PDF manual added in `docs/Manuel_FR.pdf`
- Basic example patches added in `examples/`
