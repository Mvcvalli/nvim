--- Settings
local opt = vim.opt
opt.mouse = "a"
opt.linebreak = true
opt.background = "dark"
opt.shortmess = "I"
opt.termguicolors = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.showmatch = true
opt.hlsearch = true
opt.gdefault = true
opt.equalalways = true
opt.splitbelow = true
opt.splitright = true
opt.wildmenu = true
opt.wildoptions = "pum"
opt.wildignorecase = true
opt.clipboard = "unnamedplus"

--- Auto-commands
local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

-- Remove whitespace on save
autocmd('BufWritePre', {
  pattern = '*',
  command = ":%s/\\s\\+$//e"
})

-- Don't auto commenting new lines
autocmd('BufEnter', {
  pattern = '*',
  command = 'set fo-=c fo-=r fo-=o'
})

--- Keymaps
-- Change leader to a space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable arrow keys
vim.keymap.set('', 'q', '<nop>')
vim.keymap.set('', 'Q', '<nop>')
vim.keymap.set('', '<up>', '<nop>')
vim.keymap.set('', '<down>', '<nop>')
vim.keymap.set('', '<left>', '<nop>')
vim.keymap.set('', '<right>', '<nop>')

-- Disable Recording & Ex Mode
vim.keymap.set('', 'q', '<nop>')
vim.keymap.set('', 'Q', '<nop>')

-- : to ;
vim.keymap.set("n", ";", ":", { noremap = true })

-- Copies the contents of the entire file to clipboard
vim.keymap.set("n", "<C-y>", ":%y+<CR>")

-- Close all windows and exit from Neovim.
vim.keymap.set('n', '<C-q>', ':qa!<CR>')

--- Abbreviations
vim.cmd('luafile $HOME/.config/nvim/abbreviations/abbreviations.lua')
