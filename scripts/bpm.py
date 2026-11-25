#!/usr/bin/env python3
"""Measure a music bed's tempo and first downbeat, so cuts land on bars.
Usage: bpm.py <audio file> [min_bpm 70] [max_bpm 180]
Prints bpm, beat length, bar length (4/4) and the first strong onset. Needs ffmpeg and numpy.
Method: spectral flux onsets, then autocorrelation over the tempo range. Check the result by ear."""
import subprocess, sys
import numpy as np

path = sys.argv[1]
lo = float(sys.argv[2]) if len(sys.argv) > 2 else 70.0
hi = float(sys.argv[3]) if len(sys.argv) > 3 else 180.0
sr = 22050
raw = subprocess.run(["ffmpeg", "-v", "error", "-i", path, "-ac", "1", "-ar", str(sr), "-f", "f32le", "-"],
                     capture_output=True, check=True).stdout
x = np.frombuffer(raw, dtype=np.float32)
hop, win = 256, 1024
frames = np.lib.stride_tricks.sliding_window_view(x, win)[::hop] * np.hanning(win)
mag = np.abs(np.fft.rfft(frames, axis=1))
flux = np.maximum(0, np.diff(np.log1p(mag), axis=0)).sum(axis=1)
flux = (flux - flux.mean()) / (flux.std() + 1e-9)
fps = sr / hop
n = len(flux)
spec = np.fft.rfft(flux, 2 * n)
ac = np.fft.irfft(spec * np.conj(spec))[:n]
lags = np.arange(n, dtype=float)
# Score each candidate tempo on a fine grid by the autocorrelation at 1 to 8 beats,
# so a single noisy lag cannot win.
grid = np.arange(lo, hi, 0.02)
scores = []
for b in grid:
    lag = 60.0 * fps / b
    ks = lag * np.arange(1, 9)
    ks = ks[ks < n - 1]
    scores.append(np.interp(ks, lags, ac).sum() / max(len(ks), 1))
bpm = float(grid[int(np.argmax(scores))])
beat = 60.0 / bpm
first = np.argmax(flux > 2.0) / fps
print(f"bpm {bpm:.2f}\nbeat_s {beat:.5f}\nbar_s {4 * beat:.5f}\nfirst_strong_onset_s {first:.3f}")
