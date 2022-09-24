local config = require('config')

vim.g.did_load_filetypes = 1
vim.g.did_load_netrw = 1
vim.g.did_load_netrwPlugin = 1
vim.g.did_load_netrwSettings = 1
vim.g.did_load_netrwFileHandlers = 1
vim.g.did_loaded_matchit = 1

vim.cmd('colorscheme ' .. config.colorscheme)
require('core.basic')
require('core.bootstrap')
require('core.keymap')
