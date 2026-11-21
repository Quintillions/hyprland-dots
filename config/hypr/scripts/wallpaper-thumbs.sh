#!/bin/sh
# Fixed: the old cleanup looked for "$wpdir/<thumb name without .png>" (no extension), never found it,
# and therefore deleted EVERY thumbnail on EVERY run, regenerating all of them each time.
# Thumbnails are now keyed by the full wallpaper file name and only missing/outdated ones are rebuilt.
MAGICK_CONFIGURE_PATH="$(dirname "$0")/magick-policy"
export MAGICK_CONFIGURE_PATH

wpdir="$HOME/wallpapers"
cache="${XDG_CACHE_HOME:-$HOME/.cache}/hexenwald/wp-thumbs"
mkdir -p "$cache"

for f in "$cache"/*.png; do
    [ -e "$f" ] || continue
    n=${f##*/}
    [ -e "$wpdir/${n%.png}" ] || rm -f "$f"
done

find "$wpdir" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.png' \) | while IFS= read -r src; do
    thumb="$cache/${src##*/}.png"
    if [ ! -s "$thumb" ] || [ "$src" -nt "$thumb" ]; then
        if magick -define jpeg:size=720x405 "${src}[0]" -strip -thumbnail 360x "png:$thumb.tmp"; then
            mv -f "$thumb.tmp" "$thumb"
        else
            rm -f "$thumb.tmp"
        fi
    fi
done
