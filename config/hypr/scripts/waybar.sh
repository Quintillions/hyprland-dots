#!/bin/sh
# Start Waybar once. accent.css is rewritten by wallust; seed a default so first boot never lacks it.
dir="$HOME/.config/waybar"
mkdir -p "$dir"
[ -s "$dir/accent.css" ] || printf '@define-color accent #52664A;\n' > "$dir/accent.css"
pgrep -x waybar >/dev/null && exit 0
exec waybar
