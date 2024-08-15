
vim.opt.cmdheight = 0
function recording_status()
    local recording = vim.fn.reg_recording()
    if recording ~= "" then
        return "Recording @" .. recording
    else
        return ""
    end
end

-- vim.opt.statusline = "%{%v:lua.recording_status()%} %f %h%w%m%r %=%-14.(%l,%c%V%) %P"
vim.opt.statusline = '%#StatusLine#  %t %h%m%r %{%v:lua.recording_status()%} %=%l,%c %p%% '

