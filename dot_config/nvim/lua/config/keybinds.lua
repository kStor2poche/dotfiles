local m = {}

m.setup = function ()
    -- Nvim shortcuts
    vim.keymap.set("n", "<leader>tc", "<CMD>set ignorecase!<CR><CMD>set smartcase!<CR><CMD>set smartcase?<CR>", { desc = "Toggle smartcase" })
    vim.keymap.set("n", "<leader>th", "<CMD>set hlsearch!<CR><CMD>set hlsearch?<CR>", { desc = "Toggle hlsearch" })
    vim.keymap.set("n", "<leader>w", "g<C-g>", { desc = "Get character, word & line count" })

    -- Hex display
    vim.keymap.set("n", "<leader>x", "<CMD>%!xxd<CR>", { desc = "Xxd - Buffer hexdump" })
    vim.keymap.set("n", "<leader>X", "<CMD>%!xxd -r<CR>", { desc = "Xxd - Reverse buffer hexdump"})

    -- Undotree
    vim.keymap.set("n", "<leader>u", require("undotree").open, { desc = "Open undotree" })

    -- Peek markdown preview --> moved to after/ftplugin/markdown.lua

    -- Oil.nvim
    vim.keymap.set("n", "<BS>", "<CMD>Oil --float --preview<CR>", { desc = "Oil - Open float" })
    vim.keymap.set("n", "<C-BS>", "<CMD>Oil<CR>", { desc = "Oil - Open fullscreen" })

    -- Telescope
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope - find files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope - live grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope - buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope - help tags" })
    vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "Telescope - LSP references" })
    vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Telescope - LSP symbols" })
    vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Telescope - open recent files" })
    vim.keymap.set("n", "<leader>fd", function () builtin.diagnostics({bufnr=0}) end, { desc = "Telescope - document diagnostics" })
    vim.keymap.set("n", "<leader>fD", builtin.diagnostics, { desc = "Telescope - workspace diagnostics" })
    vim.keymap.set("n", "<leader>fn", require("telescope").extensions.notify.notify, { desc = "Telescope - notification history" })

    -- Lazygit
    vim.keymap.set("n", "<leader>gg", Snacks.lazygit.open, { desc = "Open Lazygit" })
    vim.keymap.set("n", "<leader>gl", Snacks.lazygit.log, { desc = "Open Lazygit (log view)" })
    vim.keymap.set("n", "<leader>gf", Snacks.lazygit.log_file, { desc = "Open Lazygit (current file log)" })

    -- Typst-preview
    vim.keymap.set("n", "<leader>T", "<CMD>TypstPreviewToggle<CR>", { desc = "Open Typst preview" })

    --
    -- copy/paste bindings
    --

    -- global ones
    vim.keymap.set("v", "<c-c>", "\"+y", {})
    -- GUI-specific ones (maybe merge all that into a single gui file)
    if vim.g.neovide then
        vim.keymap.set("v", "<c-s-c>", "\"+y", {})
        vim.keymap.set("v", "<c-s-v>", "\"+p", {})
        vim.keymap.set("n", "<c-s-c>", "\"+y", {})
        vim.keymap.set("n", "<c-s-v>", "\"+p", {})
        vim.keymap.set("i", "<c-s-v>", "<ESC>\"+pa", { noremap = true }) -- <c-r>+ does weird things on indents
        vim.keymap.set("c", "<c-s-v>", "<c-r>+", { noremap = true })
        -- vim.keymap.set("i", "<c-r>", "<c-s-v>", { noremap = true }) -- who needed that ?????
    end


    --[[
    nmap <leader>j <C-e> --> repeat doesn't work, I should investigate why
    nmap <leader>k <C-y>
    noremap <C-A> <esc> -- , at least we tried
    ]]--
end

return m
