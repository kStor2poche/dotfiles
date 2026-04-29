local m = {}

m.setup = function()
    vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", { desc = "Show LSP Info" })
    vim.api.nvim_create_user_command("LspLog", function ()
        local state_path = vim.fn.stdpath("state")
        local log_path = vim.fs.joinpath(state_path, "lsp.log")
        vim.cmd(string.format("e %s", log_path))
    end, { desc = "Show LSP Info" })
end

return m
