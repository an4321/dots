-- sections ::
-- utilities_and_state
-- filesystem
-- clipboard_and_log
-- rendering_and_ui
-- actions
-- preview
-- setup_and_entry_point

local M = {}
local api = vim.api
local fn = vim.fn

local config = {
	bookmarks = {
		["gh"] = "~",
		["ga"] = "~/Desktop",
		["gt"] = "~/Desktop/things",
		["gd"] = "~/Downloads",
		["gD"] = "~/Documents",
		["gv"] = "~/Videos",
		["gp"] = "~/Pictures",
		["gs"] = "~/Pictures/screenshots",
		["gl"] = "~/.local",
		["g."] = "~/.config",
		["gc"] = "~/dots",
		["gn"] = "~/notes",
	},
	preview_by_default = false,
}
local ns = api.nvim_create_namespace("fm_highlights")
local clip_file = fn.stdpath("data") .. "/fm_clipboard.json"

-- section: utilities_and_state

local function buf_get_state(buf)
	local ok, state = pcall(api.nvim_buf_get_var, buf, "fm_state")
	return ok and state or nil
end

local function buf_set_state(buf, state)
	api.nvim_buf_set_var(buf, "fm_state", state)
end

local function current_buf() return api.nvim_get_current_buf() end

local function cursor_entry()
	local line = api.nvim_get_current_line()
	return line:gsub("/$", "")
end

local function set_cursor_to(buf, target_name)
	local lines = api.nvim_buf_get_lines(buf, 0, -1, false)
	for i, line in ipairs(lines) do
		if line:gsub("/$", "") == target_name then
			api.nvim_win_set_cursor(fn.bufwinid(buf), { i, 0 })
			return
		end
	end
end

-- section: filesystem

local function scandir(path, show_hidden)
	local entries = fn.readdir(path)

	table.sort(entries, function(a, b)
		local a_dir = fn.isdirectory(path .. "/" .. a) == 1
		local b_dir = fn.isdirectory(path .. "/" .. b) == 1
		if a_dir == b_dir then return a < b end
		return a_dir
	end)

	local lines = {}
	for _, name in ipairs(entries) do
		if not show_hidden and name:sub(1, 1) == "." then goto continue end
		local full = path .. "/" .. name
		if fn.isdirectory(full) == 1 then
			table.insert(lines, name .. "/")
		else
			table.insert(lines, name)
		end
		::continue::
	end
	return lines
end

local function is_text_file(filepath)
	local f = io.open(filepath, "rb")
	if not f then return false end
	local chunk = f:read(1024)
	f:close()
	if not chunk then return true end
	return not chunk:find("%z")
end

-- section: clipboard_and_log

local function read_clipboard()
	local f = io.open(clip_file, "r")
	if not f then return { action = "none", items = {} } end
	local content = f:read("*a")
	f:close()
	if content == "" then return { action = "none", items = {} } end
	local ok, parsed = pcall(fn.json_decode, content)
	return ok and parsed or { action = "none", items = {} }
end

local function write_clipboard(action, items)
	local f = io.open(clip_file, "w")
	if f then
		f:write(fn.json_encode({ action = action, items = items }))
		f:close()
	end
end

-- section: rendering_and_ui

local function update_statusline(buf, state)
	local clip = read_clipboard()
	local clip_count = vim.tbl_count(clip.items)
	local clip_str = ""

	if clip_count > 0 then
		clip_str = clip.action == "cut"
		and (" %#ErrorMsg# [" .. clip_count .. "] ")
		or (" %#WarningMsg# [" .. clip_count .. "] ")
	end

	local short_path = fn.fnamemodify(state.path, ":~")
	local win = fn.bufwinid(buf)

	if win ~= -1 then
		vim.wo[win].winbar = "" -- clear winbar just in case
		vim.wo[win].statusline = " %#Normal# " .. short_path .. clip_str .. "%="
	end
end

