#!/usr/bin/env bash
# Power menu. Destructive actions ask again; the safe answer is listed first.
pgrep -x rofi >/dev/null && { pkill -x rofi; exit 0; }

confirm() { [ "$(printf 'Non (cancel)\nIta (confirm)\n' | rofi -dmenu -i -p "Certus?" -theme hexenwald)" = "Ita (confirm)" ]; }

choice=$(printf '%s\n' Lock Logout Sleep Restart Shutdown | rofi -dmenu -i -p "Finis" -theme hexenwald) || exit 0
case "$choice" in
    Lock)     exec "$HOME/.config/hypr/scripts/lock.sh" ;;
    Sleep)    exec systemctl suspend ;;
    Logout)   confirm && exec hyprctl dispatch 'hl.dsp.exit()' ;;
    Restart)  confirm && exec systemctl reboot ;;
    Shutdown) confirm && exec systemctl poweroff ;;
esac
