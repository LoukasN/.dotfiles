--[[
 ____
/ ___|  ___  _   _ _ __ ___ ___  ___
\___ \ / _ \| | | | '__/ __/ _ \/ __|
 ___) | (_) | |_| | | | (_|  __/\__ \
|____/ \___/ \__,_|_|  \___\___||___/
--]]

require("autostart")
require("binds")
require("monitors")
require("permissions")
require("variables")
require("visuals")

--[[
 ___                   _   
|_ _|_ __  _ __  _   _| |_ 
 | || '_ \| '_ \| | | | __|
 | || | | | |_) | |_| | |_ 
|___|_| |_| .__/ \__,_|\__|
          |_|              
--]]

hl.config({
	input = {
		kb_layout = "us, gr",
		kb_options = "grp:alt_shift_toggle, caps:escape",
		follow_mouse = 1,
		repeat_rate = 25,
		repeat_delay = 250,
		touchpad = {
			natural_scroll = true,
			tap_to_click = true,
		},
		sensitivity = 0,
		numlock_by_default = true,
		scroll_method = "2fg",
	},
	cursor = {
		inactive_timeout = 30,
		no_hardware_cursors = 1,
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
	inactive_timeout = 30,
})

--[[
 _                            _       
| |    __ _ _   _  ___  _   _| |_ ___ 
| |   / _` | | | |/ _ \| | | | __/ __|
| |__| (_| | |_| | (_) | |_| | |_\__ \
|_____\__,_|\__, |\___/ \__,_|\__|___/
            |___/                     
--]]

hl.config({
	dwindle = {
		preserve_split = true,
		force_split = 2,
		smart_split = false,
		smart_resizing = false,
		special_scale_factor = 0.98,
	},
})

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
hl.window_rule({ match = { initial_title = "^(Volume Control)$" }, size = { 895, 520 } })
hl.window_rule({ match = { initial_title = "^(Volume Control)$" }, move = { 1021, 44 } })
hl.window_rule({ match = { initial_title = "^(Volume Control)$" }, border_size = 0 })

-- Bluetooth menu floating
hl.window_rule({ match = { initial_title = "^(Bluetooth Devices)$" }, float = true })
hl.window_rule({ match = { initial_title = "^(Bluetooth Devices)$" }, pin = true })
hl.window_rule({ match = { initial_title = "^(Bluetooth Devices)$" }, size = { 895, 520 } })
hl.window_rule({ match = { initial_title = "^(Bluetooth Devices)$" }, move = { 1021, 44 } })
hl.window_rule({ match = { initial_title = "^(Bluetooth Devices)$" }, border_size = 0 })

--[[
 __  __ ___ ____   ____ 
|  \/  |_ _/ ___| / ___|
| |\/| || |\___ \| |    
| |  | || | ___) | |___ 
|_|  |_|___|____/ \____|
--]]

hl.config({
	misc = {
		disable_hyprland_logo = true,
		font_family = "JetbrainsMonoNF",
		key_press_enables_dpms = true,
		vrr = 1,
	},
	ecosystem = {
		no_update_news = false,
		no_donation_nag = false,
		enforce_permissions = true,
	},
})
