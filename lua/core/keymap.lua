local utils = require('utils')

vim.g.mapleader = " "
utils.set_keymap('n', ' ', '', nil, { noremap = true })
utils.set_keymap('x', ' ', '', nil, { noremap = true })

local prefix_leader = utils.set_keymap_prefix("n", "<leader>")
local prefix_g = utils.set_keymap_prefix("n", "g")
local prefix_s = utils.set_keymap_prefix("n", "s")

prefix_leader.cmd('c', '', 'Change')
prefix_leader.cmd('ct', 'lua require("core.commands.theme").change_theme()', 'Change Theme')

prefix_leader.cmd('e', 'NvimTreeToggle', 'Toggle Explorer')

prefix_leader.cmd('f', 'HopChar2', 'Jump Visible Buffer By Two Chars')

prefix_leader.cmd('g', '', 'Git')
prefix_leader.cmd('gg', 'Git', 'Open Git')
prefix_leader.cmd('gp', 'Git push', 'Git push')
prefix_leader.cmd('gf', 'Git pull', 'Git pull')

prefix_leader.cmd('j', '', 'Jump')
prefix_leader.cmd('jl', 'HopChar1CurrentLineAC', 'Jump Current Line After')
prefix_leader.cmd('jh', 'HopChar1CurrentLineBC', 'Jump Current Line Before')
prefix_leader.cmd('jj', 'HopChar2AC', 'Jump After')
prefix_leader.cmd('jk', 'HopChar2BC', 'Jump Before')
prefix_leader.cmd('jw', 'HopWord', 'Jump Word')

prefix_leader.cmd('l', 'lua vim.lsp.buf.format {async = true}', 'Format')

prefix_leader.cmd('p', '', 'Project')
prefix_leader.cmd('pp', 'lua require("telescope").extensions.project.project{}', 'Select Project')
prefix_leader.cmd('pr', 'lua require("telescope").extensions.frecency.frecency{}', 'Select Frecency')
prefix_leader.cmd('pe', 'Telescope oldfiles', 'Select Old File')
prefix_leader.cmd('pf', 'lua require("core.commands.telescope").find_files_under_project()', 'Search Files')
prefix_leader.cmd('ps', 'lua require("core.commands.telescope").search_under_project()', 'Search Project')
prefix_leader.cmd('pg', 'Telescope git_files', 'Search Git Files')

prefix_leader.cmd('s', '', 'Session')
prefix_leader.cmd('ss', 'SaveSession', 'Save Session')
prefix_leader.cmd('sr', 'RestoreSession', 'Restore Session')
prefix_leader.cmd('sd', 'DeleteSession', 'Delete Session')

prefix_leader.cmd('u', 'UndotreeToggle', 'Toggle Undo Tree')

prefix_leader.cmd('w', 'HopWordCurrentLine', 'Jump Current Line Word')

prefix_leader.cmd('z', '', 'Zend')
prefix_leader.cmd('zn', 'TZNarrow', 'Zend Narrow')
prefix_leader.cmd('zf', 'TZFocus', 'Zend Focus')
prefix_leader.cmd('zm', 'TZMinimalist', 'Zend Minimalist')
prefix_leader.cmd('zz', 'TZAtaraxis', 'Zend Ataraxis')

prefix_leader.cmd(';', 'NvimTreeFindFile', 'Focus File On NvimTree')

prefix_leader.cmd('/', 'HopPattern', 'Jump By Pattern')

prefix_leader.cmd(',', '', 'Plugin')
prefix_leader.cmd(',p', '', 'Packer')
prefix_leader.cmd(',ps', 'PackerSync', 'Sync')
prefix_leader.cmd(',pc', 'PackerCompile', 'Compile')
prefix_leader.cmd(',pi', 'PackerInstall', 'Install')
prefix_leader.cmd(',pu', 'PackerUpdate', 'Update')
prefix_leader.cmd(',pS', 'PackerStatus', 'Status')
prefix_leader.cmd(',pC', 'PackerClean', 'Clean')

prefix_leader.cmd(',l', '', 'Lsp')
prefix_leader.cmd(',li', 'LspInstall', 'Install')
prefix_leader.cmd(',lI', 'LspInfo', 'Info')