local function apply_highlights(buf, state, lines)
	local clip = read_clipboard()
	api.nvim_buf_clear_namespace(buf, ns, 0, -1)
	for row, name in ipairs(lines) do
		local raw_name = name:gsub("/$", "")
		local full = state.path .. "/" .. raw_name
		local hl_group = "Normal"

		if state.selections[raw_name] then
			hl_group = "Visual"
		elseif clip.items[full] then
			hl_group = clip.action == "cut" and "DiagnosticError" or "DiagnosticWarn"
		elseif name:match("/$") then
			hl_group = "Directory"
		elseif fn.executable(full) == 1 then
			hl_group = "String"
		end

		if hl_group ~= "Normal" then
			api.nvim_buf_add_highlight(buf, ns, hl_group, row - 1, 0, -1)
		end
	end
end

local function render(buf)
	local state = buf_get_state(buf)
	if not state then return end
	state.cached_lines = scandir(state.path, state.show_hidden)

	vim.bo[buf].modifiable = true
	api.nvim_buf_set_lines(buf, 0, -1, false, state.cached_lines)
	vim.bo[buf].modifiable = false
	vim.bo[buf].modified = false

	apply_highlights(buf, state, state.cached_lines)
	update_statusline(buf, state)
	buf_set_state(buf, state)
end

local function fast_render(buf)
	local state = buf_get_state(buf)
	apply_highlights(buf, state, state.cached_lines)
	update_statusline(buf, state)
end

-- section: preview

local function close_preview(state)
	if state.preview_win and api.nvim_win_is_valid(state.preview_win) then
		api.nvim_win_close(state.preview_win, true)
	end
	state.preview_win = nil
end

local function update_preview(buf)
	local state = buf_get_state(buf)
	if not state or not state.preview_open then return end

	local name = cursor_entry()
	if not name or name == "" then return end
	local full = state.path .. "/" .. name

	if not state.preview_win or not api.nvim_win_is_valid(state.preview_win) then
		local win_width = api.nvim_win_get_width(0)
		local p_width = math.floor(win_width * 0.5)
		vim.cmd("botright " .. p_width .. "vnew")
		state.preview_win = api.nvim_get_current_win()

		local p_buf = api.nvim_get_current_buf()
		vim.bo[p_buf].buftype = "nofile"
		vim.bo[p_buf].bufhidden = "wipe"
		vim.bo[p_buf].swapfile = false

		vim.wo[state.preview_win].number = false
		vim.wo[state.preview_win].relativenumber = false
		vim.wo[state.preview_win].signcolumn = "no"
		vim.wo[state.preview_win].wrap = false

		api.nvim_set_current_win(fn.bufwinid(buf))
		buf_set_state(buf, state)
	end

	local p_buf = api.nvim_win_get_buf(state.preview_win)
	vim.bo[p_buf].modifiable = true
	api.nvim_buf_clear_namespace(p_buf, ns, 0, -1)

	if fn.isdirectory(full) == 1 then
		local lines = scandir(full, state.show_hidden)
		api.nvim_buf_set_lines(p_buf, 0, -1, false, lines)
		vim.bo[p_buf].filetype = "fm"
		for row, item in ipairs(lines) do
			local p_full = full .. "/" .. item:gsub("/$", "")
			if item:match("/$") then
				api.nvim_buf_add_highlight(p_buf, ns, "Directory", row - 1, 0, -1)
			elseif fn.executable(p_full) == 1 then
				api.nvim_buf_add_highlight(p_buf, ns, "String", row - 1, 0, -1)
			end
		end
	elseif is_text_file(full) then
		local lines = vim.fn.readfile(full, "", 200)

		-- sanitization for some filetype (like pdf)
		for i, line in ipairs(lines) do
			-- remove trailing \r, and replace internal \n ie NUL with a safe string
			lines[i] = line:gsub("\r$", ""):gsub("\n", "^@")
		end

		api.nvim_buf_set_lines(p_buf, 0, -1, false, lines)
		local ok_ft, ft = pcall(vim.filetype.match, { filename = full })
		if ok_ft and ft then vim.bo[p_buf].filetype = ft end
	else
		api.nvim_buf_set_lines(p_buf, 0, -1, false, {"Binary"})
		vim.bo[p_buf].filetype = ""
	end

	vim.bo[p_buf].modifiable = false
end

local function toggle_preview()
	local buf = current_buf()
	local state = buf_get_state(buf)
	state.preview_open = not state.preview_open
	buf_set_state(buf, state)

	if not state.preview_open then
		close_preview(state)
	else
		update_preview(buf)
	end
