hl.on("hyprland.start", function()
    local scripts = os.getenv("HOME") .. "/.config/hypr/scripts/"
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd(scripts .. "cliphist-watch.sh")
    hl.exec_cmd(scripts .. "wallpaper.sh init")
    hl.exec_cmd("mako")
    hl.exec_cmd(scripts .. "waybar.sh")
    hl.exec_cmd("obs --startreplaybuffer --disable-shutdown-check")
    -- otd-daemon runs as the opentabletdriver user service (hardware.opentabletdriver.daemon.enable)
    -- hypridle runs as the NixOS user service (services.hypridle.enable); only jdsp4linux stays here.
    hl.exec_cmd("me.timschneeberger.jdsp4linux -t")
end)
