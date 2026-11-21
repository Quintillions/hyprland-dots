#!/usr/bin/env python3
"""Generate the Hexenwald SVG assets (original line art, no third-party artwork).
Usage: python3 tools/gen_assets.py <output-dir>"""
import math, sys, pathlib

OUT = pathlib.Path(sys.argv[1] if len(sys.argv) > 1 else "config/eww/assets")
OUT.mkdir(parents=True, exist_ok=True)

EFEU, BRONZE, PERG, KOHLE, MOND = "#52664A", "#927B4F", "#C4B99B", "#202521", "#D5D4C3"


def write(name, body):
    (OUT / name).write_text(body.strip() + "\n", encoding="utf-8")


LEAF = (f'<path d="M0 0 C4 -6 12 -6 17 0 C12 6 4 6 0 0Z" fill="{EFEU}" '
        f'stroke="{BRONZE}" stroke-width="0.8"/>')


def leaf(x, y, rot):
    return f'<g transform="translate({x} {y}) rotate({rot})">{LEAF}</g>'


def corner_body():
    return "\n".join([
        f'<path d="M8 96 V30 Q8 8 30 8 H96" fill="none" stroke="{BRONZE}" stroke-width="1.6" stroke-linecap="round"/>',
        f'<path d="M15 96 V32 Q15 15 32 15 H96" fill="none" stroke="{BRONZE}" stroke-width="0.7" opacity="0.6"/>',
        f'<path d="M8 48 q10 -4 20 -2" fill="none" stroke="{BRONZE}" stroke-width="1"/>',
        f'<path d="M48 8 q-4 10 -2 20" fill="none" stroke="{BRONZE}" stroke-width="1"/>',
        f'<path d="M8 70 q8 -2 15 2" fill="none" stroke="{BRONZE}" stroke-width="1"/>',
        f'<path d="M70 8 q-2 8 2 15" fill="none" stroke="{BRONZE}" stroke-width="1"/>',
        leaf(28, 46, -15), leaf(23, 72, 20), leaf(46, 28, 75), leaf(72, 23, 70),
        leaf(14, 22, 45), leaf(22, 14, 45),
        f'<path d="M8 8 l6 6 l-6 6 l-6 -6Z" fill="{MOND}" opacity="0.85"/>',
    ])


