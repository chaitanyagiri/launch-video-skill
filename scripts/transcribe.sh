#!/usr/bin/env bash
# Transcribe a voice note or a video's audio to text.
# Usage: transcribe.sh <audio or video file> <out .txt>
# Tries, in order: local whisper CLI, whisper.cpp (whisper-cli with WHISPER_MODEL set),
# ElevenLabs Scribe (ELEVENLABS_API_KEY), OpenAI (OPENAI_API_KEY, paid per minute: ask the user first).
set -euo pipefail
in="${1:?file}"; out="${2:?out txt}"
tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
ffmpeg -v error -y -i "$in" -vn -ac 1 -ar 16000 "$tmp/a.wav"
if command -v whisper >/dev/null; then
  whisper "$tmp/a.wav" --model small --output_format txt --output_dir "$tmp" >/dev/null 2>&1 && cp "$tmp/a.txt" "$out" && exit 0
fi
if command -v whisper-cli >/dev/null && [ -n "${WHISPER_MODEL:-}" ]; then
  whisper-cli -m "$WHISPER_MODEL" -f "$tmp/a.wav" -otxt -of "$tmp/w" >/dev/null 2>&1 && cp "$tmp/w.txt" "$out" && exit 0
fi
if [ -n "${ELEVENLABS_API_KEY:-}" ]; then
  curl -s -X POST https://api.elevenlabs.io/v1/speech-to-text -H "xi-api-key: $ELEVENLABS_API_KEY" \
    -F model_id=scribe_v1 -F file=@"$tmp/a.wav" | python3 -c 'import json,sys; print(json.load(sys.stdin).get("text",""))' > "$out" && [ -s "$out" ] && exit 0
fi
if [ -n "${OPENAI_API_KEY:-}" ] && [ "${ALLOW_PAID_STT:-0}" = "1" ]; then
  curl -s https://api.openai.com/v1/audio/transcriptions -H "Authorization: Bearer $OPENAI_API_KEY" \
    -F model=whisper-1 -F response_format=text -F file=@"$tmp/a.wav" > "$out" && [ -s "$out" ] && exit 0
fi
echo "No transcriber available. Install whisper (pipx install openai-whisper), or set ELEVENLABS_API_KEY, or set ALLOW_PAID_STT=1 with OPENAI_API_KEY after the user agrees, or ask the user to type or dictate instead." >&2
exit 3
