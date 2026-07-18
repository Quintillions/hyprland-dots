local mod = "SUPER"

hl.bind(mod .. " + Q",         hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + Q",    hl.dsp.window.kill())
hl.bind(mod .. " + Return",    hl.dsp.exec_cmd("alacritty"))
hl.bind(mod .. " + F",         hl.dsp.window.fullscreen())
hl.bind(mod .. " + E",         hl.dsp.exec_cmd("dolphin"))
hl.bind(mod .. " + T",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + M",         hl.dsp.window.move({ workspace = "special:minimized", follow = false }))

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mod .. " + Left",          hl.dsp.layout("focus l"))
hl.bind(mod .. " + Right",         hl.dsp.layout("focus r"))
hl.bind(mod .. " + Up",            hl.dsp.focus({ window = "u" }))
hl.bind(mod .. " + Down",          hl.dsp.focus({ window = "d" }))
hl.bind(mod .. " + SHIFT + Left",  hl.dsp.layout("swapcol l"))
hl.bind(mod .. " + SHIFT + Right", hl.dsp.layout("swapcol r"))
hl.bind(mod .. " + SHIFT + Up",    hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + SHIFT + Down",  hl.dsp.window.move({ direction = "d" }))
hl.bind(mod .. " + mouse_up",      hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mod .. " + mouse_down",    hl.dsp.focus({ workspace = "r+1" }))


for i = 1, 5 do
    hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i}))
    hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({workspace = i})) 
end

hl.bind(mod .. " + D",          hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/launcher.sh"))
hl.bind(mod .. " + V",          hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/clipboard.sh"))

hl.bind(mod .. " + SUPER_L",    hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/link.sh"), { release = true })

hl.bind(mod .. " + SHIFT + P",          hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/lock.sh"))

hl.bind(mod .. " + B",          hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/wallpaper.sh"))
hl.bind(mod .. " + C",          hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/wallpaper-picker.sh"))

hl.bind(mod .. " + SHIFT + C",  hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mod .. " + S",          hl.dsp.exec_cmd('grim - | satty -f - --copy-command wl-copy -o "~/Pictures/Screenshots/%Y%m%d_%H%M%S.png"'))
hl.bind(mod .. " + SHIFT + S",  hl.dsp.exec_cmd('grim -g "$(slurp)" - | satty -f - --copy-command wl-copy -o "~/Pictures/Screenshots/%Y%m%d_%H%M%S.png"'))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true })
hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd("playerctl play-pause"),                           { locked = true })
hl.bind("XF86AudioNext",        hl.dsp.exec_cmd("playerctl next"),                                 { locked = true })
hl.bind("XF86AudioPrev",        hl.dsp.exec_cmd("playerctl previous"),                             { locked = true })
-- alt-tab: cycle window focus within workspace
hl.bind("ALT + Tab",         hl.dsp.window.cycle_next())
hl.bind("ALT + SHIFT + Tab", hl.dsp.window.cycle_next({ prev = true }))

-- hjkl: focus movement (scrolling layout)
-- h/l move focus left/right between columns; j/k move focus up/down within a column
hl.bind(mod .. " + h", hl.dsp.layout("focus l"))
hl.bind(mod .. " + l", hl.dsp.layout("focus r"))
hl.bind(mod .. " + k", hl.dsp.focus({ window = "u" }))
hl.bind(mod .. " + j", hl.dsp.focus({ window = "d" }))

-- SUPER + SHIFT + hjkl: move/swap windows
-- h/l swap the current column left or right; j/k move window up/down within its column
hl.bind(mod .. " + SHIFT + h", hl.dsp.layout("swapcol l"))
hl.bind(mod .. " + SHIFT + l", hl.dsp.layout("swapcol r"))
hl.bind(mod .. " + SHIFT + k", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + SHIFT + j", hl.dsp.window.move({ direction = "d" }))

-- column management
hl.bind(mod .. " + P",                   hl.dsp.layout("promote"))              -- move window into its own column
hl.bind(mod .. " + bracketleft",         hl.dsp.layout("consume"))              -- pull window into previous column
hl.bind(mod .. " + bracketright",        hl.dsp.layout("expel"))                -- push window to its own column
hl.bind(mod .. " + SHIFT + bracketleft",  hl.dsp.layout("consume_or_expel prev")) -- smart: consume if alone, expel if not
hl.bind(mod .. " + SHIFT + bracketright", hl.dsp.layout("consume_or_expel next"))
 
-- column resizing
hl.bind(mod .. " + equal", hl.dsp.layout("colresize +conf")) -- cycle to next preset width
hl.bind(mod .. " + minus", hl.dsp.layout("colresize -conf")) -- cycle to previous preset width
 
-- fit operations
hl.bind(mod .. " + SHIFT + F", hl.dsp.layout("fit active"))   -- fit active column to screen
hl.bind(mod .. " + CTRL + F",  hl.dsp.layout("fit visible"))  -- fit all visible columns
hl.bind(mod .. " + SHIFT + E", hl.dsp.layout("fit expand"))   -- expand window into remaining free space  -- reduce window to its minimum size
-- fuuck