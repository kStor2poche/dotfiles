return {
    -- top to bottom (kinda)
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        opts = {
                terminal_colors = true,
                undercurl = true,
                underline = true,
                bold = true,
                italic = {
                    strings = false,
                    emphasis = true,
                    comments = true,
                    operators = false,
                    folds = true,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "hard", -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = false,
        },
        init = function()
            vim.o.background = "dark"
            vim.cmd("colorscheme gruvbox")
        end,
    },
    {
        "serhez/bento.nvim",
        opts = {
            main_keymap = '=',
            ui = {
                floating = {
                    minimal_menu = "dashed"
                }
            }
        }
    },
    {
        'rcarriga/nvim-notify',
        opts = {
            timeout = 500,
            fps = 180,
            -- render = "compact",
            stages = "fade",
            icons = {
                DEBUG = "",
                ERROR = "",
                INFO = "",
                TRACE = "✎",
                WARN = ""
            },
            background_colour = 'Normal',
        },
        init = function()
            vim.notify = require("notify")
        end
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
            icons = {
                rules = {
                    { pattern = "xxd", icon = "󱊧", color = "purple"},
                    { pattern = "oil", icon = "", color = "black"},
                    { pattern = "bufferline", icon = "󰓪", color = "cyan"},
                    { pattern = "line count", icon = "", color = "cyan"},
                    { pattern = "git", icon = "", color = "white"},
                }
            },
            delay = 0
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = {
             options = {
                 icons_enabled = true,
                 theme = "gruvbox",
             },
         }
    },
}
