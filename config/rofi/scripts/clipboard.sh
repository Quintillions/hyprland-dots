#!/usr/bin/env bash
# Clipboard history (cliphist) with image thumbnails. Enter = copy, Ctrl+X = delete the entry.
pgrep -x rofi >/dev/null && { pkill -x rofi; exit 0; }
thumbs=${XDG_CACHE_HOME:-$HOME/.cache}/cliphist-thumbs
sh "$HOME/.config/hypr/scripts/cliphist-thumbs.sh" >/dev/null 2>&1

mapfile -t lines < <(cliphist list)
[ "${#lines[@]}" -gt 0 ] || exit 0

menu() {
    local l id text
    for l in "${lines[@]}"; do
        id=${l%%$'\t'*}; text=${l#*$'\t'}
        if [[ $text == "[[ binary data"* && $id =~ ^[0-9]+$ && -s "$thumbs/$id.png" ]]; then
            printf '%s\0icon\x1f%s\n' "$text" "$thumbs/$id.png"
        else
            printf '%s\n' "$text"
        fi
    done
}

pick=$(menu | rofi -dmenu -i -show-icons -format i -p "Memoria" -kb-custom-1 "Control+x" -theme hexenwald)
rc=$?
[ -n "$pick" ] || exit 0
id=${lines[$pick]%%$'\t'*}
[[ $id =~ ^[0-9]+$ ]] || exit 0
case $rc in
    0)  printf '%s' "$id" | cliphist decode | wl-copy ;;
    10) printf '%s' "$id" | cliphist delete ;;
esac
