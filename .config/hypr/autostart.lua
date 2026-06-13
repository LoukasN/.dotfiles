--[[
 _                           _
| |    __ _ _   _ _ __   ___| |__
| |   / _` | | | | '_ \ / __| '_ \
| |__| (_| | |_| | | | | (__| | | |
|_____\__,_|\__,_|_| |_|\___|_| |_|
--]]

hl.on("hyprland.start", function()
    -- Autostart apps
    hl.exec_cmd("waybar")
    hl.exec_cmd("mako")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("blueman-applet")
    -- Display sharing
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("dbus-update-activation-environment --all")
    -- Start hyprpolkitagent
    hl.exec_cmd("systemctl --user start hyprpolkitagent ")
    -- Custom battery notification script
    hl.exec_cmd("~/.local/bin/battery-notification.sh")
end)

hl.config({
    reloaded = hl.exec_cmd("awww img ~/Pictures/wallpapers/thing.png"),
})

--[[
 _____ _
|_   _| |__   ___ _ __ ___   ___  ___
  | | | '_ \ / _ \ '_ ` _ \ / _ \/ __|
  | | | | | |  __/ | | | | |  __/\__ \
  |_| |_| |_|\___|_| |_| |_|\___||___/

--]]

-- Cursor
hl.env("XCURSOR_THEME", "Capitaine-Cursors")
hl.env("XCURSOR_SIZE", "24")
hl.on("hyprland.start", function() hl.exec_cmd("hyprctl setcursor Capitaine-Cursors 24") end)
-- QT
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
--[[
 __  __ ___ ____   ____
|  \/  |_ _/ ___| / ___|
| |\/| || |\___ \| |
| |  | || | ___) | |___
|_|  |_|___|____/ \____|
--]]

-- Sessions
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
