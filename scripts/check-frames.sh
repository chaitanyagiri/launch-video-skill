#!/usr/bin/env bash
# Pull evenly spaced review frames and a contact sheet from a render, plus loudness.
# Usage: check-frames.sh <film.mp4> [count, default 24]
# Writes <film>-review/f01.jpg ... and sheet.jpg. Look at EVERY frame (see references/review.md).
set -euo pipefail
v="${1:?film}"; n="${2:-24}"
d="${v%.mp4}-review"; mkdir -p "$d"
dur=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$v")
for i in $(seq 1 "$n"); do
  t=$(python3 -c "print(round($dur*($i-0.5)/$n,3))")
  ffmpeg -v error -y -ss "$t" -i "$v" -frames:v 1 -vf scale=1280:-2 "$d/f$(printf '%02d' "$i").jpg"
done
cols=6; rows=$(( (n + cols - 1) / cols ))
ffmpeg -v error -y -pattern_type glob -i "$d/f*.jpg" -vf "scale=320:-2,tile=${cols}x${rows}" -frames:v 1 "$d/sheet.jpg"
ffmpeg -hide_banner -i "$v" -af ebur128=peak=true -f null - 2>&1 | awk '/Summary/{f=1} f' | grep -E "I:|Peak:" | head -2
echo "frames in $d"
