#!/bin/sh
set -eu

csd="/tmp/csound-framework-audio-smoke.csd"
wav="/tmp/csound-framework-audio-smoke.wav"
log="$(mktemp)"
trap 'rm -f "$log"' EXIT

sbcl --noinform --non-interactive --load tests/generate-audio-smoke-csd.lisp
csound -W -o "$wav" "$csd" >"$log" 2>&1

if grep -Eq 'overall amps:[[:space:]]+0\.00000[[:space:]]+0\.00000' "$log"; then
  cat "$log"
  printf '%s\n' "Audio smoke test produced silence." >&2
  exit 1
fi

sndfile-info "$wav" >/dev/null
printf '%s\n' "Audio smoke test passed: $wav"
