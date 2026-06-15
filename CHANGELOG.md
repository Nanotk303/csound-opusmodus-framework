# Changelog

## Unreleased

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
- Full PDF manual added in `docs/manual.pdf`
- Basic example patches added in `examples/`
