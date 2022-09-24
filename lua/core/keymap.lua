local wk = require("which-key")

vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", " ", "", { noremap = true })
vim.api.nvim_set_keymap("x", " ", "", { noremap = true })

local function set_term_keymap(mode, name)
    local key = '<A-' .. name .. '>'
    local cmd = '<cmd>lua require("core.commands.toggleterm").toggle_' .. mode .. '("' .. name .. '")<cr>'
    vim.keymap.set('n', key, cmd, { desc = '' })
    vim.keymap.set('i', key, cmd, { desc = '' })
    vim.keymap.set('t', key, cmd, { desc = '' })
end

local function set_float_term_keymap(name)
    set_term_keymap('float', name)
end

local function set_vertical_term_keymap(name)
    set_term_keymap('vertical', name)
end

local function set_horizontal_term_keymap(name)
    set_term_keymap('horizontal', name)
end

wk.register({
    s = {
        name = "Window",
        k = { "<cmd>sp<cr><c-w>k", "Split Window Down" },
        h = { "<cmd>vsp<cr><c-w>h", "Split Window Right" },
        j = { "<cmd>sp<cr>", "Split Window Up" },
        l = { "<cmd>vsp<cr>", "Split Winodw Left" },
        c = { "<C-w>c", "Close Window" },
        o = { "<C-w>o", "Close Other Windows" },
        ["="] = { "<C-w>=", "Make All Window Same Size" },
    },

    ["<leader>"] = {
        p = {
            name = "Project",
            p = { "<cmd>lua require('telescope').extensions.project.project{}<cr>", "Select Project" },
            r = { "<cmd>lua require('telescope').extensions.frecency.frecency{}<cr>", "Frecency" },
            e = { "<cmd>Telescope oldfiles<cr>", "OldFiles" },
            f = { "<cmd>lua require('core.commands.telescope').find_files_under_project()<cr>", "Select File" },
            s = { "<cmd>lua require('core.commands.telescope').search_under_project()<cr>", "Global Search" },
            g = { "<cmd>Telescope git_files<cr>", "Select Git File" },
            z = { "<cmd>Telescope zoxide list<cr>", "Zoxide List" },
        },
        f = {
            name = "Find Buffer",
            l = { "<cmd>HopChar1CurrentLineAC<cr>", "Jump Current Line By One Char After Cursor" },
            h = { "<cmd>HopChar1CurrentLineBC<cr>", "Jump Current Line By One Char Before Cursor" },
            j = { "<cmd>HopChar2AC<cr>", "Jump Visible Buffer By Two Chars After Cursor" },
            k = { "<cmd>HopChar2BC<cr>", "Jump Visible Buffer By Two Chars Before Cursor" },
            f = { "<cmd>HopChar2<cr>", "Jump Visible Buffer By Two Chars" },
            w = { "<cmd>HopWordcr<cr>", "Jump Visible Buffer By Word" },
            ["/"] = { "<cmd>HopPattern<cr>", "Jump Visible Buffer By Pattern" },
        },
        l = { "<cmd>lua vim.lsp.buf.format {async = true}<cr>", "Format" },
        e = { "<cmd>NvimTreeToggle<cr>", "Toggle Explorer" },
        [";"] = { "<cmd>NvimTreeFindFile<cr>", "Focurs Current File In Explorer" },
        u = { "<cmd>UndotreeToggle<cr>", "Toggle UndoTree" },
        s = {
            name = "Session",
            s = { "<cmd>SaveSession<cr>", "Save Session" },
            r = { "<cmd>RestoreSession<cr>", "Save Session" },
            d = { "<cmd>DeleteSession<cr>", "Save Session" },
        },
        t = {
            name = "Terminal",
            t = { "<cmd>lua require('core.commands.toggleterm').toggle_unname()<cr>)>", "Toggle GitUI" },
            o = { "<cmd>lua require('core.commands.toggleterm').toggle_oneshot()<cr>)>", "Toggle GitUI" },
            g = { "<cmd>lua require('core.commands.toggleterm').toggle_gitui()<cr>)>", "Toggle GitUI" },
        },
        g = { "<cmd>lua require('core.commands.toggleterm').toggle_gitui()<cr>)>", "Toggle GitUI" },
        o = {
            name = "Org",
            g = {
                name = "gtd",
                n = { "<cmd>Neorg gtd capture<cr>", "New Task" }
            },
        },
        z = {
            name = "Zen Mode",
            n = { "<cmd>TZNarrow<cr>", "Narrow a text region for better focus" },
            f = { "<cmd>TZFocus<cr>", "Foucs the current window" },
            m = { "<cmd>TZMinimalist<cr>", "Disable ui components" },
            z = { "<cmd>TZAtaraxis<cr>", "Good ol' zen mode" },
        }
    },
    g = {
        name = "Go",
        b = { "<cmd>BufferLinePick<cr>", "Select Tab" },
        h = { "<cmd>Lspsaga lsp_finder<cr>", "Lsp Finder" },
        l = { "<cmd>LSoutlineToggle<cr>", "Toggle Outline" },
        ["]"] = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Go Next Diagnostic" },
        ["["] = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Go Prev Diagnostic" },
        s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show Signature" },
        re = { "<cmd>Lspsaga rename<cr>", "Rename" },
        k = { "<cmd>Lspsaga hover_doc<cr>", "Show Doc" },
        ["."] = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
        D = { "<cmd>Lspsaga peek_definition<cr>", "Peek Definition" },
        d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Peek Definition" },
        m = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
        M = { "<cmd>TroubleToggle lsp_references<cr>", "Toggle Trouble References" },
    },
})

