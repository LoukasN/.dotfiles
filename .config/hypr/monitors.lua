require("variables")

hl.monitor({
	output = PrimaryMonitor,
	mode = "1920x1080@60",
	position = "0x0",
	scale = "1",
})

hl.monitor({
	output = SecondaryMonitor,
	mode = "1920x1080@75",
	position = "1920x0",
	scale = "1",
})

hl.monitor({
	output = "desc:Beihai Century Joint Innovation Technology Co.Ltd C24A1H",
	mode = "1920x1080@240.00Hz",
	position = "auto",
	scale = "1",
	mirror = PrimaryMonitor,
})

hl.monitor({
	output = "",
	mode = "preffered",
	position = "auto",
	scale = "1",
})

-- Moving workspaces between monitors
hl.bind("SUPER + SHIFT + LEFT", hl.dsp.workspace.move({ monitor = PrimaryMonitor }))
hl.bind("SUPER + SHIFT + RIGHT", hl.dsp.workspace.move({ monitor = SecondaryMonitor }))

-- Binding Workspaces to monitors
hl.workspace_rule({ workspace = "1", monitor = PrimaryMonitor, default = true })
hl.workspace_rule({ workspace = "2", monitor = SecondaryMonitor, default = true })
