return {
    -- top to bottom (kinda)
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
            }
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
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        opts = {
                terminal_colors = false,
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
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        opts = {
            -- highlights = {
            --     fill = {
            --         bg = '#1d2021',
            --     },
            --     background = {
            --         bg = '#1d2021',
            --     },
            --     numbers = {
            --         bg = '#1d2021'
            --     },
            -- },
            options = {
                modified_icon = '🖬',
                separator_style = {"", ""},--"slant"
                numbers = "ordinal",
                indicator = {
                    -- icon = "•",
                    style = "none",
                },
                hover = {
                    enabled = true,
                    delay = 0,
                    reveal = {"close"},
                },
                diagnostics = "nvim_lsp",
                diagnostics_update_on_event = true,
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    local s = " "
                    for e, n in pairs(diagnostics_dict) do
                        local sym = e == "error" and ""
                            or (e == "warning" and "" or "" )
                        s = s .. n .. sym
                    end
                    return s
                end,
                -- style_preset = 4, -- no-italic
                offsets = {
                    {
                    filetype = "neo-tree",
                    text = "File Explorer",
                    text_align = "center",
                    separator = false,
                    }
                }
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
