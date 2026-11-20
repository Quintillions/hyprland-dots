#!/usr/bin/env python3
"""Procedural placeholder wallpaper: moonlit fir forest under a Brocken-like ridge (original artwork).
Usage: python3 tools/gen_wallpaper.py out.png [seed]"""
import sys, random, math
import numpy as np
from PIL import Image, ImageDraw, ImageFilter

W, H = 2560, 1440
out = sys.argv[1] if len(sys.argv) > 1 else "hexenwald-placeholder.png"
random.seed(int(sys.argv[2]) if len(sys.argv) > 2 else 1651)
rng = np.random.default_rng(1651)

def lerp(a, b, t): return tuple(int(a[i] + (b[i] - a[i]) * t) for i in range(3))
TIEF, MOOS, TANNE, NEBEL, MOND, BRONZE = (17,23,19), (38,55,43), (53,74,56), (133,139,124), (213,212,195), (146,123,79)

# sky
sky = Image.new("RGB", (W, H))
d = ImageDraw.Draw(sky)
for y in range(H):
    d.line([(0, y), (W, y)], fill=lerp(TIEF, lerp(MOOS, TANNE, 0.35), min(1, (y / H) ** 1.4)))

# moon with glow
glow = Image.new("L", (W, H), 0)
gd = ImageDraw.Draw(glow)
mx, my, mr = 1830, 360, 118
for r, a in ((520, 14), (380, 22), (260, 34), (190, 50)):
    gd.ellipse([mx - r, my - r, mx + r, my + r], fill=a)
glow = glow.filter(ImageFilter.GaussianBlur(70))
sky = Image.composite(Image.new("RGB", (W, H), MOND), sky, glow)
d = ImageDraw.Draw(sky)
d.ellipse([mx - mr, my - mr, mx + mr, my + mr], fill=MOND)
for _ in range(14):  # maria
    cx, cy, cr = mx + random.randint(-70, 70), my + random.randint(-70, 70), random.randint(8, 24)
    if math.hypot(cx - mx, cy - my) + cr < mr - 6:
        d.ellipse([cx - cr, cy - cr, cx + cr, cy + cr], fill=(196, 196, 178))

def ridge(base, amp, rough, seed):
    r = np.random.default_rng(seed)
    n = np.zeros(W)
    for octave in range(6):
        f = 2 ** octave
        pts = r.normal(0, 1, f * 4 + 2)
        n += np.interp(np.linspace(0, len(pts) - 1, W), np.arange(len(pts)), pts) * (rough ** octave)
    n = (n - n.min()) / (n.max() - n.min())
    return base - n * amp

def layer(img, ys, color):
    d = ImageDraw.Draw(img)
    d.polygon([(0, H)] + [(x, float(ys[x])) for x in range(W)] + [(W, H)], fill=color)

def fog(img, y0, y1, strength):
    m = Image.new("L", (W, H), 0)
    md = ImageDraw.Draw(m)
    for y in range(y0, y1):
        t = 1 - abs((y - (y0 + y1) / 2) / ((y1 - y0) / 2))
        md.line([(0, y), (W, y)], fill=int(255 * strength * max(0, t) ** 1.5))
    m = m.filter(ImageFilter.GaussianBlur(18))
    return Image.composite(Image.new("RGB", (W, H), lerp(NEBEL, MOOS, 0.45)), img, m)

img = sky
layer(img, ridge(760, 260, 0.55, 3), lerp(MOOS, TIEF, 0.55))           # Brocken-like far ridge
img = fog(img, 640, 900, 0.55)
layer(img, ridge(900, 130, 0.5, 8), lerp(MOOS, TIEF, 0.72))

def firs(img, base_y, count, hmin, hmax, color):
    d = ImageDraw.Draw(img)
    for _ in range(count):
        x = random.randint(-40, W + 40); h = random.randint(hmin, hmax); w = h * 0.33
        y = base_y + random.randint(-30, 30)
        for i in range(5):
            top = y - h + i * h * 0.17; bot = y - h * 0.32 + i * h * 0.12
            half = w * (0.35 + i * 0.16)
            d.polygon([(x, top), (x - half, bot), (x + half, bot)], fill=color)
        d.rectangle([x - 3, y - h * 0.2, x + 3, y + 40], fill=color)

firs(img, 1000, 170, 170, 300, lerp(TANNE, TIEF, 0.82)); img = fog(img, 900, 1100, 0.45)
firs(img, 1120, 120, 260, 430, lerp(MOOS, TIEF, 0.9));   img = fog(img, 1050, 1230, 0.35)
firs(img, 1300, 80, 380, 640, TIEF)
d = ImageDraw.Draw(img); d.rectangle([0, 1300, W, H], fill=TIEF)

# bronze hairline vignette + film grain
arr = np.asarray(img).astype(np.float32)
yy, xx = np.mgrid[0:H, 0:W]
vig = 1 - 0.38 * (((xx - W / 2) / (W / 2)) ** 2 + ((yy - H / 2) / (H / 2)) ** 2) / 2
arr *= vig[..., None]
arr += rng.normal(0, 2.2, arr.shape[:2])[..., None]
Image.fromarray(np.clip(arr, 0, 255).astype(np.uint8)).save(out)
print("wrote", out)
