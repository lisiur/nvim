local M = {}

M['kyazdani42/nvim-web-devicons'] = {}

M['catppuccin/nvim'] = {
    as = "catppuccin",
    run = ":CatppuccinCompile",
    config = function()
        if vim.g.user_config.theme == 'dark' then
            vim.g.catppuccin_flavour = vim.g.user_config.prefer_dark_theme
        else
            vim.g.catppuccin_flavour = vim.g.user_config.prefer_light_theme
        end
        require('catppuccin').setup({
            term_colors = true,
            integrations = {
                hop = true,
                gitsigns = true,
                native_lsp = {
                    enabled = true,
                },
                indent_blankline = {
                    enabled = true,
                },
                cmp = true,
                notify = true,
                fidget = true,
                nvimtree = true,
                lsp_saga = true,
                lsp_trouble = true,
                telescope = true,
                treesitter = true,
                which_key = true,
                navic = { enabled = true, custom_bg = "NONE" }
            },
            compile = {
                enabled = true,
                path = vim.fn.stdpath("cache") .. "/catppuccin"
            }
        })
    end
}

M['rcarriga/nvim-notify'] = {
    config = function()
        local notify = require('notify')
        notify.setup({
            stages = "fade_in_slide_out",
            timeout = 2500,
            background_colour = "#000000",
        })
        vim.notify = notify
    end
}

M['hoob3rt/lualine.nvim'] = {
    event = "BufReadPost",
    config = function()
        local function diff_source()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
                return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                }
            end
        end

        local mini_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = { "location" },
        }
        local outline = {
            sections = mini_sections,
            filetypes = { "lspsagaoutline" },
        }
        require('lualine').setup({
            options = {
                icons_enabled = true,
                theme = 'catppuccin',
                component_separators = "|",
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { { 'branch' }, { 'diff', source = diff_source } },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {
                    { 'filetype', colored = true, icon_only = false },
                    { 'encoding' },
                    {
                        'fileformat',
                        icons_enabled = true,
                        symbols = {
                            unix = "LF",
                            dos = "CRLF",
                            mac = "CR",
                        },
                    },
                },
                lualine_z = { "progress", "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            extensions = {
                "nvim-tree",
                "toggleterm",
                "fugitive",
                outline,
            },
        })
    end,
}

M['SmiteshP/nvim-navic'] = {
    after = { 'nvim-lspconfig' },
    config = function()
        require('nvim-navic').setup({
            highlight = true,
        })
    end
}

M['kyazdani42/nvim-tree.lua'] = {
    cmd = { "NvimTreeToggle" },
    config = function()
        require('nvim-tree').setup({
            disable_netrw = true,
            hijack_cursor = true, -- Keeps the cursor on the first letter of the filename.
            hijack_netrw = true,
            renderer = {
                special_files = { "Cargo.toml", "Makerfile", "package.json", "README.md" },
                indent_markers = {
                    enable = true,
                    icons = {
                        corner = "└ ",
                        edge = "│ ",
                        item = "│ ",
                        none = "  ",
                    },
                },
                highlight_git = true,
                icons = {
                    git_placement = "before", -- before / after / signcolumn
                },
            },
            actions = {
                change_dir = {
                    enable = false,
                }
            },
            on_attach = function(bufnr)
                local inject_node = require("nvim-tree.utils").inject_node
                local telescope = require("core.commands.telescope")

                vim.keymap.set("n", "<leader>s", inject_node(function(node)
                    if node then
                        telescope.search_under(node.absolute_path)
                    end
                end), { buffer = bufnr, noremap = true })

                vim.keymap.set("n", "<leader>f", inject_node(function(node)
                    if node then
                        telescope.find_files_under(node.absolute_path)
                    end
                end), { buffer = bufnr, noremap = true })

                vim.keymap.set("n", "<leader>f", inject_node(function(node)
                    if node then
                        telescope.find_files_under(node.absolute_path)
                    end
                end), { buffer = bufnr, noremap = true })
            end
        })
    end
}

