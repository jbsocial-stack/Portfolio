#!/usr/bin/env bash
# Build the deployable site into _site/ with every HTML page password-protected.
# Usage: STATICRYPT_PASSWORD=... scripts/build.sh
set -euo pipefail

: "${STATICRYPT_PASSWORD:?Set STATICRYPT_PASSWORD (the SITE_PASSWORD repo secret in CI)}"

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$ROOT/_site"
STATICRYPT="${STATICRYPT:-npx --yes staticrypt@3.5.4}"

rm -rf "$OUT"
mkdir -p "$OUT"
cp -r "$ROOT/index.html" "$ROOT/robots.txt" "$ROOT/assets" "$ROOT/work" "$OUT/"

# Encrypt each folder's pages in place. The shared salt lets one password
# (and "Remember me") unlock every page.
find "$OUT" -name '*.html' -printf '%h\n' | sort -u | while read -r dir; do
  (
    cd "$dir"
    # shellcheck disable=SC2086
    $STATICRYPT *.html -d . \
      -c "$(realpath --relative-to="$dir" "$ROOT/.staticrypt.json")" \
      -t "$ROOT/.staticrypt/template.html" \
      --short --remember 30 \
      --template-title "John Sandberg" \
      --template-instructions "This portfolio is private. Enter the password you were given to continue." \
      --template-button "View portfolio" \
      --template-placeholder "Password" \
      --template-remember "Remember me on this device" \
      --template-error "That password didn't work. Please try again."
  )
done

echo "Built $(find "$OUT" -name '*.html' | wc -l) protected pages in $OUT"
