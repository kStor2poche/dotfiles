-- Peek markdown preview --> moved to after/ftplugin/markdown.lua

-- Nvim shortcuts
vim.keymap.set("", "<leader>c", "<CMD>set smartcase!<CR><CMD>set smartcase?<CR>", { desc = "Toggle smartcase" })
vim.keymap.set("", "<leader>h", "<CMD>set hlsearch!<CR><CMD>set hlsearch?<CR>", { desc = "Toggle hlsearch" })
vim.keymap.set("n", "<leader>w", "g<C-g>", { desc = "Get character, word & line count" })

-- Hex display
vim.keymap.set("", "<leader>x", "<CMD>%!xxd<CR>", { desc = "Xxd - Buffer hexdump" })
vim.keymap.set("", "<leader>X", "<CMD>%!xxd -r<CR>", { desc = "Xxd - Reverse buffer hexdump"})

-- Bufferline commands
vim.keymap.set("", "<leader>h", "<CMD>BufferLineCyclePrev<CR>", { desc = "Bufferline - Prev" })
vim.keymap.set("", "<leader>l", "<CMD>BufferLineCycleNext<CR>", { desc = "Bufferline - Next" })
vim.keymap.set("", "<leader>H", "<CMD>BufferLineMovePrev<CR>", { desc = "Bufferline - Swap with prev" })
vim.keymap.set("", "<leader>L", "<CMD>BufferLineMoveNext<CR>", { desc = "Bufferline - Swap with next" })
vim.keymap.set("", "<leader>d", "<CMD>BufferLinePickClose<CR>", { desc = "Bufferline - Close" })

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
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Telescope - open recent files" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Telescope - diagnostics" })

-- Lazygit
vim.keymap.set("n", "<leader>gg", Snacks.lazygit.open, { desc = "Open Lazygit" })
vim.keymap.set("n", "<leader>gl", Snacks.lazygit.log, { desc = "Open Lazygit (log view)" })
vim.keymap.set("n", "<leader>gf", Snacks.lazygit.log_file, { desc = "Open Lazygit (current file log)" })

-- copy/paste bindings
    -- global ones
    vim.keymap.set("v", "<c-c>", '"+y', {})
    -- GUI-specific ones (maybe merge all that into a single gui file)
    if vim.g.neovide then
        vim.keymap.set("v", "<c-s-c>", '"+y', {})
        vim.keymap.set("v", "<c-s-v>", '"+p', {})
        vim.keymap.set("n", "<c-s-c>", '"+y', {})
        vim.keymap.set("n", "<c-s-v>", '"+p', {})
        vim.keymap.set("i", "<c-s-v>", '<ESC>"+pa', { noremap = true }) -- <c-r>+ does weird things on indents
        vim.keymap.set("c", "<c-s-v>", '<c-r>+', { noremap = true })
        vim.keymap.set("i", "<c-r>", '<c-s-v>', { noremap = true })
    end


--[[nmap <leader>j <C-e> -> repeat doesn't work, I should investigate why
nmap <leader>k <C-y>
noremap <C-A> <esc> , at least we tried ]]--
