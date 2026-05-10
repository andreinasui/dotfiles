------------------------------
--- WINDOWS AND WORKSPACES ---
------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/ for workspace rules

hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-2", default = true })
hl.workspace_rule({ workspace = "3", monitor = "DP-2" })
hl.workspace_rule({ workspace = "8", monitor = "DP-2" })
hl.workspace_rule({ workspace = "9", monitor = "DP-2" })
hl.workspace_rule({ workspace = "10", monitor = "DP-2" })

hl.window_rule({
	match = {
		class = "^(.*teams_for_linux.*)$",
	},
	workspace = 3,
})
hl.window_rule({
	match = {
		class = "^(spotify)$",
	},
	workspace = 8,
})
hl.window_rule({
	match = {
		title = "^(.*Discord.*)$",
	},
	workspace = 9,
})
hl.window_rule({
	match = {
		class = "^(steam)$",
	},
	workspace = 10,
})

-- inhibit idle on steam apps
hl.window_rule({
	name = "inhibit-idle-steam-apps",
	match = {
		class = "^(steam_app.*)$",
	},
	idle_inhibit = "fullscreen",
})

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
	name = "ignore-maximize-requests",
	match = {
		class = ".*",
	},
	suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
	name = "xwayland-dragging-fix",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})
