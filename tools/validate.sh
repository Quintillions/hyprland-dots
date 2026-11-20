#!/usr/bin/env bash
# Re-run the offline checks used while building Hexenwald. Run from the repo root.
# Needs: shellcheck jq python3 (+ nix-instantiate, luac5.4, rsvg-convert if available).
set -u; fail=0
ok()   { printf '  ok    %s\n' "$1"; }
bad()  { printf '  FAIL  %s\n' "$1"; fail=1; }
run()  { local name=$1; shift; if "$@" >/dev/null 2>&1; then ok "$name"; else bad "$name"; fi; }

echo "shell scripts";  for f in config/hexenwald/bin/* config/rofi/scripts/*.sh config/hypr/scripts/*.sh; do run "$f" shellcheck -s bash -e SC2034 "$f"; done
echo "waybar json";    run config/waybar/config.jsonc python3 -c "import re,json;json.loads(re.sub(r'^\s*//.*\$','',open('config/waybar/config.jsonc').read(),flags=re.M))"
echo "lua";            for f in config/hypr/hyprland.lua config/hypr/modules/*.lua; do run "$f" luac5.4 -p "$f"; done
echo "toml";           run alacritty-colors python3 -c "import tomllib;tomllib.load(open('config/hexenwald/alacritty-colors.toml','rb'))"
echo "svg";            for f in config/eww/assets/*.svg; do run "$f" rsvg-convert "$f" -o /tmp/_v.png; done
echo "nix (syntax)";   for f in flake.nix configuration.nix home.nix modules/*.nix; do run "$f" nix-instantiate --parse "$f"; done
echo "script behaviour"
export HEXEN_STATE_DIR; HEXEN_STATE_DIR=$(mktemp -d)
config/hexenwald/bin/tasks add "test" && [ "$(config/hexenwald/bin/tasks list | jq length)" = 1 ] && ok tasks || bad tasks
config/hexenwald/bin/memento toggle && [ "$(config/hexenwald/bin/memento status | jq -r .state)" = running ] && ok memento || bad memento
[ "$(HEXEN_NOW=951000000 config/hexenwald/bin/moon | jq -r .name)" = "LUNA PLENA" ] && ok moon || bad moon
exit $fail
