#!/bin/sh
set -eu

sbcl --noinform --non-interactive --load tests/run-tests.lisp
sbcl --noinform --non-interactive --load tests/generate-all-instruments-csd.lisp
csound --syntax-check-only /tmp/csound-framework-all.csd
./scripts/run-audio-smoke-tests.sh
