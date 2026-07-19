require("variables")

--[[
 ____            _      
| __ )  __ _ ___(_) ___ 
|  _ \ / _` / __| |/ __|
| |_) | (_| \__ \ | (__ 
|____/ \__,_|___/_|\___|
--]]

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + SHIFT + RETURN", hl.dsp.exec_cmd("kitty tmux new-session -A -s loukas"))
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.close())
hl.bind("SUPER + D", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind("SUPER + P", hl.dsp.window.pseudo())
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
-- hl.bind("SUPER + SHIFT + F", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))
hl.bind("SUPER + SHIFT + F", hl.dsp.exec_cmd("quickshell ipc call bar toggle"))
-- hl.bind("SUPER + SHIFT + Z", hl.dsp.exec_cmd("pkill waybar || waybar"))
hl.bind("SUPER + N", hl.dsp.exec_cmd("quickshell ipc call notifications toggle"))

if Layout == "scrolling" then
	hl.bind("SUPER + SPACE", hl.dsp.layout("consume_or_expel next"))
	hl.bind("SUPER + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))
elseif Layout == "dwindle" then
	hl.bind("SUPER + SPACE", hl.dsp.window.float({ action = "toggle" }))
end

--[[
 ____            _       _       
/ ___|  ___ _ __(_)_ __ | |_ ___ 
\___ \ / __| '__| | '_ \| __/ __|
 ___) | (__| |  | | |_) | |_\__ \
|____/ \___|_|  |_| .__/ \__|___/
                  |_|           
--]]

-- hl.bind("SUPER + I", hl.dsp.exec_cmd("bash ~/.config/rofi/scripts/global/rofi-wifi-menu.sh"))
hl.bind("SUPER + I", hl.dsp.exec_cmd("quickshell ipc call networkMenu toggle"))
-- hl.bind("SUPER + B", hl.dsp.exec_cmd("bash ~/.config/rofi/scripts/global/rofi-bluetooth-menu.sh"))
hl.bind("SUPER + B", hl.dsp.exec_cmd("quickshell ipc call bluetoothMenu toggle"))
-- hl.bind("SUPER + SHIFT + DELETE", hl.dsp.exec_cmd("bash ~/.config/rofi/scripts/hypr/powermenu.sh"))
hl.bind("SUPER + SHIFT + DELETE", hl.dsp.exec_cmd("quickshell ipc call shutdownMenu toggle"))
-- hl.bind("SUPER + W", hl.dsp.exec_cmd("bash ~/.config/rofi/scripts/hypr/rofi-wallpaper-changer-hyprland.sh"))
hl.bind("SUPER + W", hl.dsp.exec_cmd("quickshell ipc call wallpaperMenu toggle"))
hl.bind("SUPER + SHIFT + W", hl.dsp.exec_cmd("bash ~/WindowsVM/cli-vm.sh"))
hl.bind("SUPER + V", hl.dsp.exec_cmd("bash ~/.config/rofi/scripts/global/rofi-history-menu.sh"))

--[[
__        ___           _                   
\ \      / (_)_ __   __| | _____      _____ 
 \ \ /\ / /| | '_ \ / _` |/ _ \ \ /\ / / __|
  \ V  V / | | | | | (_| | (_) \ V  V /\__ \
   \_/\_/  |_|_| |_|\__,_|\___/ \_/\_/ |___/
--]]

-- Move focus with SUPER + vim motions
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))

-- Move window with SUPER + SHIFT + vim motions
if Layout == "dwindle" then
	hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
	hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
elseif Layout == "scrolling" then
	hl.bind("SUPER + SHIFT + H", hl.dsp.layout("swapcol l"))
	hl.bind("SUPER + SHIFT + L", hl.dsp.layout("swapcol r"))
end
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Resizing
if Layout == "dwindle" then
	hl.bind("SUPER + RIGHT", hl.dsp.window.resize({ x = 40, y = 0, relative = true, repeating = true }))
	hl.bind("SUPER + LEFT", hl.dsp.window.resize({ x = -40, y = 0, relative = true, repeating = true }))
	hl.bind("SUPER + UP", hl.dsp.window.resize({ x = 0, y = 40, relative = true, repeating = true }))
	hl.bind("SUPER + DOWN", hl.dsp.window.resize({ x = 0, y = -40, relative = true, repeating = true }))
elseif Layout == "scrolling" then
	hl.bind("SUPER + RIGHT", hl.dsp.layout("colresize +conf"))
	hl.bind("SUPER + LEFT", hl.dsp.layout("colresize -conf"))
	hl.bind("SUPER + UP", hl.dsp.window.resize({ x = 0, y = 40, relative = true, repeating = true }))
	hl.bind("SUPER + DOWN", hl.dsp.window.resize({ x = 0, y = -40, relative = true, repeating = true }))
end

-- Mouse Resizing
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

--[[
__        __         _                                  
\ \      / /__  _ __| | _____ _ __   __ _  ___ ___  ___ 
 \ \ /\ / / _ \| '__| |/ / __| '_ \ / _` |/ __/ _ \/ __|
  \ V  V / (_) | |  |   <\__ \ |_) | (_| | (_|  __/\__ \
   \_/\_/ \___/|_|  |_|\_\___/ .__/ \__,_|\___\___||___/
                             |_|                        
--]]

for i = 1, 10 do
	local key = i % 10
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scratchpad implementation
hl.bind("SUPER + MINUS", hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind("SUPER + SHIFT + MINUS", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))
hl.workspace_rule({ workspace = "special:scratchpad", persistent = true })

-- Music special workspace
hl.bind("SUPER + M", hl.dsp.workspace.toggle_special("media"))
hl.bind("SUPER + SHIFT + M", hl.dsp.window.move({ workspace = "special:media", follow = false }))
hl.workspace_rule({ workspace = "special:media", persistent = true })

--[[
#  _____      _                 
# | ____|_  _| |_ _ __ __ _ ___ 
# |  _| \ \/ / __| '__/ _` / __|
# | |___ >  <| |_| | | (_| \__ \
# |_____/_/\_\\__|_|  \__,_|___/
--]]

-- Media keys
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)

hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)

hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)

hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -n2 set 1%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -n2 set 1%-"), { locked = true, repeating = true })

-- Screenshot using grim and slurp
hl.bind("PRINT", hl.dsp.exec_cmd("bash ~/.local/bin/screenshot"), { locked = true, repeating = true })
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("bash ~/.local/bin/screenshot select"), { locked = true, repeating = true })

-- Lock on lid close
hl.bind("switch:on:Lid", hl.dsp.exec_cmd("systemctl suspend"))
