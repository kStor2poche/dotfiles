-- Editor options --
vim.opt.signcolumn = "yes" -- default was "auto"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.relativenumber = true
vim.opt.nu = true           -- display current line number on the current line
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.mouse = "a"
vim.opt.mousemoveevent = true
vim.opt.ignorecase = true   -- needed for smartcase to work properly
vim.opt.smartcase = true
vim.opt.splitright = true   -- simply makes more sense
vim.opt.splitbelow = true   -- this one too
vim.opt.undofile = true
vim.opt.undodir = "/home/laio/.local/share/nvim/undofiles"
vim.opt.laststatus = 3      -- one statusbar for multi window view
vim.opt.scrolloff = 5       -- 5 lines spacing to bottom/top when scrolling
vim.opt.timeout = false
-- vim.opt.ttimeout = false -- not sure about this one
vim.opt.termguicolors = true
vim.opt.shellcmdflag = "-ic"
vim.opt.shada = "!,'1000,f1,<50,s10,h" -- see :h 'shada'

-- GUI thingies (maybe make it its own file ?)    
if vim.g.neovide then
    vim.opt.smoothscroll = true
    vim.o.guifont = "BlexMono Nerd Font Mono:h11"
    -- floating shadow/blur seems to have some trouble    
    vim.g.neovide_floating_blur = true
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    vim.g.neovide_floating_shadow = true
    vim.g.neovide_floating_z_height = 5
    vim.g.neovide_light_angle_degrees = 45
    vim.g.neovide_light_radius = 5
    vim.g.neovide_refresh_rate = 90
    vim.g.neovide_refresh_rate_idle = 5
    vim.g.neovide_cursor_vfx_mode = "wireframe"
end

-- Leader setting
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Madules !
require("helpers")
require("config.styling")
require("config.lazy")
require("config.keybinds")
require("config.lsp")
require("config.ft-specific")

-- vim.treesitter.language.register("twig", "handlebars")
