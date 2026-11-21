#!/usr/bin/env bash
# Wallpaper picker: thumbnail grid over ~/wallpapers, applied through hypr/scripts/wallpaper.sh.
# Opens instantly: only missing thumbnails are (re)built, in parallel; a large first-time batch runs in
# the background so the picker never waits on it.
pgrep -x rofi >/dev/null && { pkill -x rofi; exit 0; }

dir="$HOME/wallpapers"
thumbs="${XDG_CACHE_HOME:-$HOME/.cache}/hexenwald/wp-thumbs"
export MAGICK_CONFIGURE_PATH="$HOME/.config/hypr/scripts/magick-policy"
mkdir -p "$thumbs"

mapfile -t files < <(find "$dir" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.png' \) -printf '%T@\t%p\n' 2>/dev/null | sort -rn | cut -f2-)
[ "${#files[@]}" -gt 0 ] || { notify-send -a Hexenwald "Nulla imago" "No wallpapers in $dir"; exit 0; }

thumb_of() { printf '%s/%s.png' "$thumbs" "${1##*/}"; }   # keyed by full file name, so a.png and a.jpg never collide

# shellcheck disable=SC2015  # mv failing falls through to rm on purpose
make_thumb() {  # make_thumb <source> <thumb>
    magick -define jpeg:size=720x405 "$1[0]" -strip -thumbnail 360x "png:$2.tmp" 2>/dev/null \
        && mv -f "$2.tmp" "$2" || rm -f "$2.tmp"
}
export -f make_thumb

missing=()
for f in "${files[@]}"; do
    t=$(thumb_of "$f")
    [[ -s $t && ! $f -nt $t ]] || missing+=("$f")
done

# shellcheck disable=SC2016  # the single-quoted body is expanded by the child bash
build() {
    printf '%s\0' "${missing[@]}" | while IFS= read -r -d '' f; do printf '%s\0%s\0' "$f" "$(thumb_of "$f")"; done |
        xargs -0 -n2 -P "$(nproc)" bash -c 'make_thumb "$0" "$1"'
}

if [ "${#missing[@]}" -gt 0 ]; then
    if [ "${#missing[@]}" -le 6 ]; then
        build
    else
        notify-send -a Hexenwald "Imagines parantur" "Building ${#missing[@]} thumbnails; reopen the picker in a moment."
        ( build ) >/dev/null 2>&1 &
    fi
fi

# Drop thumbnails whose wallpaper is gone (cheap: shell builtins only).
for t in "$thumbs"/*.png; do
    [ -e "$t" ] || continue
    n=${t##*/}; [ -e "$dir/${n%.png}" ] || rm -f "$t"
done

menu() {
    local f t
    for f in "${files[@]}"; do
        t=$(thumb_of "$f")
        if [ -s "$t" ]; then printf '%s\0icon\x1f%s\n' "${f##*/}" "$t"; else printf '%s\n' "${f##*/}"; fi
    done
}
pick=$(menu | rofi -dmenu -i -show-icons -format i -p "Imago" -theme hexenwald-grid) || exit 0
[ -n "$pick" ] && exec bash "$HOME/.config/hypr/scripts/wallpaper.sh" set "${files[$pick]}"