for name, tf in (("tl", ""),
                 ("tr", ' transform="translate(100 0) scale(-1 1)"'),
                 ("bl", ' transform="translate(0 100) scale(1 -1)"'),
                 ("br", ' transform="translate(100 100) scale(-1 -1)"')):
    write(f"corner-{name}.svg",
          f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100" height="100"><g{tf}>{corner_body()}</g></svg>')

write("divider.svg", f'''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 16" width="240" height="16">
  <path d="M6 8 H104" stroke="{BRONZE}" stroke-width="1"/>
  <path d="M136 8 H234" stroke="{BRONZE}" stroke-width="1"/>
  <path d="M104 8 l-6 -3 M104 8 l-6 3 M136 8 l6 -3 M136 8 l6 3" stroke="{BRONZE}" stroke-width="1" fill="none"/>
  <path d="M121 2 A6.5 6.5 0 1 0 121 14 A5 5 0 1 1 121 2Z" fill="{MOND}"/>
</svg>''')


def phase_paths(idx, cx, cy, r):
    """(dark disc, lit shape) for phase idx 0..7 (0 new, 4 full, waxing 1-3, waning 5-7)."""
    dark = f'<circle cx="{cx}" cy="{cy}" r="{r}" fill="{KOHLE}" stroke="{BRONZE}" stroke-width="1.2"/>'
    if idx == 0:
        return dark, ""
    if idx == 4:
        return dark, f'<circle cx="{cx}" cy="{cy}" r="{r}" fill="{MOND}"/>'
    p = idx / 8.0
    mirror = p > 0.5
    if mirror:
        p = 1 - p
    k = math.cos(2 * math.pi * p)
    rx = abs(k) * r
    sweep = 0 if k > 0 else 1
    d = (f"M{cx} {cy - r} A{r} {r} 0 0 1 {cx} {cy + r} "
         f"A{rx:.2f} {r} 0 0 {sweep} {cx} {cy - r}Z")
    tf = f' transform="translate({2 * cx} 0) scale(-1 1)"' if mirror else ""
    return dark, f'<path d="{d}" fill="{MOND}"{tf}/>'


for i in range(8):
    dark, lit = phase_paths(i, 50, 50, 40)
    write(f"moon-{i}.svg",
          f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100" height="100">{dark}{lit}</svg>')


def ring(cx=100, cy=100):
    out = [f'<circle cx="{cx}" cy="{cy}" r="94" fill="none" stroke="{BRONZE}" stroke-width="1.6"/>',
           f'<circle cx="{cx}" cy="{cy}" r="88" fill="none" stroke="{BRONZE}" stroke-width="0.7" opacity="0.7"/>',
           f'<circle cx="{cx}" cy="{cy}" r="62" fill="none" stroke="{BRONZE}" stroke-width="0.8" opacity="0.8"/>']
    for n in range(24):
        a = math.radians(n * 15)
        r1, r2 = (88, 80) if n % 3 == 0 else (88, 84)
        out.append(f'<line x1="{cx + r1 * math.sin(a):.2f}" y1="{cy - r1 * math.cos(a):.2f}" '
                   f'x2="{cx + r2 * math.sin(a):.2f}" y2="{cy - r2 * math.cos(a):.2f}" stroke="{BRONZE}" stroke-width="1"/>')
    for n in range(8):
        out.append(f'<g transform="translate({cx} {cy}) rotate({n * 45}) translate(0 -71) rotate(90) scale(0.55)">{LEAF}</g>')
    return "\n".join(out)


def sol_centre(cx=100, cy=100):
    out = []
    for n in range(16):
        a = math.radians(n * 22.5)
        long = n % 2 == 0
        r0, r1, w = 22, (56 if long else 46), (5 if long else 3.2)
        px, py = math.cos(a), math.sin(a)
        tx, ty = cx + r1 * math.sin(a), cy - r1 * math.cos(a)
        bx, by = cx + r0 * math.sin(a), cy - r0 * math.cos(a)
        out.append(f'<path d="M{bx - w * px:.2f} {by - w * py:.2f} L{tx:.2f} {ty:.2f} L{bx + w * px:.2f} {by + w * py:.2f}Z" '
                   f'fill="{PERG}" stroke="{BRONZE}" stroke-width="0.6"/>')
    out.append(f'<circle cx="{cx}" cy="{cy}" r="21" fill="{PERG}" stroke="{BRONZE}" stroke-width="1.2"/>')
    out.append(f'<circle cx="{cx}" cy="{cy}" r="14" fill="none" stroke="{BRONZE}" stroke-width="0.8"/>')
    return "\n".join(out)


write("emblem-sol.svg",
      f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200" width="200" height="200">{ring()}{sol_centre()}</svg>')
for i in range(8):
    dark, lit = phase_paths(i, 100, 100, 46)
    write(f"emblem-luna-{i}.svg",
          f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200" width="200" height="200">{ring()}{dark}{lit}</svg>')

HG = "".join(leaf(x, y, r) for x, y, r in ((38, 140, -60), (33, 118, -80), (48, 160, -30), (63, 176, -10)))
write("hourglass.svg", f'''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 220 200" width="220" height="200">
  <g stroke="{BRONZE}" stroke-width="1.6" stroke-linejoin="round" stroke-linecap="round">
    <rect x="78" y="14" width="64" height="8" rx="2" fill="{KOHLE}"/>
    <rect x="78" y="178" width="64" height="8" rx="2" fill="{KOHLE}"/>
    <path d="M86 22 C86 62 108 84 110 100 C108 116 86 138 86 178 M134 22 C134 62 112 84 110 100 C112 116 134 138 134 178" fill="none"/>
  </g>
  <path d="M92 28 C94 52 106 66 110 82 C114 66 126 52 128 28Z" fill="{PERG}" opacity="0.35"/>
  <path d="M110 96 V150" stroke="{PERG}" stroke-width="1.2" opacity="0.7"/>
  <path d="M96 176 C100 156 106 150 110 146 C114 150 120 156 124 176Z" fill="{PERG}" opacity="0.8"/>
  <g stroke="{BRONZE}" stroke-width="1.2" fill="none" stroke-linecap="round">
    <path d="M70 186 C40 172 30 140 34 104"/><path d="M150 186 C180 172 190 140 186 104"/>
  </g>
  {HG}
  <g transform="translate(220 0) scale(-1 1)">{HG}</g>
</svg>''')

# ---------- compact corner marks for the Waybar islands (second optional argument = output dir) ----------
if len(sys.argv) > 2:
    BAR = pathlib.Path(sys.argv[2]); BAR.mkdir(parents=True, exist_ok=True)
    mark = (f'<path d="M1 15 V1 H15" fill="none" stroke="{BRONZE}" stroke-width="1.4" stroke-linecap="square"/>'
            f'<path d="M5 2.6 l2.4 2.4 l-2.4 2.4 l-2.4 -2.4Z" fill="{MOND}"/>')
    for name, tf in (("tl", ""), ("tr", ' transform="translate(16 0) scale(-1 1)"'),
                     ("bl", ' transform="translate(0 16) scale(1 -1)"'), ("br", ' transform="translate(16 16) scale(-1 -1)"')):
        (BAR / f"bar-corner-{name}.svg").write_text(
            f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" width="16" height="16"><g{tf}>{mark}</g></svg>\n')
    print("bar corners written to", BAR)
print("assets written to", OUT)
