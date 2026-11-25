#!/usr/bin/env bash
# Measure one example: frames, contact sheet, facts (duration, size, fps, cuts, loudness), transcript.
# Usage: frames.sh <ref folder containing video.mp4> [seconds between frames, default 1]
set -euo pipefail
d="${1:?ref folder}"; step="${2:-1}"; v="$d/video.mp4"
[ -f "$v" ] || { echo "no $v" >&2; exit 2; }
here="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$d/frames"
ffmpeg -v error -y -i "$v" -vf "fps=1/$step,scale=960:-2" "$d/frames/f%03d.jpg"
ffmpeg -v error -y -i "$v" -vf "fps=1/$step,scale=240:-2,tile=8x6" -frames:v 1 "$d/sheet.jpg"
dur=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$v")
wh=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height,r_frame_rate -of csv=p=0 "$v")
cuts=$(ffmpeg -hide_banner -i "$v" -vf "select='gt(scene,0.3)',showinfo" -an -f null - 2>&1 | grep -o 'pts_time:[0-9.]*' | cut -d: -f2 | tr '\n' ' ')
loud=$(ffmpeg -hide_banner -i "$v" -af ebur128=peak=true -f null - 2>&1 | awk '/Integrated loudness/{f=1} f&&/I:/{print $2; exit}')
python3 - "$d/facts.json" "$dur" "$wh" "$cuts" "${loud:-}" <<'PY'
import json,sys
out,dur,wh,cuts,loud=sys.argv[1:6]
w,h,r=(wh.split(',')+['','',''])[:3]
try:
    a,b=r.split('/'); fps=round(float(a)/float(b),2)
except Exception: fps=None
c=[round(float(x),2) for x in cuts.split()]
gaps=[round(b-a,2) for a,b in zip([0.0]+c,c+[float(dur)])]
gaps_sorted=sorted(gaps)
json.dump({"duration_s":round(float(dur),2),"width":int(w) if w else None,"height":int(h) if h else None,"fps":fps,
           "scene_cuts_s":c,"shots":len(gaps),"median_shot_s":gaps_sorted[len(gaps_sorted)//2] if gaps_sorted else None,
           "integrated_lufs":float(loud) if loud else None},open(out,'w'),indent=1)
PY
[ -f "$d/transcript.txt" ] || "$here/transcribe.sh" "$v" "$d/transcript.txt" || echo "no transcript (see transcribe.sh)" >&2
echo "ok  $d (frames, sheet.jpg, facts.json)"