end

-- section: actions

local function quit_fm()
	local state = buf_get_state(current_buf())
	if state then close_preview(state) end
	vim.cmd("bd!")
end

local function open_entry()
	local buf = current_buf()
	local state = buf_get_state(buf)
	local name = cursor_entry()
	local full = state.path .. "/" .. name

	if fn.isdirectory(full) == 1 then
		state.path = full
		state.selections = {}
		buf_set_state(buf, state)
		render(buf)
		api.nvim_win_set_cursor(0, {1, 0})
	else
		if not is_text_file(full) then
			api.nvim_echo({{"skipping binary file", "WarningMsg"}}, false, {})
			return
		end
		close_preview(state)
		vim.cmd("edit " .. fn.fnameescape(full))
	end
end

local function system_open()
	local buf = current_buf()
	local state = buf_get_state(buf)
	local full = state.path .. "/" .. cursor_entry()

	-- use native neovim open if available (0.10+), otherwise fallback
	if vim.ui.open then
		vim.ui.open(full)
	else
		local cmd = fn.has("mac") == 1 and "open" or (fn.has("win32") == 1 and "start" or "xdg-open")
		fn.system({ cmd, fn.shellescape(full) })
	end
end

local function go_up()
	local buf = current_buf()
	local state = buf_get_state(buf)
	local parent = fn.fnamemodify(state.path, ":h")
	local current_dir_name = fn.fnamemodify(state.path, ":t")

	state.path = parent
	state.selections = {}
	buf_set_state(buf, state)
	render(buf)
	set_cursor_to(buf, current_dir_name)
end

local function toggle_hidden()
	local buf = current_buf()
	local state = buf_get_state(buf)
	state.show_hidden = not state.show_hidden
	buf_set_state(buf, state)
	render(buf)
end

local function create_items()
	local buf = current_buf()
	local state = buf_get_state(buf)
	local input = fn.input(" ceate: ")
	if input == "" then return end

	local first_created = nil
	for item in string.gmatch(input, "%S+") do
		local full = state.path .. "/" .. item
		-- create dir if it ends with a slash
		if item:match("/$") then
			fn.mkdir(full, "p")
		else
			fn.mkdir(fn.fnamemodify(full, ":h"), "p")
			local f = io.open(full, "w")
			if f then f:close() end
		end
		if not first_created then first_created = item:match("^[^/]+") end
	end

	render(buf)
	if first_created then set_cursor_to(buf, first_created) end
end

local function rename_single()
	local buf = current_buf()
	local state = buf_get_state(buf)
	local old = cursor_entry()
	local new = fn.input(" rename " .. old .. " to: ", old)

	if new ~= "" and new ~= old then
		fn.rename(state.path .. "/" .. old, state.path .. "/" .. new)
		render(buf)
		set_cursor_to(buf, new)
	end
end

