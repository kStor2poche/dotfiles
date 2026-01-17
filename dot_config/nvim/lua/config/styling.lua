local m = {}

m.setup = function()
    vim.api.nvim_set_hl(0, "FloatTitle", { link = "NormalFloat" })
    vim.api.nvim_set_hl(0, "WinBarNC", { link = "WinBar", force = true })
    -- Try to override window border styling globally ?
    -- now can be done using vim.o.winborder
end

return m
