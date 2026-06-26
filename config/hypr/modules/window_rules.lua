hl.window_rule({
    name           = "suppress-maximize",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({
    name  = "float-system-dialogs",
    match = { class = "(pavucontrol|nm-connection-editor|blueman-manager|org.kde.polkit-kde-authentication-agent-1|xdg-desktop-portal-gtk)" },
    float = true,
})

hl.window_rule({
    name  = "float-file-pickers",
    match = { title = "(Open File|Save File|Save As|Choose Files|Open Folder)" },
    float = true,
})

hl.window_rule({
    name  = "float-ghosttype",
    match = { class = "[Aa]lacritty"},
})

hl.window_rule({
    name  = "float-spotify",
    match = { class = "[Ss]potify" },
    float = true,
    workspace = "5 silent",
})

hl.window_rule({
    name   = "float-dolphin",
    match  = { class = "org.kde.dolphin" },
    float  = true,
    size   = { 1500, 850 },
    center = true,
})
hl.window_rule({
    name = "Steam Friends",
    match = {
        title = "Friends List",
    },

    float = true,
    opacity = "1 1",
    size = "800 800",
    move = "200 200",
})

hl.window_rule({
    name = "Steam Settings",
    match = {
        title = "Steam Settings",
    },

    float = true,
    opacity = "1 1",
})

hl.window_rule({
    name = "Steam Property Float",
    float = true,
    match = {
        class = "^(steam)$",
        title = "negative:^(Steam)$",
    },
})
