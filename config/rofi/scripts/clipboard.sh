#!/usr/bin/env bash
# Clipboard history (cliphist) with image thumbnails.
#   Enter = copy   Ctrl+X = delete the entry (menu stays open)   Alt+X = clear ALL history
pgrep -x rofi >/dev/null && { pkill -x rofi; exit 0; }

cache=${XDG_CACHE_HOME:-$HOME/.cache}
thumbs=$cache/cliphist-thumbs
log=$cache/hexenwald/clipboard.log
mkdir -p "$(dirname "$log")"
say() { command -v notify-send >/dev/null 2>&1 && notify-send -a Hexenwald "$@"; }

sh "$HOME/.config/hypr/scripts/cliphist-thumbs.sh" >/dev/null 2>&1

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

sel=0
while :; do
    mapfile -t lines < <(cliphist list)
    [ "${#lines[@]}" -gt 0 ] || { say "Memoria" "Clipboard history is empty"; exit 0; }
    (( sel >= ${#lines[@]} )) && sel=$(( ${#lines[@]} - 1 ))

    pick=$(menu | rofi -dmenu -i -show-icons -format i -p "Memoria" -selected-row "$sel" \
        -kb-custom-1 "Control+x" -kb-custom-2 "Alt+x" \
        -mesg "Enter copy  ·  Ctrl+X delete  ·  Alt+X clear all" -theme hexenwald)
    rc=$?

    case $rc in
        0)
            [ -n "$pick" ] || exit 0
            id=${lines[$pick]%%$'\t'*}; [[ $id =~ ^[0-9]+$ ]] || exit 0
            printf '%s' "$id" | cliphist decode | wl-copy
            exit 0 ;;
        10)  # delete the highlighted entry, then show the list again so the change is visible
            [ -n "$pick" ] || continue
            id=${lines[$pick]%%$'\t'*}; [[ $id =~ ^[0-9]+$ ]] || continue
            if err=$(printf '%s\n' "${lines[$pick]}" | cliphist delete 2>&1); then
                rm -f "$thumbs/$id.png"; sel=$pick
            else
                printf '%s delete %s failed: %s\n' "$(date -Is)" "$id" "$err" >>"$log"
                say "Memoria" "Could not delete entry $id: $err"; exit 1
            fi ;;
        11)  # clear everything, after confirmation
            ans=$(printf 'Non (cancel)\nIta (clear all history)\n' | rofi -dmenu -i -p "Certus?" -theme hexenwald) || exit 0
            if [ "$ans" = "Ita (clear all history)" ]; then
                if err=$(cliphist wipe 2>&1); then
                    rm -f "$thumbs"/*.png; say "Memoria" "Clipboard history cleared"
                else
                    printf '%s wipe failed: %s\n' "$(date -Is)" "$err" >>"$log"; say "Memoria" "Wipe failed: $err"
                fi
            fi
            exit 0 ;;
        *) exit 0 ;;
    esac
done
