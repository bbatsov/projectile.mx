#!/bin/bash
# Re-record the screencasts and screenshots in static/media.
#
# Needs a Projectile checkout, a GUI Emacs, Go and ImageMagick. The demos browse
# a few real repositories under ~/projects (opened read-only) plus a small Go
# project copied to a scratch directory. A small Emacs frame takes over the
# screen for a couple of minutes - don't type while it's up.
#
#   PROJECTILE_DIR=~/projects/projectile ./capture/run.sh
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
media="${MEDIA:-$here/../static/media}"
emacs="${EMACS:-/Applications/Emacs.app/Contents/MacOS/Emacs}"

cd "$here"
rm -rf frames capture.log
mkdir -p frames

# The Go project, as a fresh git repository, plus a throwaway emacs.d.
scratch="$(mktemp -d)"
trap 'rm -rf "$scratch"' EXIT
cp -R fixture/acme-billing "$scratch/"
(cd "$scratch/acme-billing" && git init -q -b main && git add -A && \
   git -c user.name=demo -c user.email=demo@example.com commit -qm "Initial import")
mkdir -p "$scratch/emacs.d"

PROJECTILE_DIR="${PROJECTILE_DIR:-$HOME/projects/projectile}" \
GIF_DIR="$here" GIF_NAME=projectile PJ_SCRATCH="$scratch" \
  "$emacs" -Q --eval "(load \"$here/projectile.el\")"
cat capture.log

gif() {
  local name="$1" args=()
  for f in frames/"$name"-*.png; do
    d="${f##*-d}"; args+=(-delay "${d%.png}" "$f")
  done
  magick "${args[@]}" -resize 960x -fuzz 3% -layers Optimize -loop 0 "$media/$name.gif"
}
for g in switch-project find-file search test; do gif "$g"; done

still() { magick "$1" -resize 1000x -quality 84 "$media/$2.webp"; }
still "$(ls frames/dispatch-*.png | tail -1)" dispatch
still "$(ls frames/dashboard-*.png | tail -1)" dashboard
still "$(ls frames/siblings-*.png | head -1)" siblings
still "$(ls frames/replace-*.png | tail -1)" replace
ls -l "$media"
