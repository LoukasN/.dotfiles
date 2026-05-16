hl.config({
	general = {
		gaps_in = 1,
		gaps_out = 3,
		border_size = 1,
		col = { active_border = 0xffc5c9c5 },
		allow_tearing = false,
		layout = Layout,
	},

	animations = {
		enabled = true,
	},
	decoration = {

		rounding = 4,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(0000001A)",
		},

		blur = {
			enabled = true,
			size = 2,
			passes = 4,
			vibrancy = 0.1696,
		},

		dim_inactive = true,
		dim_strength = 0.2,
		dim_special = 0.3,
	},
})

hl.curve("md3_decel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("hyprnostretch", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1 } } })
hl.curve("fluent_decel", { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 0.5, bezier = "hyprnostretch", style = "popin 60%" })
hl.animation({ leaf = "layers", enabled = true, speed = 0.5, bezier = "md3_decel" })
hl.animation({ leaf = "fade", enabled = true, speed = 0.5, bezier = "md3_decel" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 0.5, bezier = "fluent_decel", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 0.5, bezier = "md3_decel", style = "slidevert" })
