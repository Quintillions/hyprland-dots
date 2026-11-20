#!/bin/sh
# Application launcher (Rofi drun). Same call again closes it.
pgrep -x rofi >/dev/null && exec pkill -x rofi
exec rofi -show drun
