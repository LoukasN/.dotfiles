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
require("rules")
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
	scrolling = {
		wrap_focus = false,
		wrap_swapcol = false,
	},
})

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
