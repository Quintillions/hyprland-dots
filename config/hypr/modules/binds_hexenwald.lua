-- Hexenwald additions. Existing binds (SUPER+D launcher, +V clipboard, +C wallpaper picker,
-- +SHIFT+P lock, SUPER release) keep their keys; the scripts behind them now use Rofi/Hyprlock/Mako.
local mod = "SUPER"
local scripts = os.getenv("HOME") .. "/.config/hypr/scripts/"

hl.bind(mod .. " + A", hl.dsp.exec_cmd(scripts .. "tabula.sh"))   -- Tabula Obscura
hl.bind(mod .. " + N", hl.dsp.exec_cmd(scripts .. "memento.sh"))  -- Memento Mori
hl.bind(mod .. " + X", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/rofi/scripts/power.sh"))
