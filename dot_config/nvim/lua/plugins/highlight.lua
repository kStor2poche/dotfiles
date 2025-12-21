return {
    -- "sheerun/vim-polyglot", -- needed for handlebars :3
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main", -- plz remove once it becomes the default branch upstream
        lazy = false,
        build = ':TSUpdate',
    },
    {
        'MeanderingProgrammer/treesitter-modules.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        ---@module 'treesitter-modules'
        ---@type ts.mod.UserConfig
        opts = {
            ensure_installed = {
                "arduino", "c", "cpp", "lua", "c_sharp", "gdscript", "hlsl", "glsl",
                "glimmer", "haskell", "html", "java", "javascript", "json", "latex",
                "markdown", "markdown_inline", "python", "rust", "typst", "twig", "yuck",
            },
            sync_install = false,
            auto_install = true,
            fold = {
                enable = false,
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "markdown" },
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = 'gnn',
                    node_incremental = 'gn',
                    scope_incremental = 'gs',
                    node_decremental = 'gd',
                },
            },
            indent = {
                enable = false,
            }
        },
    },
}
