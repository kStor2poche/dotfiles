vim.api.nvim_set_hl(0, "FloatTitle", { link = "NormalFloat" })
-- Try to override window border styling globally ?
--local border = {
--    {"🭽", "FloatBorder"},
--    {"▔", "FloatBorder"},
--    {"🭾", "FloatBorder"},
--    {"▕", "FloatBorder"},
--    {"🭿", "FloatBorder"},
--    {"▁", "FloatBorder"},
--    {"🭼", "FloatBorder"},
--    {"▏", "FloatBorder"},
--}
--local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
--function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
--      opts = opts or {}
--      opts.border = opts.border or border
--      return orig_util_open_floating_preview(contents, syntax, opts, ...)
--end
