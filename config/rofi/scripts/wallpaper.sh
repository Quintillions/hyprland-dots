#!/usr/bin/env bash
# Wallpaper picker: thumbnail grid over ~/wallpapers, applied through hypr/scripts/wallpaper.sh.
pgrep -x rofi >/dev/null && { pkill -x rofi; exit 0; }
dir="$HOME/wallpapers"
thumbs=${XDG_CACHE_HOME:-$HOME/.cache}/wp-thumbs
sh "$HOME/.config/hypr/scripts/wallpaper-thumbs.sh" >/dev/null 2>&1

mapfile -t files < <(find "$dir" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.png' \) -printf '%T@\t%p\n' 2>/dev/null | sort -rn | cut -f2-)
[ "${#files[@]}" -gt 0 ] || { notify-send -a Hexenwald "Nulla imago" "No wallpapers in $dir"; exit 0; }

menu() {
    local f base
    for f in "${files[@]}"; do
        base=$(basename "${f%.*}")
        printf '%s\0icon\x1f%s\n' "$base" "$thumbs/$base.png"
    done
}
pick=$(menu | rofi -dmenu -i -show-icons -format i -p "Imago" -theme hexenwald-grid) || exit 0
[ -n "$pick" ] && exec bash "$HOME/.config/hypr/scripts/wallpaper.sh" set "${files[$pick]}"