local function delete_to_trash()
	local buf = current_buf()
	local state = buf_get_state(buf)

	local targets = {}
	if vim.tbl_count(state.selections) > 0 then
		for name, _ in pairs(state.selections) do
			table.insert(targets, state.path .. "/" .. name)
		end
	else
		table.insert(targets, state.path .. "/" .. cursor_entry())
	end

	local msg = #targets == 1
	and ("Trash " .. fn.fnamemodify(targets[1], ":t") .. "?")
	or ("Trash " .. #targets .. " items?")

	local ans = fn.confirm(msg, "&Yes\n&No", 2)

	if ans == 1 then
		for _, target in ipairs(targets) do
			-- check for common trash cli utilities, fallback to hard delete
			if fn.executable("trash-put") == 1 then
				fn.system({ "trash-put", target })
			elseif fn.executable("trash") == 1 then
				fn.system({ "trash", target })
			elseif fn.executable("gio") == 1 then
				fn.system({ "gio", "trash", target })
			else
				fn.delete(target, "rf")
			end
		end
		state.selections = {}
		buf_set_state(buf, state)
		render(buf)
	end
end

-- selection logic
local function toggle_select()
	local buf = current_buf()
	local state = buf_get_state(buf)
	local name = cursor_entry()

	state.selections[name] = not state.selections[name] and true or nil
	buf_set_state(buf, state)
	fast_render(buf)

	local r, _ = unpack(api.nvim_win_get_cursor(0))
	if r < #state.cached_lines then
		api.nvim_win_set_cursor(0, {r + 1, 0})
	end
end

local function unselect_all()
	local buf = current_buf()
	local state = buf_get_state(buf)
	state.selections = {}
	buf_set_state(buf, state)
	fast_render(buf)
end

local function invert_selection()
	local buf = current_buf()
	local state = buf_get_state(buf)
	local new_selections = {}
	for _, name in ipairs(state.cached_lines) do
		local raw = name:gsub("/$", "")
		if not state.selections[raw] then new_selections[raw] = true end
	end
	state.selections = new_selections
	buf_set_state(buf, state)
	fast_render(buf)
end

-- clipboard logic
local function mark_clipboard(action)
	local buf = current_buf()
	local state = buf_get_state(buf)
	local targets = {}

	if vim.tbl_count(state.selections) > 0 then
		for name, _ in pairs(state.selections) do
			targets[state.path .. "/" .. name] = true
		end
	else
		targets[state.path .. "/" .. cursor_entry()] = true
	end

	write_clipboard(action, targets)
	state.selections = {}
	buf_set_state(buf, state)
	fast_render(buf)
end

local function clear_clipboard()
	local buf = current_buf()
	write_clipboard("none", {})
	fast_render(buf)
end

local function get_safe_path(dir, name)
	local base = fn.fnamemodify(name, ":r")
	local ext = fn.fnamemodify(name, ":e")
	if ext ~= "" then ext = "." .. ext end

	local new_name = name
	local i = 1
	while fn.empty(fn.glob(dir .. "/" .. new_name)) == 0 do
		new_name = base .. tostring(i) .. ext
		i = i + 1
	end
	return dir .. "/" .. new_name
end

local function paste_entries()
	local buf = current_buf()
	local state = buf_get_state(buf)
	local clip = read_clipboard()
	if clip.action == "none" or vim.tbl_count(clip.items) == 0 then return end

	for src_path, _ in pairs(clip.items) do
		local filename = fn.fnamemodify(src_path, ":t")
		local dest_path = get_safe_path(state.path, filename)

		if clip.action == "cut" then
			fn.rename(src_path, dest_path)
		elseif clip.action == "yank" then
			if fn.isdirectory(src_path) == 1 then
				fn.system({ "cp", "-r", src_path, dest_path })
			else
				fn.system({ "cp", src_path, dest_path })
			end
		end
	end

	if clip.action == "cut" then write_clipboard("none", {}) end
	render(buf)
end

-- bulk rename
local function bulk_rename()
	local buf = current_buf()
	local state = buf_get_state(buf)
	local cursor_pos = api.nvim_win_get_cursor(0)
	close_preview(state)

	local r_buf = api.nvim_create_buf(false, true)
	api.nvim_set_current_buf(r_buf)

	local clean_lines = {}
	for i, line in ipairs(state.cached_lines) do 
		clean_lines[i] = line:gsub("/$", "") 
	end

	api.nvim_buf_set_lines(r_buf, 0, -1, false, clean_lines)
	api.nvim_win_set_cursor(0, cursor_pos)

	vim.bo[r_buf].buftype = "acwrite"
	api.nvim_buf_set_name(r_buf, "bulk_rename")

	api.nvim_create_autocmd("BufWriteCmd", {
		buffer = r_buf,
		callback = function()
			local new_lines = api.nvim_buf_get_lines(r_buf, 0, -1, false)
			local changes = {}

			-- identify what changed
			for i, old_name in ipairs(clean_lines) do
				local new_name = new_lines[i]
				if new_name and new_name ~= "" and old_name ~= new_name then
					table.insert(changes, { old = old_name, new = new_name })
				end
			end

			if #changes == 0 then
				api.nvim_buf_delete(r_buf, { force = true })
				M.open(state.path)
				return
			end

			-- build confirmation message
			local prompt = "confirm changes:\n"
			for _, change in ipairs(changes) do
				prompt = prompt .. string.format("  %s  ->  %s\n", change.old, change.new)
			end

			local confirm = fn.confirm(prompt, "&Yes\n&No", 2)
			if confirm == 1 then
				for _, change in ipairs(changes) do
					fn.rename(state.path .. "/" .. change.old, state.path .. "/" .. change.new)
				end
				vim.bo[r_buf].modified = false
				api.nvim_buf_delete(r_buf, { force = true })
				M.open(state.path)
			else
				api.nvim_echo({{"rename cancelled.", "Normal"}}, false, {})
			end
		end,
	})
end

-- section: setup_and_entry_point

local function set_keymaps(buf)
	local map = function(lhs, rhs)
		vim.keymap.set("n", lhs, rhs, { buffer = buf, silent = true, noremap = true })
	end

	map("q", quit_fm)
	map("<c-q>", quit_fm)
	map("l", open_entry)
	map("<cr>", open_entry)
	map("h", go_up)
	map("-", go_up)
	map(".", toggle_hidden)
	map("o", system_open)

	map("s", toggle_select)
	map("<esc>", unselect_all)
	map("v", invert_selection)

	map("a", create_items)
	map("r", rename_single)
	map("R", bulk_rename)
	map("d", delete_to_trash)

	map("x", function() mark_clipboard("cut") end)
	map("y", function() mark_clipboard("yank") end)
	map("p", paste_entries)
	map("<c-c>", clear_clipboard)

	map("<c-p>", toggle_preview)

	-- open terminal
	map("i", function()
		local state = buf_get_state(buf)
		close_preview(state)
		vim.cmd("lcd " .. fn.fnameescape(state.path) .. " | terminal")
		vim.cmd("startinsert")
	end)

	for key, dest in pairs(config.bookmarks) do
		map(key, function()
			local state = buf_get_state(buf)
			state.path = fn.fnamemodify(dest, ":p"):gsub("/$", "")
			state.selections = {}
			buf_set_state(buf, state)
			render(buf)
			api.nvim_win_set_cursor(0, {1, 0})
		end)
	end

	api.nvim_create_autocmd("CursorMoved", {
		buffer = buf,
		callback = function() update_preview(buf) end,
	})
end

function M.open(path)
	local start_path = path or fn.expand("%:p")
	local is_dir = fn.isdirectory(start_path) == 1

	local target_path = is_dir and start_path or fn.fnamemodify(start_path, ":h")
	local target_file = not is_dir and fn.fnamemodify(start_path, ":t") or nil
	if target_path == "" then target_path = fn.getcwd() end

	target_path = fn.fnamemodify(target_path, ":p"):gsub("/$", "")

	local buf = api.nvim_create_buf(false, true)
	api.nvim_set_current_buf(buf)

	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile = false
	vim.bo[buf].filetype = "fm"
	vim.bo[buf].modifiable = false

	buf_set_state(buf, {
		path = target_path,
		show_hidden = false,
		selections = {},
		preview_open = config.preview_by_default,
		cached_lines = {}
	})

	set_keymaps(buf)
	render(buf)

	if target_file and target_file ~= "" then
		set_cursor_to(buf, target_file)
	end
end

function M.setup(opts)
	config = vim.tbl_deep_extend("force", config, opts or {})

	api.nvim_set_hl(0, "FmDir", { link = "Directory", default = true })
	api.nvim_set_hl(0, "FmExec", { link = "String", default = true })
	api.nvim_set_hl(0, "FmCut", { link = "DiagnosticError", default = true })
	api.nvim_set_hl(0, "FmYank", { link = "DiagnosticWarn", default = true })
	api.nvim_set_hl(0, "FmSelect", { link = "Visual", default = true })

	api.nvim_create_user_command("Fm", function(cmd_opts)
		M.open(cmd_opts.args ~= "" and cmd_opts.args or nil)
	end, { nargs = "?" })

	-- disable netrw
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	-- open automatically on directories
	vim.api.nvim_create_autocmd("VimEnter", {
		once = true,
		callback = function()
			local arg = vim.fn.argv(0)
			if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
				-- clear the directory buffer
				vim.cmd("bwipeout")
				-- defer terminal creation until ui is ready
				vim.schedule(function() M.open() end)
			end
		end,
	})
end

return M