M['lewis6991/gitsigns.nvim'] = {
    event = { "BufReadPost", "BufNewFile" },
    requires = { "nvim-lua/plenary.nvim", opt = true },
    config = function()
        require('gitsigns').setup({
            signs = {
                add = { hl = "GitSignsAdd", text = "▌", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                change = { hl = "GitSignsChange", text = "▌", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
                delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr",
                    linehl = "GitSignsDeleteLn" },
                changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr",
                    linehl = "GitSignsChangeLn" },
            },
            keymaps = {
                noremap = true,
                buffer = true,
                ["n ]g"] = {
                    expr = true,
                    "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'",
                },
                ["n [g"] = {
                    expr = true,
                    "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'",
                },
                ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
                ["v <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
                ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
                ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
                ["v <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
                ["n <leader>hR"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
                ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
                ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line({full=true})<CR>',
                -- Text objects
                ["o ih"] = ':<C-U>Gitsigns select_hunk<CR>',
                ["x ih"] = ':<C-U>Gitsigns.select_hunk<CR>',
            },
            watch_gitdir = { interval = 1000, follow_files = true },
            current_line_blame = true,
            current_line_blame_opts = { delay = 1000, virtual_text_pos = "eol" },
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            word_diff = false,
            diff_opts = { internal = true },
        })
    end

}

M["lukas-reineke/indent-blankline.nvim"] = {
    event = "BufReadPost",
    config = function()
        require('indent_blankline').setup({
            char = "|",
            show_first_indent_level = true,
        })
        vim.cmd("autocmd CursorMoved * IndentBlanklineRefresh")
    end
}

M["akinsho/bufferline.nvim"] = {
    tag = "*",
    event = "BufReadPost",
    config = function()
        require('bufferline').setup({
            options = {
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "center",
                        padding = 1,
                    }
                },
            },
            highlights = require('catppuccin.groups.integrations.bufferline').get(),
        })
    end
}

M["j-hui/fidget.nvim"] = {
    event = "BufReadPost",
    config = function()
        require('fidget').setup({})
    end
}

M["nvim-lua/plenary.nvim"] = {}

M["nvim-telescope/telescope.nvim"] = {
    module = "telescope",
    cmd = "Telescope",
    requires = {
        { "nvim-lua/plenary.nvim", opt = false },
        { "nvim-lua/popup.nvim", opt = true },
    },
    config = function()
        vim.cmd([[packadd sqlite.lua]])
        vim.cmd([[packadd telescope-fzf-native.nvim]])
        vim.cmd([[packadd telescope-project.nvim]])
        vim.cmd([[packadd telescope-frecency.nvim]])

        local telescope_actions = require("telescope.actions.set")
        local fixfolds = {
            hidden = true,
            attach_mappings = function(_)
                telescope_actions.select:enhance({
                    post = function()
                        vim.cmd(":normal! zx")
                    end,
                })
                return true
            end,
        }

        local telescopeConfig = require("telescope.config")
        -- Clone the default Telescope configuration
        local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

        -- I want to search in hidden/dot files.
        table.insert(vimgrep_arguments, "--hidden")
        -- I don't want to search in the `.git` directory.
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!.git/*")

        local telescope = require('telescope')
        telescope.setup({
            defaults = {
                initial_mode = "insert",
                prompt_prefix = "  ",
                selection_caret = " ",
                entry_prefix = " ",
                scroll_strategy = "limit",
                results_title = false,
                layout_strategy = "horizontal",
                path_display = { "abmultigridsolute" },
                file_ignore_patterns = { ".git/", ".cache", "%.class", "%.pdf", "%.mkv", "%.mp4", "%.zip" },
                layout_config = {
                    prompt_position = "bottom",
                    horizontal = {
                        preview_width = 0.5,
                    },
                },
                file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                file_sorter = require("telescope.sorters").get_fuzzy_file,
                generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                vimgrep_arguments = vimgrep_arguments,
            },
            extensions = {
                fzf = {
                    fuzzy = false,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                frecency = {
                    show_scores = true,
                    show_unindexed = true,
                    ignore_patterns = { "*.git/*", "*/tmp/*" },
                },
            },
            pickers = {
                buffers = fixfolds,
                find_files = fixfolds,
                git_files = fixfolds,
                grep_string = fixfolds,
                live_grep = fixfolds,
                oldfiles = fixfolds,
            },
        })

        telescope.load_extension("fzf")
        telescope.load_extension("project")
        telescope.load_extension("frecency")
    end
}

M["nvim-telescope/telescope-fzf-native.nvim"] = {
    opt = true,
    run = "make",
    after = "telescope.nvim",
}

M["nvim-telescope/telescope-project.nvim"] = {
    opt = true,
    after = "telescope-fzf-native.nvim",
}

M["nvim-telescope/telescope-frecency.nvim"] = {
    opt = true,
    after = "telescope-project.nvim",
    requires = { { "tami5/sqlite.lua", opt = true } },
}

M["folke/which-key.nvim"] = {
    config = function()
        require('which-key').setup({
            presets = {
                operators = false,
                motions = false,
                text_objects = false,
                windows = false,
                nav = false,
            },
            spelling = {
                enabled = false,
                suggestions = 20,
            },
            key_labels = {
                ["<space>"] = "SPC",
                ["<cr>"] = "RET",
                ["<tab>"] = "TAB",
            },
            window = {
                border = 'single',
            },
        })
    end
}

M["wakatime/vim-wakatime"] = {
    opt = true,
    event = "UIEnter",
}

M["akinsho/toggleterm.nvim"] = {
    opt = true,
    event = "UIEnter",
    config = function()
        require("toggleterm").setup({
            -- size can be a number or function which is passed the current terminal
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.40
                end
            end,
            on_open = function()
                -- Prevent infinite calls from freezing neovim.
                -- Only set these options specific to this terminal buffer.
                vim.api.nvim_set_option_value("foldmethod", "manual", { scope = "local" })
                vim.api.nvim_set_option_value("foldexpr", "0", { scope = "local" })
            end,
            insert_mappings = [["<C-;>"]], -- whether or not the open mapping applies in insert mode
            hide_numbers = true, -- hide the number column in toggleterm buffers
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
            start_in_insert = true,
            persist_size = true,
            direction = "horizontal",
            close_on_exit = true, -- close the terminal window when the process exits
            shell = vim.g.user_config.shell, -- change the default shell
        })
    end
}

-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
M["JoosepAlviste/nvim-ts-context-commentstring"] = {
    after = "nvim-treesitter",
}

-- https://github.com/terrortylor/nvim-comment
M["terrortylor/nvim-comment"] = {
    event = "BufReadPost",
    config = function()
        require('nvim_comment').setup({
            hook = function()
                require('ts_context_commentstring.internal').update_commentstring()
            end
        })
    end,
}

-- https://github.com/windwp/nvim-ts-autotag
M["windwp/nvim-ts-autotag"] = {
    after = "nvim-treesitter",
    config = function()
        require('nvim-ts-autotag').setup({
            -- filetypes = {
            --     "html",
            --     "xml",
            --     "vue",
            -- }
        })
    end
}

M["nvim-treesitter/nvim-treesitter"] = {
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    event = "BufReadPost",
    config = function()
        vim.api.nvim_set_option_value("foldmethod", "expr", {})
        vim.api.nvim_set_option_value("foldexpr", "nvim_treesitter#foldexpr()", {})

        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "lua",
                "http",
                "json",
            },
            highlight = {
                enable = true,
                disable = { "vim" },
            },
            textobjects = {
                select = {
                    enable = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]["] = "@function.outer",
                        ["]m"] = "@class.outer",
                    },
                    goto_next_end = {
                        ["]]"] = "@function.outer",
                        ["]M"] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[["] = "@function.outer",
                        ["[m"] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[]"] = "@function.outer",
                        ["[M"] = "@class.outer",
                    },
                },
            },
            rainbow = {
                enable = true,
                extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
                max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
            },
            context_commentstring = { enable = true, enable_autocmd = false },
            matchup = { enable = true },
        })
        require("nvim-treesitter.install").prefer_git = true
        require("nvim-treesitter.install").compilers = { "clang" }
        local parsers = require("nvim-treesitter.parsers").get_parser_configs()
        for _, p in pairs(parsers) do
            p.install_info.url = p.install_info.url:gsub("https://github.com/", "git@github.com:")
        end
    end,
}

M["nvim-treesitter/nvim-treesitter-textobjects"] = {
    after = "nvim-treesitter",
}

M["neovim/nvim-lspconfig"] = {
    event = "BufReadPost",
    config = function()
        vim.cmd([[packadd lsp_signature.nvim]])
        vim.cmd([[packadd lspsaga.nvim]])
        vim.cmd([[packadd cmp-nvim-lsp]])
        vim.cmd([[packadd nvim-navic]])

        local nvim_lsp = require("lspconfig")
        local mason = require("mason")
        local mason_lsp = require("mason-lspconfig")

        mason.setup()
        mason_lsp.setup({
            ensure_installed = {
                "lua-language-server",
                "vue-language-server",
                "jsonls",
            },
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

        local function custom_attach(client, bufnr)
            require("lsp_signature").on_attach({
                bind = true,
                floating_window = true,
                fix_pos = true,
                hint_enable = false,
                hi_parameter = "Search",
                handler_opts = {
                    border = "rounded"
                },
            })
            require("nvim-navic").attach(client, bufnr)
        end

        -- Override server settings here

        for _, server in ipairs(mason_lsp.get_installed_servers()) do
            if server == "sumneko_lua" then
                nvim_lsp.sumneko_lua.setup({
                    capabilities = capabilities,
                    on_attach = custom_attach,
                    settings = {
                        Lua = {
                            diagnostics = { globals = { "vim", "packer_plugins" } },
                            workspace = {
                                library = {
                                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                                },
                                maxPreload = 100000,
                                preloadFileSize = 10000,
                            },
                            telemetry = { enable = false },
                        },
                    },
                })
            elseif server == "jsonls" then
                nvim_lsp.jsonls.setup({
                    flags = { debounce_text_changes = 500 },
                    capabilities = capabilities,
                    on_attach = custom_attach,
                    settings = {
                        json = {
                            -- Schemas https://www.schemastore.org
                            schemas = {
                                {
                                    fileMatch = { "package.json" },
                                    url = "https://json.schemastore.org/package.json",
                                },
                                {
                                    fileMatch = { "tsconfig*.json" },
                                    url = "https://json.schemastore.org/tsconfig.json",
                                },
                                {
                                    fileMatch = {
                                        ".prettierrc",
                                        ".prettierrc.json",
                                        "prettier.config.json",
                                    },
                                    url = "https://json.schemastore.org/prettierrc.json",
                                },
                                {
                                    fileMatch = { ".eslintrc", ".eslintrc.json" },
                                    url = "https://json.schemastore.org/eslintrc.json",
                                },
                                {
                                    fileMatch = {
                                        ".babelrc",
                                        ".babelrc.json",
                                        "babel.config.json",
                                    },
                                    url = "https://json.schemastore.org/babelrc.json",
                                },
                                {
                                    fileMatch = { "lerna.json" },
                                    url = "https://json.schemastore.org/lerna.json",
                                },
                                {
                                    fileMatch = {
                                        ".stylelintrc",
                                        ".stylelintrc.json",
                                        "stylelint.config.json",
                                    },
                                    url = "http://json.schemastore.org/stylelintrc.json",
                                },
                                {
                                    fileMatch = { "/.github/workflows/*" },
                                    url = "https://json.schemastore.org/github-workflow.json",
                                },
                            },
                        },
                    },
                })
            else
                nvim_lsp[server].setup({
                    capabilities = capabilities,
                    on_attach = custom_attach,
                })
            end
        end
    end,
}

M["williamboman/mason.nvim"] = {
    requires = {
        {
            "williamboman/mason-lspconfig.nvim",
        },
        { "WhoIsSethDaniel/mason-tool-installer.nvim", config = function()
            require('mason-tool-installer').setup({
                ensure_installed = {},
            })
        end },
    },
}

M["glepnir/lspsaga.nvim"] = {
    after = { "nvim-lspconfig" },
    config = function()
        local function without_italic(name)
            local hl = vim.api.nvim_get_hl_by_name(name, true)
            hl.italic = false
            return hl
        end

        vim.api.nvim_set_hl(0, 'LspSagaDiagnosticError', without_italic('DiagnosticError'))
        vim.api.nvim_set_hl(0, 'LspSagaDiagnosticWarn', without_italic('DiagnosticWarn'))
        vim.api.nvim_set_hl(0, 'LspSagaDiagnosticInfo', without_italic('DiagnosticInfo'))
        vim.api.nvim_set_hl(0, 'LspSagaDiagnosticHint', without_italic('DiagnosticHint'))

        require('lspsaga').init_lsp_saga({})

    end,
}

M["ray-x/lsp_signature.nvim"] = { opt = true, after = "nvim-lspconfig" }

-- https://github.com/knubie/nvim-cmp
M["hrsh7th/nvim-cmp"] = {
    event = "InsertEnter",
    requires = {
        { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" }, -- https://github.com/saadparwaiz1/cmp_luasnip
        { "hrsh7th/cmp-nvim-lsp", after = "LuaSnip" },
        { "hrsh7th/cmp-nvim-lua", after = "LuaSnip" },
        { "hrsh7th/cmp-path", after = "LuaSnip" },
        { "hrsh7th/cmp-buffer", after = "LuaSnip" },
    },
    config = function()
        local t = function(str)
            return vim.api.nvim_replace_termcodes(str, true, true, true)
        end
        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end


        local border = function(hl)
            return {
                { "╭", hl },
                { "─", hl },
                { "╮", hl },
                { "│", hl },
                { "╯", hl },
                { "─", hl },
                { "╰", hl },
                { "│", hl },
            }
        end

        local cmp_window = require("cmp.utils.window")

        cmp_window.info_ = cmp_window.info
        cmp_window.info = function(self)
            local info = self:info_()
            info.scrollable = false
            return info
        end

        local compare = require("cmp.config.compare")

        local cmp = require('cmp')
        cmp.setup({
            window = {
                completion = {
                    border = border("CmpBorder"),
                    winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
                },
                documentation = {
                    border = border("CmpDocBorder"),
                },
            },
            sorting = {
                comparators = {
                    compare.offset,
                    compare.exact,
                    compare.score,
                    compare.kind,
                    compare.sort_text,
                    compare.length,
                    compare.order,
                },
            },
            formatting = {
                format = function(entry, vim_item)
                    local lspkind_icons = {
                        Text = "",
                        Method = "",
                        Function = "",
                        Constructor = "",
                        Field = "",
                        Variable = "",
                        Class = "ﴯ",
                        Interface = "",
                        Module = "",
                        Property = "ﰠ",
                        Unit = "",
                        Value = "",
                        Enum = "",
                        Keyword = "",
                        Snippet = "",
                        Color = "",
                        File = "",
                        Reference = "",
                        Folder = "",
                        EnumMember = "",
                        Constant = "",
                        Struct = "",
                        Event = "",
                        Operator = "",
                        TypeParameter = "",
                    }
                    -- load lspkind icons
                    vim_item.kind = string.format("%s %s", lspkind_icons[vim_item.kind], vim_item.kind)

                    vim_item.menu = ({
                        buffer = "[BUF]",
                        nvim_lsp = "[LSP]",
                        nvim_lua = "[LUA]",
                        path = "[PATH]",
                        luasnip = "[SNIP]",
                    })[entry.source.name]

                    return vim_item
                end,
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-e>"] = cmp.mapping.close(),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif require("luasnip").expand_or_jumpable() then
                        vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif require("luasnip").jumpable(-1) then
                        vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'path' },
                { name = 'crates' }
            }),
        })
    end,
}

M["L3MON4D3/LuaSnip"] = {
    after = "nvim-cmp",
    requires = { "rafamadriz/friendly-snippets", opt = true },
    config = function()
        local snippets_dir = vim.fn.stdpath("config") .. "/snippets"
        vim.o.runtimepath = vim.o.runtimepath .. "," .. snippets_dir
        require("luasnip").config.set_config({
            history = true,
            updateevents = "TextChanged,TextChangedI",
            delete_check_events = "TextChanged,InsertLeave",
        })
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_snipmate").lazy_load()
        require("luasnip.loaders.from_lua").lazy_load()
    end,
}

M["windwp/nvim-autopairs"] = {
    after = "nvim-cmp",
    config = function()
        require('nvim-autopairs').setup()
    end,
}

M["phaazon/hop.nvim"] = {
    branch = "v2",
    event = "BufReadPost",
    config = function()
        require('hop').setup({})
    end
}

M["dstein64/vim-startuptime"] = {
    cmd = "StartupTime"
}

-- https://github.com/nathom/filetype.nvim
M["nathom/filetype.nvim"] = {
    config = function()
        require('filetype').setup({
            overrides = {
                extensions = {},
            }
        })
    end
}

-- https://github.com/romainl/vim-cool
M["romainl/vim-cool"] = {
    event = { "CursorMoved", "InsertEnter" }
}

M["andymass/vim-matchup"] = {
    after = "nvim-treesitter",
    config = function()
        vim.cmd([[let g:matchup_matchparen_offscreen = {'method': 'popup'}]])
    end
}

M["tpope/vim-fugitive"] = {
    cmd = { "Git" }
}

M["kylechui/nvim-surround"] = {
    event = "BufReadPost",
    config = function()
        require('nvim-surround').setup()
    end
}

M["Pocco81/true-zen.nvim"] = {
    cmd = { "TZNarrow", "TZFocus", "TZMinimalist", "TZAtaraxis" },
    config = function()
        require('true-zen').setup()
    end
}

M["simrat39/rust-tools.nvim"] = {
    ft = "rust",
    after = { "nvim-lspconfig" },
    requires = { { "nvim-lua/plenary.nvim" } },
    config = function()
        vim.cmd([[packadd nvim-lspconfig]])
        require("rust-tools").setup()
    end
}

M["akinsho/flutter-tools.nvim"] = {
    ft = "dart",
    requires = { { "nvim-lua/plenary.nvim" } },
    config = function()
        require('flutter-tools').setup()
    end
}

M["gelguy/wilder.nvim"] = {
    event = "CmdlineENter",
    requires = {
        { "romgrk/fzy-lua-native", after = "wilder.nvim" }
    },
    config = function()
        vim.cmd([[
call wilder#setup({'modes': [':', '/', '?']})
call wilder#set_option('use_python_remote_plugin', 0)
call wilder#set_option('pipeline', [wilder#branch(
	\ wilder#cmdline_pipeline({'use_python': 0,'fuzzy': 1, 'fuzzy_filter': wilder#lua_fzy_filter()}),
	\ wilder#vim_search_pipeline(),
	\ [wilder#check({_, x -> empty(x)}), wilder#history(), wilder#result({'draw': [{_, x -> ' ' . x}]})]
	\ )])
call wilder#set_option('renderer', wilder#renderer_mux({
	\ ':': wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
		\ 'highlighter': wilder#lua_fzy_highlighter(),
		\ 'left': [wilder#popupmenu_devicons()],
		\ 'right': [' ', wilder#popupmenu_scrollbar()],
        \ 'border': 'rounded'
		\ })),
	\ '/': wilder#wildmenu_renderer({
		\ 'highlighter': wilder#lua_fzy_highlighter(),
		\ 'apply_incsearch_fix': v:true,
		\})
	\ }))
]]       )
    end
}

M["stevearc/dressing.nvim"] = {}

M["karb94/neoscroll.nvim"] = {
    event = "BufReadPost",
    config = function()
        require('neoscroll').setup()
    end
}

M["RRethy/vim-illuminate"] = {
    event = "BufReadPost",
    config = function()
        if vim.api.nvim_get_hl_by_name("Visual", true).background then
            local illuminate_bg = string.format("#%06x", vim.api.nvim_get_hl_by_name("Visual", true).background)

            vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = illuminate_bg })
            vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = illuminate_bg })
            vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = illuminate_bg })
        end
        require('illuminate').configure({
            providers = {
                'lsp',
                'treesitter',
                'regex',
            },
            filetypes_denylist = {
                "alpha",
                "dashboard",
                "fugitive",
                "help",
                "norg",
                "NvimTree",
                "Outline",
                "packer",
                "toggleterm",
            },
            under_cursor = false,
        })
    end
}

M["saecki/crates.nvim"] = {
    event = { "BufRead Cargo.toml" },
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('crates').setup()
    end
}

M["nvim-neorg/neorg"] = {
    ft = "norg",
    after = "nvim-treesitter",
    requires = { 'nvim-lua/plenary.nvim' },
    run = ":Neorg sync-parsers",
    config = function()
        require('neorg').setup({
            load = {
                ["core.defaults"] = {},
                ["core.norg.dirman"] = {
                    config = {
                        workspaces = {
                            work = "C:\\Users\\lisiu\\org\\work",
                            home = "C:\\Users\\lisiu\\org\\home",
                        }
                    }
                }
            }
        })
    end
}

return M