vim.keymap.set('n', 'H', '^', { desc = '' })
vim.keymap.set('n', 'L', '$', { desc = '' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = '' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = '' })
vim.keymap.set('n', '<C-s>', '<cmd>write<cr>', { desc = '' })
vim.keymap.set('n', '<C-u>', '9k', { desc = '' })
vim.keymap.set('n', '<C-d>', '9j', { desc = '' })
vim.keymap.set('n', '<C-a>', 'ggVG', { desc = '' })

vim.keymap.set('i', '<C-b>', "<Left>")
vim.keymap.set('i', '<C-f>', "<Right>")
vim.keymap.set('i', '<C-a>', "<esc>I")
vim.keymap.set('i', '<C-s>', "<esc><cmd>write<cr>")
vim.keymap.set('i', '<C-v>', "<C-r>+")

vim.keymap.set('c', '<C-f>', "<Right>")
vim.keymap.set('c', '<C-a>', "<Home>")
vim.keymap.set('c', '<C-b>', "<Left>")
vim.keymap.set('c', '<C-e>', "<End>")
vim.keymap.set('c', '<C-h>', "<BS>")
vim.keymap.set('c', '<C-d>', "<Del>")
vim.keymap.set('c', '<C-t>', "<C-R>=expand('%:p:h') . '\\' <CR>")

vim.keymap.set('v', 'J', ":m '>+1<cr>gv", { desc = '' })
vim.keymap.set('v', 'K', ":m '<-2<cr>gv", { desc = '' })
vim.keymap.set('v', '<', '<gv', { desc = '' })
vim.keymap.set('v', '>', '>gv', { desc = '' })

vim.keymap.set('t', '<esc>', '<C-\\><C-N>', { desc = '' })
vim.keymap.set('t', '<A-h>', '<C-\\><C-N><C-w>h', { desc = '' })
vim.keymap.set('t', '<A-j>', '<C-\\><C-N><C-w>j', { desc = '' })
vim.keymap.set('t', '<A-k>', '<C-\\><C-N><C-w>k', { desc = '' })
vim.keymap.set('t', '<A-l>', '<C-\\><C-N><C-w>l', { desc = '' })
vim.keymap.set('i', '<A-h>', '<C-\\><C-N><C-w>h', { desc = '' })
vim.keymap.set('i', '<A-j>', '<C-\\><C-N><C-w>j', { desc = '' })
vim.keymap.set('i', '<A-k>', '<C-\\><C-N><C-w>k', { desc = '' })
vim.keymap.set('i', '<A-l>', '<C-\\><C-N><C-w>l', { desc = '' })
vim.keymap.set('n', '<A-h>', '<C-w>h', { desc = '' })
vim.keymap.set('n', '<A-j>', '<C-w>j', { desc = '' })
vim.keymap.set('n', '<A-k>', '<C-w>k', { desc = '' })
vim.keymap.set('n', '<A-l>', '<C-w>l', { desc = '' })

vim.keymap.set('i', '<A-.>', "<Plug>(TaboutMulti)")
vim.keymap.set('i', '<A-,>', "<Plug>(TaboutBackMulti)")

set_float_term_keymap("u")
set_float_term_keymap("i")
set_float_term_keymap("o")
set_float_term_keymap("p")
set_horizontal_term_keymap("m")
set_vertical_term_keymap(";")
