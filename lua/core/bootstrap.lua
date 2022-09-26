require("config")
require('core.basic')
require("core.keymap")

local vars = require('core.vars')
local utils = require('utils')
local packer = nil
local packer_compiled = vars.data_dir .. 'lua/packer_compiled.lua'

local require_compiled_packer = function()
    require('packer_compiled')
    vim.cmd([[colorscheme catppuccin]])
end

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        vim.notify("Clone packer...")
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()
local function init_packer()
    vim.cmd [[packadd packer.nvim]]
    packer = require("packer")
    packer.init({
        disable_commands = true,
        compile_path = packer_compiled,
        display = {
            open_fn = function()
                local result, win, buf = require('packer.util').float({
                    border = {
                        { '╭', 'FloatBorder' },
                        { '─', 'FloatBorder' },
                        { '╮', 'FloatBorder' },
                        { '│', 'FloatBorder' },
                        { '╯', 'FloatBorder' },
                        { '─', 'FloatBorder' },
                        { '╰', 'FloatBorder' },
                        { '│', 'FloatBorder' },
                    },
                })
                vim.api.nvim_win_set_option(win, 'winhighlight', 'NormalFloat:Normal')
                return result, win, buf
            end
        },
    })

    local use = packer.use
    packer.reset()
    use({ "wbthomason/packer.nvim", opt = true })

    local plugins = require("plugins")
    for repo, config in pairs(plugins) do
        use(vim.tbl_extend('force', { repo }, config))
    end

    if packer_bootstrap then
        vim.notify("Sync packer...")
        packer.sync()

        utils.create_oneshot_autocmd('PackerComplete', function()
            vim.notify("Complile Packer...")
            packer.compile()
            utils.create_oneshot_autocmd('PackerCompileDone', function()
                vim.notify("Load Packer...")
                require_compiled_packer()
            end)
        end)
    end

end

local _packer = setmetatable({}, {
    __index = function(_, key)
        if not packer then
            init_packer()
        end
        return packer[key]
    end
})

local function init()
    if packer_bootstrap then -- 第一次装 packer 要初始化
        init_packer()
    elseif vim.fn.filereadable(packer_compiled) == 0 then -- 未编译
        packer_bootstrap = true -- 触发 packer.sync
        init_packer()
    else
        require_compiled_packer()
    end

    vim.api.nvim_create_user_command("PackerCompile", function()
        _packer.compile()
        vim.notify('Packer compiled success!', vim.log.levels.INFO, { title = "Packer" })
    end, {})
    vim.api.nvim_create_user_command("PackerInstall", function()
        _packer.install();
    end, {})
    vim.api.nvim_create_user_command("PackerUpdate", function() _packer.update() end, {})
    vim.api.nvim_create_user_command("PackerSync", function() _packer.sync() end, {})
    vim.api.nvim_create_user_command("PackerClean", function() _packer.clean() end, {})
    vim.api.nvim_create_user_command("PackerStatus", function() _packer.status() end, {})
    vim.api.nvim_create_user_command("PackerProfile", function() _packer.profile_output() end, {})
end

init()
