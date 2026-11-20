-- WALPURGISNACHT: HEXENWALD window styling. Borders use the fixed palette (Bronze / Moos);
-- wallust only supplies accents elsewhere (Waybar underline, terminal cursor).
local active   = "rgb(927B4F)"
local inactive = "rgb(26372B)"

hl.config({
    general = {
        gaps_in     = 6,
        gaps_out    = 12,
        border_size = 2,
        layout      = "scrolling",
        resize_on_border = false,
        ["col.active_border"]   = active,
        ["col.inactive_border"] = inactive,
    },
    scrolling = {
        column_width          = 0.5,
        fullscreen_on_one_column = true,
        follow_focus          = true,
        wrap_focus            = true,
        wrap_swapcol          = true,
        focus_fit_method      = 0,
    },
    decoration = {
        rounding         = 4,
        rounding_power   = 4,
        active_opacity   = 1,
        inactive_opacity = 0.95,
        shadow = {
            enabled      = true,
            range        = 12,
            render_power = 3,
            color        = 0xaa0b0f0c,
        },
        blur = {
            enabled           = true,
            size              = 8,
            passes            = 3,
            vibrancy          = 0.17,
            noise             = 0.01,
            new_optimizations = true,
        },
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = false,
        disable_splash_rendering = true,
    },
})
