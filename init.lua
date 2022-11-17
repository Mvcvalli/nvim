-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

-- Install plugins
require('packer').startup(function(use)
use("windwp/nvim-autopairs")
use("norcalli/nvim-colorizer.lua")
use("kyazdani42/nvim-tree.lua")
use("nvim-tree/nvim-web-devicons")
use("romgrk/fzy-lua-native")
use("nvim-lualine/lualine.nvim")
use("romgrk/barbar.nvim")
use("gelguy/wilder.nvim")
use("lunarvim/Onedarker.nvim")
use("sainnhe/gruvbox-material")

if is_bootstrap then
    require('packer').sync()
  end
end)

-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
)

--  Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Options
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.gdefault = true
vim.o.termguicolors = true
vim.o.showmode = false
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.linebreak = true
vim.o.clipboard = "unnamed,unnamedplus"
vim.o.fileencoding = "utf-8"
vim.o.virtualedit = "onemore"
vim.o.wildmenu = true
vim.o.wildoptions = "pum"
vim.o.cursorline = true
vim.o.completeopt = "menuone,noselect"
vim.o.hidden = true
vim.o.mouse = "a"
vim.o.fillchars = "eob: "

-- Keymaps

--- Change leader to a space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--- Disable Recording & Ex Mode
vim.keymap.set('', 'q', '<nop>')
vim.keymap.set('', 'Q', '<nop>')

--- Disable arrow keys
vim.keymap.set('', '<up>', '<nop>')
vim.keymap.set('', '<down>', '<nop>')
vim.keymap.set('', '<left>', '<nop>')
vim.keymap.set('', '<right>', '<nop>')

--- : to ;
vim.keymap.set("n", ";", ":", { noremap = true })

--- File explorer
vim.keymap.set("n", "<C-f>", ":NvimTreeToggle<CR>", opts)

--- Spell checker
vim.keymap.set("n", "<C-s>", "<cmd>:set spell spelllang=en_nz<CR>", opts)

--- Copies the contents of the entire file to clipboard
vim.keymap.set("n", "<C-y>", "<esc>:%y+<CR>")

--- Opens a new tab.
vim.keymap.set("n", "<C-t>", ":tabnew<CR>", opts)

--- Reload configuration without restart nvim
vim.keymap.set('n', '<C-r>', ':so %<CR>')

--- Close all windows and exit from Neovim.
vim.keymap.set('n', '<C-q>', ':qa!<CR>')

-- Auto-commands
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

-- Set colorscheme
vim.cmd [[colorscheme onedarker]]

-- Plugin configuration

--- autopairs
require("nvim-autopairs").setup()

--- colorizer
require'colorizer'.setup()

--- nvim-tree
require("nvim-tree").setup()

--- barbar
vim.g.bufferline = {
	animation = true,
	tabpages = true,
	clickable = true,
	icon_close_tab = "",
	icon_separator_active = "",
	icon_separator_inactive = "",
}

--- lualine

require'lualine'.setup({
    options = {
        section_separators = { left = '', right = ''},
        component_separators = ''
    }
})

--- wilder
local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})
-- Disable Python remote plugin
wilder.set_option('use_python_remote_plugin', 0)

wilder.set_option('pipeline', {
  wilder.branch(
    wilder.cmdline_pipeline({
      fuzzy = 1,
      fuzzy_filter = wilder.lua_fzy_filter(),
    }),
    wilder.vim_search_pipeline()
  )
})

wilder.set_option('renderer', wilder.renderer_mux({
  [':'] = wilder.popupmenu_renderer({
    highlighter = wilder.lua_fzy_highlighter(),
    left = {
      ' ',
      wilder.popupmenu_devicons()
    },
    right = {
      ' ',
      wilder.popupmenu_scrollbar()
    },
  }),
  ['/'] = wilder.wildmenu_renderer({
    highlighter = wilder.lua_fzy_highlighter(),
  }),
}))


