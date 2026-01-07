local M = {}

local function open_fm(cwd)
	local cwd = cwd or vim.fn.getcwd()

	local tmpfile = vim.fn.tempname()
	local cmd = string.format( "lf -selection-path %s %s", tmpfile, cwd)

	vim.cmd("keepalt term " .. cmd)
	local buf = vim.api.nvim_get_current_buf()

	vim.bo[buf].buflisted = false

	vim.api.nvim_create_autocmd("TermClose", {
		buffer = buf, once = true,
		callback = function()
			vim.schedule(function()
				if vim.fn.filereadable(tmpfile) == 1 then
					local files = vim.fn.readfile(tmpfile)
					vim.fn.delete(tmpfile)
					for i, file in ipairs(files) do
						vim.cmd("argadd " .. file)
						if i == 1 then vim.cmd("edit " .. file) end
					end
				end
				if vim.api.nvim_buf_is_valid(buf) then
					vim.api.nvim_buf_delete(buf, { force = true })
				end
			end)
		end,
	})
end

function M.setup()
	-- command
	vim.api.nvim_create_user_command("Fm", function()
		open_fm(vim.fn.expand("%:p"))
	end, {})

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
				vim.schedule(function() open_fm(arg) end)
			end
		end,
	})
end

return M