prefix_g.cmd('b', 'BufferLinePick', 'Select Tab')
prefix_g.cmd('h', 'Lspsaga lsp_finder', 'Lsp Finder')
prefix_g.cmd('l', 'LSoutlineToggle', 'Toggle Outline')
prefix_g.cmd(']', 'Lspsaga diagnostic_jump_next', 'Jump Next Diagnostic')
prefix_g.cmd('[', 'Lspsaga diagnostic_jump_prev', 'Jump Prev Diagnostic')
prefix_g.cmd('s', 'lua vim.lsp.buf.signature_help()', 'Show Signature')
prefix_g.cmd('re', 'Lspsaga rename', 'Rename')
prefix_g.cmd('k', 'Lspsaga hover_doc', 'Hover Doc')
prefix_g.cmd('.', 'Lspsaga code_action', 'Code Action')
prefix_g.cmd('d', 'Lspsaga peek_definition', 'Peek Definition')
prefix_g.cmd('D', 'lua vim.lsp.buf.definition()', 'Go Definition')
prefix_g.cmd('m', 'TroubleToggle', 'Toggle Trouble Panel')
prefix_g.cmd('n', 'lua require("gitsigns").next_hunk()', 'Go Next Hunk')
prefix_g.cmd('p', 'lua require("gitsigns").prev_hunk()', 'Go Prev Hunk')

prefix_s.raw('k', '<cmd>sp<cr><c-w>k', 'Split Up')
prefix_s.raw('j', '<cmd>sp<cr>', 'Split Down')
prefix_s.raw('h', '<cmd>vsp<cr><c-w>h', 'Split Left')
prefix_s.raw('l', '<cmd>vsp<cr>', 'Split Right')
prefix_s.raw('c', '<c-w>c', 'Close Window')
prefix_s.raw('o', '<c-w>o', 'Close Other Windows')
prefix_s.raw('=', '<c-w>=', 'Make All Window Same Size')

-- 快速移动到行首/尾
utils.set_keymap('n', 'H', '^')
utils.set_keymap('n', 'L', '$')

-- 搜索上一个/下一个时，聚焦到屏幕中间
utils.set_keymap('n', 'n', 'nzzzv')
utils.set_keymap('n', 'N', 'Nzzzv')

-- 保存
utils.set_keymap('n', '<C-s>', '<cmd>write<cr>')
utils.set_keymap('i', '<C-s>', "<esc><cmd>write<cr>")

-- 全选
utils.set_keymap('n', '<C-a>', 'ggVG')

-- 兼容 Terminal 的快捷键
utils.set_keymap('i', '<C-b>', "<Left>")
utils.set_keymap('i', '<C-f>', "<Right>")
utils.set_keymap('i', '<C-a>', "<esc>I")
utils.set_keymap('i', '<C-v>', "<C-r>+")
utils.set_keymap('c', '<C-f>', "<Right>")
utils.set_keymap('c', '<C-a>', "<Home>")
utils.set_keymap('c', '<C-b>', "<Left>")
utils.set_keymap('c', '<C-e>', "<End>")
utils.set_keymap('c', '<C-h>', "<BS>")
utils.set_keymap('c', '<C-d>', "<Del>")
utils.set_keymap('c', '<C-t>', "<C-R>=expand('%:p:h') . '\\' <CR>")

-- Visual 模式下的快速移动
utils.set_keymap('v', 'J', ":m '>+1<cr>gv")
utils.set_keymap('v', 'K', ":m '<-2<cr>gv")
utils.set_keymap('v', '<', '<gv')
utils.set_keymap('v', '>', '>gv')

-- 兼容 terminal 和 普通 buffer 之间的移动
utils.set_keymap('t', '<esc>', '<C-\\><C-N>')
utils.set_keymap('t', '<A-h>', '<C-\\><C-N><C-w>h')
utils.set_keymap('t', '<A-j>', '<C-\\><C-N><C-w>j')
utils.set_keymap('t', '<A-k>', '<C-\\><C-N><C-w>k')
utils.set_keymap('t', '<A-l>', '<C-\\><C-N><C-w>l')
utils.set_keymap('i', '<A-h>', '<C-\\><C-N><C-w>h')
utils.set_keymap('i', '<A-j>', '<C-\\><C-N><C-w>j')
utils.set_keymap('i', '<A-k>', '<C-\\><C-N><C-w>k')
utils.set_keymap('i', '<A-l>', '<C-\\><C-N><C-w>l')
utils.set_keymap('n', '<A-h>', '<C-w>h')
utils.set_keymap('n', '<A-j>', '<C-w>j')
utils.set_keymap('n', '<A-k>', '<C-w>k')
utils.set_keymap('n', '<A-l>', '<C-w>l')

-- 设置 toggle terminal 快捷键
utils.set_float_term_keymap("g", "gitui")
utils.set_float_term_keymap("u")
utils.set_float_term_keymap("i")
utils.set_float_term_keymap("o")
utils.set_float_term_keymap("p")
utils.set_horizontal_term_keymap("m")
utils.set_vertical_term_keymap(";")
