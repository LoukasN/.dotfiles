--[[
__        ___           _               ____        _
\ \      / (_)_ __   __| | _____      _|  _ \ _   _| | ___  ___
 \ \ /\ / /| | '_ \ / _` |/ _ \ \ /\ / / |_) | | | | |/ _ \/ __|
  \ V  V / | | | | | (_| | (_) \ V  V /|  _ <| |_| | |  __/\__ \
   \_/\_/  |_|_| |_|\__,_|\___/ \_/\_/ |_| \_\\__,_|_|\___||___/
--]]

-- P-P
hl.window_rule({ match = { title = "^Picture-in-Picture" }, float = true })
hl.window_rule({ match = { title = "^Picture-in-Picture" }, pin = true })
hl.window_rule({ match = { title = "^Picture-in-Picture" }, no_dim = true })
hl.window_rule({ match = { title = "^Picture-in-Picture" }, rounding = 0 })
hl.window_rule({ match = { title = "^Picture-in-Picture" }, border_size = 0 })
hl.window_rule({ match = { title = "^Picture-in-Picture" }, size = { 854, 480 } })
hl.window_rule({ match = { title = "^Picture-in-Picture" }, move = { 1062, 45 } })

-- Remove dimming for certain windows
hl.window_rule({ match = { class = "^(com.stremio.stremio)$" }, no_dim = true })
hl.window_rule({ match = { title = ".*- YouTube —.*" }, no_dim = true })
hl.window_rule({ match = { title = ".*www.youtube.com.*" }, no_dim = true })
hl.window_rule({ match = { title = ".*- Twitch —.*" }, no_dim = true })
hl.window_rule({ match = { title = "Netflix.*" }, no_dim = true })
hl.window_rule({ match = { title = ".*| Disney+.*" }, no_dim = true })

-- Virtual machine workspace 10
hl.window_rule({ match = { class = "virt-manager" }, workspace = 10 })
hl.window_rule({ match = { class = "virt-manager" }, fullscreen = true })

-- Audio settings floating
hl.window_rule({ match = { initial_title = "^(Volume Control)$" }, float = true })
hl.window_rule({ match = { initial_title = "^(Volume Control)$" }, pin = true })
hl.window_rule({ match = { initial_title = "^(Volume Control)$" }, size = { "monitor_w*0.45", "monitor_h*0.45" } })
hl.window_rule({ match = { initial_title = "^(Volume Control)$" }, move = { "monitor_w*0.5485", "monitor_h*0.04" } })
hl.window_rule({ match = { initial_title = "^(Volume Control)$" }, border_size = 0 })

-- Bluetooth menu floating
hl.window_rule({ match = { initial_title = "^(Bluetooth Devices)$" }, float = true })
hl.window_rule({ match = { initial_title = "^(Bluetooth Devices)$" }, pin = true })
hl.window_rule({ match = { initial_title = "^(Bluetooth Devices)$" }, size = { "monitor_w*0.45", "monitor_h*0.45" } })
hl.window_rule({ match = { initial_title = "^(Bluetooth Devices)$" }, move = { "monitor_w*0.5485", "monitor_h*0.04" } })
hl.window_rule({ match = { initial_title = "^(Bluetooth Devices)$" }, border_size = 0 })

-- Floating/Centering
hl.window_rule({ match = { title = "^(Open File)(.*)$" }, center = true })
hl.window_rule({ match = { title = "^(Open File)(.*)$" }, float = true })

hl.window_rule({ match = { title = "^(Select a File)(.*)$" }, center = true })
hl.window_rule({ match = { title = "^(Select a File)(.*)$" }, float = true })

hl.window_rule({ match = { title = "^(Choose wallpaper)(.*)$" }, center = true })
hl.window_rule({ match = { title = "^(Choose wallpaper)(.*)$" }, float = true })

hl.window_rule({ match = { title = "^(Open Folder)(.*)$" }, center = true })
hl.window_rule({ match = { title = "^(Open Folder)(.*)$" }, float = true })

hl.window_rule({ match = { title = "^(Save As)(.*)$" }, center = true })
hl.window_rule({ match = { title = "^(Save As)(.*)$" }, float = true })

hl.window_rule({ match = { title = "^(Library)(.*)$" }, center = true })
hl.window_rule({ match = { title = "^(Library)(.*)$" }, float = true })

hl.window_rule({ match = { title = "^(File Upload)(.*)$" }, center = true })
hl.window_rule({ match = { title = "^(File Upload)(.*)$" }, float = true })

hl.window_rule({ match = { title = "^(.*)(wants to save)$" }, center = true })
hl.window_rule({ match = { title = "^(.*)(wants to save)$" }, float = true })
hl.window_rule({ match = { title = "^(.*)(wants to open)$" }, center = true })
hl.window_rule({ match = { title = "^(.*)(wants to open)$" }, float = true })
