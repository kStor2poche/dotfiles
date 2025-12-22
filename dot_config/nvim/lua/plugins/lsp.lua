return {
    -- Mason
    {
        "williamboman/mason.nvim",
        opts = {
            ui = {
                check_outdated_packages_on_open = true,
                border = "none",
                icons = {
                    package_installed = "",
                    package_pending = "→",
                    package_uninstalled = "✕"
                }
            }
        }
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = require("config.lsp").mason_managed,
            automatic_installation = true,
            automatic_enable = false,
        }
    },
    "neovim/nvim-lspconfig",

    -- Custom LSPs/addons
    -- "Hoffs/omnisharp-extended-lsp.nvim",
    -- "barreiroleo/ltex-extra.nvim", -- TODO: maybe uninstall because it seems that none of those plugins really work
    {
        'saecki/crates.nvim',
        tag = "stable",
        event = { "BufRead Cargo.toml" },
        opts = {
            completion = {
                crates = {
                    enabled = true,
                    max_results = 8,
                    min_chars = 3,
                }
            },
            lsp = {
                enabled = true,
                on_attach = require("config.lsp").on_attach,
                actions = true,
                completion = true,
                hover = true,
            }
        },
    },

    -- Pretty icons
    "onsails/lspkind.nvim",

    -- blinky
    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = {
                preset = 'default',
                ['<C-CR>'] = { 'accept', 'fallback' },
                -- ['<ESC>'] = { 'cancel', 'fallback' },
            },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            completion = {
                documentation = { auto_show = true },
                ghost_text = { enabled = true },
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" },

            cmdline = {
                completion = { menu = { auto_show = true } },
            },
        },
        opts_extend = { "sources.default" }
    }
}
