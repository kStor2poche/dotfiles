local h = require("helpers")

return {
    -- Mason
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    -- Custom LSPs/addons
    "Hoffs/omnisharp-extended-lsp.nvim",
    "barreiroleo/ltex-extra.nvim", -- TODO: maybe uninstall because it seems that none of those plugins really work
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
                on_attach = function(client, bufnr)
                    local bufopts = { noremap = true, silent = true, buffer = bufnr }
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, h.tbl_append(bufopts, "desc", "Lsp - Go to definition"))
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, h.tbl_append(bufopts, "desc", "Lsp - Go to declaration"))
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, h.tbl_append(bufopts, "desc", "Lsp - Hover"))
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, h.tbl_append(bufopts, "desc", "Lsp - Go to implementation"))
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, h.tbl_append(bufopts, "desc", "Lsp - Signature help"))
                    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, h.tbl_append(bufopts, "desc", "Lsp - Add ws folder"))
                    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, h.tbl_append(bufopts, "desc", "Lsp - Rm ws folder"))
                    vim.keymap.set('n', '<space>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, h.tbl_append(bufopts, "desc", "Lsp - ls ws folders"))
                    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, h.tbl_append(bufopts, "desc", "Lsp - Go to type definition"))
                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, h.tbl_append(bufopts, "desc", "Lsp - Rename symbol"))
                    -- Apply action when "fix available" from lsp
                    vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, h.tbl_append(bufopts, "desc", "Lsp - Code actions"))
                    vim.keymap.set('n', 'gr', require("telescope.builtin").lsp_references, h.tbl_append(bufopts, "desc", "Lsp - Show references"))
                    vim.keymap.set('n', '<space>F', function() vim.lsp.buf.format { async = true } end, h.tbl_append(bufopts, "desc", "Lsp - Format buffer"))
                    -- Cycle through code diagnostics
                    vim.keymap.set('n', '<leader>o', '<cmd>lua vim.diagnostic.open_float()<CR>', h.tbl_append(bufopts, "desc", "Lsp - Show diagnostics"))
                    vim.keymap.set('n', '<leader>[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', h.tbl_append(bufopts, "desc", "Lsp - Go to prev diag"))
                    vim.keymap.set('n', '<leader>]', '<cmd>lua vim.diagnostic.goto_next()<CR>', h.tbl_append(bufopts, "desc", "Lsp - Go to next diag"))
                end,
                actions = true,
                completion = true,
                hover = true,
            }
        },
    },

    -- Pretty icons
    "onsails/lspkind.nvim",

    -- Snips !
    {
        "L3MON4D3/LuaSnip",
        version = "*",
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        config = function ()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",

    -- Lastly, nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        event = { "VeryLazy" },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end
            local lspkind = require('lspkind')
            cmp.setup{
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    end,
                },
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        -- function(...) return cmp_buffer:compare_locality(...) end,
                        cmp.config.compare.score,
                        cmp.config.compare.order,
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.kind,
                        cmp.config.compare.recently_used,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                    },
                },
                window = {
                    completion = {
                        --cmp.config.window.bordered(),
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None", --seems to do nothing but uh, yeah, sure.
                        col_offset = -3,
                        side_padding = 0,
                    },
                    --documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
                    -- that way you will only jump inside the snippet region
                    elseif luasnip.expand_or_jumpable() then
                      luasnip.expand_or_jump()
                    elseif has_words_before() then
                      cmp.complete()
                    else
                      fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item()
                  elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                  else
                    fallback()
                  end
                end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'nvim_lua' },
                    { name = 'luasnip' },
                    { name = 'path' },
                    { name = 'buffer' },
                }),
                -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
                cmp.setup.cmdline({ '/', '?' }, {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = {
                        { name = 'buffer' }
                    }
                }),
                -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
                cmp.setup.cmdline(':', {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources({
                        { name = 'path' }
                    }, {
                        { name = 'cmdline' }
                    })
                }),
                formatting = {
                  fields = { "kind", "abbr", "menu" },
                  format = function(entry, vim_item)
                    local kind = lspkind.cmp_format({
                    mode = 'symbol_text', -- show only symbol annotations, could also be "text_symbol", "symbol", "text"
                    maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                    -- maxwidth = 30, 
                                   -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                                   -- can also be a function to dynamically calculate max width such as 
                                   -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                    ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

                    -- The function below will be called before any actual modifications from lspkind
                    -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                    -- before = function (entry, vim_item)
                    --   return vim_item
                    -- end
                  })(entry, vim_item)
                  local strings = vim.split(kind.kind, "%s", { trimempty = true })
                  kind.kind = " " .. (strings[1] or "") .. " "
                  kind.menu = "    (" .. (strings[2] or "") .. ")"

                  return kind
                end
                },
                experimental = {
                    ghost_text = true,
                }
            }
        end,
    },
}
