local h = require("helpers")

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

    -- Snips !
    -- {
    --     "L3MON4D3/LuaSnip",
    --     version = "*",
    --     -- install jsregexp (optional!).
    --     build = "make install_jsregexp",
    --     config = function ()
    --         require("luasnip.loaders.from_vscode").lazy_load()
    --     end,
    -- },
    -- "rafamadriz/friendly-snippets",
    -- "saadparwaiz1/cmp_luasnip",
    -- "hrsh7th/cmp-nvim-lsp",
    -- "hrsh7th/cmp-nvim-lsp-signature-help",
    -- "hrsh7th/cmp-nvim-lua",
    -- "hrsh7th/cmp-buffer",
    -- "hrsh7th/cmp-path",
    -- "hrsh7th/cmp-cmdline",

    -- Lastly, nvim-cmp
    -- {
    --     "hrsh7th/nvim-cmp",
    --     event = { "VeryLazy" },
    --     config = function()
    --         local cmp = require("cmp")
    --         local luasnip = require("luasnip")
    --         local has_words_before = function()
    --             unpack = unpack or table.unpack
    --             local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    --             return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    --         end
    --         local lspkind = require('lspkind')
    --         cmp.setup{
    --             snippet = {
    --                 -- REQUIRED - you must specify a snippet engine
    --                 expand = function(args)
    --                     -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    --                     require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    --                     -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
    --                     -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    --                 end,
    --             },
    --             sorting = {
    --                 priority_weight = 2,
    --                 comparators = {
    --                     -- function(...) return cmp_buffer:compare_locality(...) end,
    --                     cmp.config.compare.score,
    --                     cmp.config.compare.order,
    --                     cmp.config.compare.offset,
    --                     cmp.config.compare.exact,
    --                     cmp.config.compare.kind,
    --                     cmp.config.compare.recently_used,
    --                     cmp.config.compare.sort_text,
    --                     cmp.config.compare.length,
    --                 },
    --             },
    --             window = {
    --                 completion = {
    --                     --cmp.config.window.bordered(),
    --                     winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None", --seems to do nothing but uh, yeah, sure.
    --                     col_offset = -3,
    --                     side_padding = 0,
    --                 },
    --                 --documentation = cmp.config.window.bordered(),
    --             },
    --             mapping = cmp.mapping.preset.insert({
    --                 ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    --                 ['<C-f>'] = cmp.mapping.scroll_docs(4),
    --                 ['<C-Space>'] = cmp.mapping.complete(),
    --                 ['<C-e>'] = cmp.mapping.abort(),
    --                 ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    --                 ["<Tab>"] = cmp.mapping(function(fallback)
    --                 if cmp.visible() then
    --                     cmp.select_next_item()
    --                 -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
    --                 -- that way you will only jump inside the snippet region
    --                 elseif luasnip.expand_or_jumpable() then
    --                   luasnip.expand_or_jump()
    --                 elseif has_words_before() then
    --                   cmp.complete()
    --                 else
    --                   fallback()
    --                 end
    --             end, { "i", "s" }),
    --
    --             ["<S-Tab>"] = cmp.mapping(function(fallback)
    --               if cmp.visible() then
    --                 cmp.select_prev_item()
    --               elseif luasnip.jumpable(-1) then
    --                 luasnip.jump(-1)
    --               else
    --                 fallback()
    --               end
    --             end, { "i", "s" }),
    --             }),
    --             sources = cmp.config.sources({
    --                 { name = 'nvim_lsp' },
    --                 { name = 'nvim_lsp_signature_help' },
    --                 { name = 'nvim_lua' },
    --                 { name = 'luasnip' },
    --                 { name = 'path' },
    --                 { name = 'buffer' },
    --             }),
    --             -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    --             cmp.setup.cmdline({ '/', '?' }, {
    --                 mapping = cmp.mapping.preset.cmdline(),
    --                 sources = {
    --                     { name = 'buffer' }
    --                 }
    --             }),
    --             -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    --             cmp.setup.cmdline(':', {
    --                 mapping = cmp.mapping.preset.cmdline(),
    --                 sources = cmp.config.sources({
    --                     { name = 'path' }
    --                 }, {
    --                     { name = 'cmdline' }
    --                 })
    --             }),
    --             formatting = {
    --               fields = { "kind", "abbr", "menu" },
    --               format = function(entry, vim_item)
    --                 local kind = lspkind.cmp_format({
    --                 mode = 'symbol_text', -- show only symbol annotations, could also be "text_symbol", "symbol", "text"
    --                 maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
    --                 -- maxwidth = 30, 
    --                                -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    --                                -- can also be a function to dynamically calculate max width such as 
    --                                -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
    --                 ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
    --
    --                 -- The function below will be called before any actual modifications from lspkind
    --                 -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
    --                 -- before = function (entry, vim_item)
    --                 --   return vim_item
    --                 -- end
    --               })(entry, vim_item)
    --               local strings = vim.split(kind.kind, "%s", { trimempty = true })
    --               kind.kind = " " .. (strings[1] or "") .. " "
    --               kind.menu = "    (" .. (strings[2] or "") .. ")"
    --
    --               return kind
    --             end
    --             },
    --             experimental = {
    --                 ghost_text = true,
    --             }
    --         }
    --     end,
    -- },
}
