require("full-border").setup()
require("bookmarks"):setup({
	last_directory = { enable = true, persist = true },
	persist = "all",
	desc_format = "parent", -- smh doesn't work ??
	file_pick_mode = "hover",
	notify = {
		enable = true,
		timeout = 2,
		message = {
			new = "New bookmark '<key>' -> '<folder>'",
			delete = "Deleted bookmark in '<key>'",
			delete_all = "Deleted all bookmarks",
		},
	},
})
require("smart-enter"):setup {
	open_multi = true,
}
require("relative-motions"):setup {
	show_numbers="relative_absolute",
	show_motion = true,
	enter_mode ="first"
}

Status:children_add(function()
	local h = cx.active.current.hovered
	if h == nil or ya.target_family() ~= "unix" then
		return ""
	end

	return ui.Line {
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("lightmagenta"),
		":",
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("lightmagenta"),
		" ",
	}
end, 500, Status.RIGHT)

Header:children_add(function()
	if ya.target_family() ~= "unix" then
		return ""
	end
	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
end, 500, Header.LEFT)
