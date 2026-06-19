hl.monitor({
    output   = "eDP-1",
    mode     = "2560x1440@180",
    position = "0x0",
    scale    = 1,
})


for i = 1, 5 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "eDP-1" })
end

