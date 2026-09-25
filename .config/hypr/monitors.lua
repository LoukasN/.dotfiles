hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@60",
	position = "0x0",
	scale = "1",
})

local mirrored = false
hl.bind("SUPER + F7", function()
	mirrored = not mirrored
	if mirrored then
		hl.monitor({
			output = "",
			mode = "highres@highrr",
			position = "auto",
			scale = "1",
			mirror = "eDP-1",
		})
	else
		hl.monitor({
			output = "",
			mode = "highres@highrr",
			position = "auto",
			scale = "1",
			mirror = "none",
		})
	end
end)

-- Moving workspaces between monitors
hl.bind("SUPER + SHIFT + LEFT", hl.dsp.workspace.move({ monitor = "-1" }))
hl.bind("SUPER + SHIFT + RIGHT", hl.dsp.workspace.move({ monitor = "+1" }))
