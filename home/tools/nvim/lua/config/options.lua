-- Loaded after LazyVim's defaults, so this only needs to keep the settings
-- that differ or that we want to pin explicitly.
local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.termguicolors = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hidden = true
opt.clipboard = "unnamedplus"

opt.scrolloff = 8 -- LazyVim default is 4
opt.foldenable = false -- LazyVim leaves folding enabled

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
