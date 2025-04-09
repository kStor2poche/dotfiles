return {
    -- General utils
    "tpope/vim-fugitive",
    {
        'stevearc/oil.nvim',
        opts = {
            default_file_explorer = true,
            delete_to_trash = false,
            preview_split = "right",
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<leader>s"] = "actions.select_vsplit",
                ["<leader>h"] = "actions.select_split",
                ["<leader>t"] = "actions.select_tab",
                ["<leader>p"] = "actions.preview",
                ["<leader>q"] = "actions.close",
                ["<ESC>"] = "actions.close",
                ["<leader>r"] = "actions.refresh",
                ["<BS>"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["gt"] = "actions.toggle_trash",
            },
            float = {
                max_width = 0.7,
                max_height = 0.7,
            },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            input = { enabled = true },
            indent = { enabled = true },
            lazygit = { enabled = true },
            notifier = { enabled = true },
            scope = { enabled = true },
            styles = { enabled = true },
            -- words = { enabled = true },
        }
    },
    {
        'nvim-telescope/telescope.nvim',
        version = '*',
        dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons', 'nvim-telescope/telescope-ui-select.nvim' },
        opts = {
            pickers = {
                find_files = {
                    theme = 'dropdown',
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({})
                }
            }
        },
        init = function()
            require("telescope").load_extension("ui-select")
        end,
    },
    {
        "chrishrb/gx.nvim",
        keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
        cmd = { "Browse" },
        init = function ()
            vim.g.netrw_nogx = 1 -- disable netrw gx
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
        submodules = false, -- not needed, submodules are required only for tests
        opts = {
            open_browser_app = "firefox", -- specify your browser app; default for Linux is "xdg-open"
            open_browser_args = {"-url", "-new-window"},
            handlers = {
                plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
                github = true, -- open github issues
                brewfile = true, -- open Homebrew formulaes and casks
                package_json = true, -- open dependencies from package.json
                search = true, -- search the web/selection on the web if nothing else is found
                rust = { -- custom handler to open rust's cargo packages
                    name = "rust",
                    filetype = { "toml" },
                    filename = "Cargo.toml",
                    handle = function(mode, line, _)
                        local crate = require("gx.helper").find(line, mode, "(%w+)%s-=%s")

                        if crate then
                            return "https://crates.io/crates/" .. crate
                        end
                    end,
                },
            },
            handler_options = {
                search_engine = "duckduckgo", -- you can select between google, bing, duckduckgo, and ecosia
                select_for_search = false, -- if your cursor is e.g. on a link, the pattern for the link AND for the word will always match. This disables this behaviour for default so that the link is opened without the select option for the word AND link
            },
        }
    },
    -- Ft-specific utils
    {
        -- "toppair/peek.nvim",
        "kstor2poche/peek.nvim",
        event = { "VeryLazy" },
        build = "deno task --quiet build:fast",
        opts = {
            auto_load = false,
            app = {"firefox", "-P", "nvim-md-render"},
            user_style = "* {scroll-behavior: smooth;} html:has([data-theme=\"light\"]) {background: none !important;} html:has([data-theme=\"dark\"]) {background: #0d1117 !important;}",
        },
        init = function()
            vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
            vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
            vim.api.nvim_create_user_command("PeekToggle", function ()
                local peek = require("peek");
                if peek.is_open() then
                    peek.close()
                else
                    peek.open()
                end
            end,
            {})
        end,
    },
    {
        "lervag/vimtex",
        init = function()
            vim.g.vimtex_view_method='zathura'
        end
    },
}
