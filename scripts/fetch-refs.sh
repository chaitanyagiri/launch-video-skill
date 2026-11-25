#!/usr/bin/env bash
# Download example videos for study. Read only: no sign in, no cookies.
# Usage: fetch-refs.sh <out dir> <url> [<url> ...]
# Writes <out dir>/<nn>-<slug>/video.mp4 and meta.json (title, uploader, date, duration, views, likes, url).
set -euo pipefail
out="${1:?out dir}"; shift
command -v yt-dlp >/dev/null || { echo "yt-dlp not found: install it (pipx install yt-dlp or brew install yt-dlp), or use the agent-reach skill, or drop files in by hand." >&2; exit 2; }
mkdir -p "$out"
n=$(find "$out" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')
for url in "$@"; do
  n=$((n+1)); nn=$(printf '%02d' "$n")
  title=$(yt-dlp --no-warnings --skip-download --print '%(title)s' "$url" 2>/dev/null | head -1 || true)
  slug=$(printf '%s' "${title:-ref}" | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z0-9' '-' | sed 's/^-//; s/-$//' | cut -c1-40)
  d="$out/$nn-${slug:-ref}"; mkdir -p "$d"
  if yt-dlp --no-warnings -f 'bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]/bv*+ba/b' --merge-output-format mp4 \
       -o "$d/video.%(ext)s" --write-info-json "$url"; then
    info=$(ls "$d"/*.info.json 2>/dev/null | head -1 || true)
    if [ -n "$info" ]; then
      python3 - "$info" "$d/meta.json" "$url" <<'PY'
import json,sys
i=json.load(open(sys.argv[1]))
keys=['title','uploader','channel','upload_date','duration','width','height','fps','view_count','like_count','repost_count','comment_count','description']
m={k:i.get(k) for k in keys}; m['url']=sys.argv[3]
json.dump(m,open(sys.argv[2],'w'),indent=1,ensure_ascii=False)
PY
      rm -f "$info"
    fi
    echo "ok  $d"
  else
    echo "FAILED $url (try the agent-reach skill or ask the user for the file)" >&2
  fi
done
