#!/bin/sh
set -eu

sbcl --noinform --non-interactive --load scripts/generate-catalog.lisp

tmp_file="$(mktemp)"
trap 'rm -f "$tmp_file"' EXIT

cat docs/Manuel_FR.md docs/INSTRUMENTS.md > "$tmp_file"

pandoc "$tmp_file" \
  --from gfm+yaml_metadata_block \
  --pdf-engine=xelatex \
  --variable mainfont="Helvetica Neue" \
  --variable monofont="Menlo" \
  --output docs/Manuel_FR.pdf

printf '%s\n' "Generated docs/Manuel_FR.pdf"
