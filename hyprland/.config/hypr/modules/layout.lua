-----------------------
-------- LAYOUT -------
-----------------------

-- Tiling layouts and the behaviour around them.
-- See https://wiki.hypr.land/Configuring/Layouts/

local M = {}

-- Default width of a new column, as a fraction of the monitor width.
M.column_width = 0.5

hl.config({
	general = {
		layout = "scrolling",
	},

	scrolling = {
		column_width = M.column_width,
		direction = "right",
		fullscreen_on_one_column = true,
		focus_fit_method = 1,
		explicit_column_widths = "0.5, 0.75, 1.0",
		follow_focus = true,
	},

	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},
})

-- Overview.
--
-- hyprland-scroll-overview (installed with hyprpm) zooms out to show every
-- column of every workspace, like niri's overview. Its options and functions
-- only exist once the plugin is loaded: hyprland.start loads it with
-- `hyprpm reload`, which happens after this file first runs.

local function overview_plugin()
	return hl.plugin.scrolloverview
end

if overview_plugin() then
	hl.config({
		plugin = {
			scrolloverview = {
				-- Workspaces stacked top to bottom, each one's columns left to right.
				layout = "vertical",
				scale = 0.5,
				workspace_gap = 100,
			},
		},
	})

	-- Keys while the overview is open. The plugin enters this submap on open
	-- and leaves it on close. Defining it replaces all built-in overview keys,
	-- so every key the overview needs is listed here, and binds outside it
	-- don't fire while the overview is open.
	local overview = overview_plugin()
	hl.define_submap("scrolloverview", function()
		local directions = { h = "left", j = "down", k = "up", l = "right" }
		for key, direction in pairs(directions) do
			hl.bind(key, overview.navigate(direction))
			hl.bind(direction, overview.navigate(direction))
		end
		-- hjkl and the arrows already moved the selection; closing commits it.
		hl.bind("return", overview.overview("off"))
		hl.bind("escape", overview.overview("off"))
		-- Toggle per monitor, not "off": "off" with no target closes the
		-- overview on every monitor, so a second monitor could never open one.
		hl.bind("SUPER + G", function()
			M.toggle_overview()
		end)
		-- Left click: go to the clicked window (or workspace) and close.
		hl.bind("mouse:272", function()
			overview.overview("select")
			overview.window("select")
			overview.overview("off")
		end, { mouse = true })
	end)
end

-- Toggles the overview on the monitor under the cursor. Not the focused
-- monitor: an open overview keeps focus where it was, so moving the mouse to
-- another monitor would toggle the wrong one. Bind it to a key: the plugin
-- only dispatches straight away when called from a keybind.
function M.toggle_overview()
	local plugin = overview_plugin()
	if not plugin then
		return
	end
	local monitor = hl.get_monitor_at_cursor()
	plugin.overview(monitor and ("toggle " .. monitor.name) or "toggle")
end

-- Fullscreen restore.
--
-- Going fullscreen scrolls the view to the window, and leaving fullscreen does
-- not scroll it back. So toggle_fullscreen remembers where the window sat on
-- its monitor, as a fraction of the monitor width, and the exit handler scrolls
-- the view until the window is back there. Fullscreen requested by the app
-- itself (F11, video players) is not remembered and left alone.

-- window address -> left edge as a fraction of its monitor's width
local saved_offsets = {}

local function offset_fraction(window)
	local monitor = window.monitor
	return (window.at.x - monitor.x) / monitor.width
end

function M.toggle_fullscreen()
	local window = hl.get_active_window()
	if window and window.fullscreen == 0 and not window.floating then
		saved_offsets[window.address] = offset_fraction(window)
	end
	hl.dispatch(hl.dsp.window.fullscreen({ action = "toggle" }))
end

hl.on("window.fullscreen", function(window)
	if window.fullscreen ~= 0 then
		return
	end
	local saved = saved_offsets[window.address]
	saved_offsets[window.address] = nil
	if not saved then
		return
	end

	-- `move` scrolls the view by whole pixels; it accepts no other unit.
	local shift = math.floor((saved - offset_fraction(window)) * window.monitor.width + 0.5)
	if shift ~= 0 then
		hl.dispatch(hl.dsp.layout("move " .. shift))
	end
end)

return M
