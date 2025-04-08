-- filetype dependant config changes
-- gdscript files need true tabs
vim.api.nvim_create_autocmd( "BufEnter", {
    pattern = "*.gd",
    callback = function()
                   vim.opt.expandtab = false
               end
})

vim.api.nvim_create_autocmd( "BufEnter", {
    pattern = "*.vsh",
    callback = function()
                   vim.opt.filetype = "glsl"
               end
})
