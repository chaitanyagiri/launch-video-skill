#!/usr/bin/env bash
# Loudness master (two pass loudnorm, video copied) and an optional share copy.
# Usage: master.sh <in.mp4> <out.mp4> [--lufs -14] [--tp -1] [--share]
# --share also writes <out>-share.mp4 (x264 crf 19, small enough for chat apps).
set -euo pipefail
in="${1:?in}"; out="${2:?out}"; shift 2
I=-14; TP=-1; SHARE=0
while [ $# -gt 0 ]; do case "$1" in --lufs) I="$2"; shift 2;; --tp) TP="$2"; shift 2;; --share) SHARE=1; shift;; *) echo "unknown $1" >&2; exit 2;; esac; done
m=$(ffmpeg -hide_banner -i "$in" -af "loudnorm=I=$I:TP=$TP:LRA=11:print_format=json" -f null - 2>&1 | sed -n '/^{/,/^}/p')
get(){ printf '%s' "$m" | python3 -c "import json,sys; print(json.load(sys.stdin)['$1'])"; }
ffmpeg -v error -y -i "$in" -c:v copy -af "loudnorm=I=$I:TP=$TP:LRA=11:measured_I=$(get input_i):measured_TP=$(get input_tp):measured_LRA=$(get input_lra):measured_thresh=$(get input_thresh):offset=$(get target_offset):linear=true" -c:a aac -b:a 256k "$out"
echo "master $out"
if [ "$SHARE" = 1 ]; then
  s="${out%.mp4}-share.mp4"
  ffmpeg -v error -y -i "$out" -c:v libx264 -preset slow -crf 19 -pix_fmt yuv420p -c:a copy -movflags +faststart "$s"
  echo "share  $s ($(du -h "$s" | cut -f1))"
fi
