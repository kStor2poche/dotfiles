-- 
-- filetype-related config changes
--

local m = {}
m.setup = function ()
    -- use vim pre-defined filetype variables if possible (!WARNING: vim-polyglot WILL break this!)
    vim.g.filetype_typ = "typst"

    -- then general filetype reassignation
    vim.filetype.add({
        extension = {
            vsh = "glsl",
            dba = "dba",
            -- hbs = "html"
        }
    })

    -- register custom dba parser
    -- vim.api.nvim_create_autocmd("User", { pattern = "TSUpdate",
    --     callback = function()
            -- require("nvim-treesitter.parsers").dba = {
            --     install_info = {
            --         path = "/home/laio/Documents/Programmation/tree-sitter-dba",
            --         -- generate = false,
            --         -- generate_from_json = false,
            --     },
            -- }
    --     end
    -- })
    -- require("nvim-treesitter.parsers").handlebars = {
    --     install_info = {
    --         url = "https://github.com/trillioneyes/tree-sitter-handlebars",
    --         revision = "HEAD",
    --         branch = "main",
    --         generate = true,
    --         generate_from_json = false,
    --     }
    -- }
end

return m
