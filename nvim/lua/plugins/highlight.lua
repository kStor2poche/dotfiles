return {
    "sheerun/vim-polyglot",
    {
        "nvim-treesitter/nvim-treesitter",
        init = function()
            local ts_update = require('nvim-treesitter.install').update({
                with_sync = true
            })
            ts_update()
        end,
        opts = {
            ensure_installed = {
                "arduino", "c", "cpp", "lua", "c_sharp", "gdscript", "hlsl", "glsl",
                "html", "java", "json", "latex", "markdown", "markdown_inline", "python",
                "rust", "twig", "yuck",
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        },
    },
}
