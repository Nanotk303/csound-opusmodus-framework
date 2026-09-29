# Validation - 2026-09-29

**Requirement: Csound 7.** This release targets Csound 7.

Environment: macOS ARM64, SBCL 2.6.4, Csound 7.0 (build 2026-07-09).

- Registry: 77 entries, comprising 64 instruments, 12 effects and one output.
- Catalogue: 883 declared parameter rows, in p-field order, generated from the
  loaded library with defaults and required/deprecated markers.
- Tests require exact equality between the committed catalogue and a fresh
  generation; they also check default coverage, metadata field membership,
  duplicate parameters, editor metadata, unit exceptions and shared globals.
- Csound syntax compilation: all 64 instruments and all 12 effects, zero errors.
- Audio smoke test: sine drone, VCO pad, analog synth, FM and white noise;
  WAV produced and non-silent according to the Csound amplitude summary.
- Examples 01 and 02: rendered with zero Csound errors and zero out-of-range
  samples. Only the output destination was redirected to a temporary directory.
- French PDF regenerated from the manual and the same instrument catalogue;
  all pages visually reviewed.

Reproduce core, catalogue, compilation and audio checks with
`./scripts/run-tests.sh`. Build the catalogue and PDF with
`./scripts/build-docs.sh` (see README for dependencies).

These checks do not certify every parameter combination or every instrument's
sound. Csound 6 and a live Opusmodus/LispWorks session were not retested in this
update. The ten-minute example requires personal sample files and was not
rendered. The PDF catalogue leaves unspecified units as `-`; consult each
instrument body for its detailed synthesis behaviour and internal clamping.
