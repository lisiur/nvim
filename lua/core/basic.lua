local vars = require("core.vars")

vim.o.termguicolors = true
vim.o.mouse = "a"
vim.o.errorbells = true
vim.o.visualbell = true
vim.o.hidden = true
vim.o.fileformats = "unix,mac,dos"
vim.o.magic = true
vim.o.virtualedit = "block"
vim.o.encoding = "utf-8"
vim.o.viewoptions = "folds,cursor,curdir,slash,unix"
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
-- vim.o.clipboard = "unnamedplus"
vim.o.wildignorecase = true
vim.o.wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**"
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.undodir = vars.cache_dir .. "undo/"
-- directory = global.cache_dir .. "swap/"
-- backupdir = global.cache_dir .. "backup/"
-- viewdir = global.cache_dir .. "view/"
-- spellfile = global.cache_dir .. "spell/en.uft-8.add"
vim.o.history = 2000
vim.o.shada = "!,'300,<50,@100,s10,h"
vim.o.backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim"
vim.o.smarttab = true
vim.o.shiftround = true
vim.o.timeout = true
vim.o.ttimeout = true
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 0
vim.o.updatetime = 100
vim.o.redrawtime = 1500
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.infercase = true
vim.o.incsearch = true
vim.o.wrapscan = true
vim.o.complete = ".,w,b,k"
vim.o.inccommand = "nosplit"
vim.o.grepformat = "%f:%l:%c:%m"
vim.o.grepprg = "rg --hidden --vimgrep --smart-case --"
vim.o.breakat = [[\ \	;:,!?]]
vim.o.startofline = false
vim.o.whichwrap = "h,l,<,>,[,],~"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.switchbuf = "useopen"
vim.o.backspace = "indent,eol,start"
vim.o.diffopt = "filler,iwhite,internal,algorithm:patience"
vim.o.completeopt = "menuone,noselect"
vim.o.jumpoptions = "stack"
vim.o.showmode = false
vim.o.shortmess = "aoOTIcF"
vim.o.scrolloff = 2
vim.o.sidescrolloff = 5
vim.o.foldlevelstart = 99
vim.o.ruler = true
vim.o.cursorline = true
-- cursorcolumn = true
vim.o.list = true
vim.o.showtabline = 2
vim.o.winwidth = 30
vim.o.winminwidth = 10
vim.o.pumheight = 15
vim.o.helpheight = 12
vim.o.previewheight = 12
vim.o.showcmd = false
vim.o.cmdheight = 2
vim.o.cmdwinheight = 5
vim.o.equalalways = false
vim.o.laststatus = 2
vim.o.display = "lastline"
vim.o.showbreak = "???  "
vim.o.listchars = "tab:????,nbsp:+,trail:??,extends:???,precedes:???"
-- pumblend = 10
-- winblend = 10
vim.o.autoread = true
vim.o.autowrite = true

vim.o.undofile = true
vim.o.synmaxcol = 2500
vim.o.formatoptions = "1jcroql"
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.breakindentopt = "shift:2,min:20"
vim.o.wrap = false
vim.o.linebreak = true
vim.o.number = true
-- vim.o.relativenumber = true
vim.o.foldenable = true
vim.o.signcolumn = "yes"
vim.o.conceallevel = 0
vim.o.concealcursor = "niv"
-- vim.o.shell = "C:\\Users\\lisiu\\.local\\bin\\nu\\bin\\nu.exe -i"

vim.g.encoding = "UTF-8"
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
vim.g.python_host_prog = vim.g.user_config.python_host_prog
vim.g.python3_host_prog = vim.g.user_config.python3_host_prog
vim.g.sqlite_clib_path = vim.g.user_config.sqlite_clib_path
