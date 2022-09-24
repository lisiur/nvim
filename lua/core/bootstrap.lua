local packer = nil
local vars = require('core.vars')
local packer_compiled = vars.data_dir .. 'lua/packer_compiled.lua'

local remove_compiled = function()
    local fn = vim.fn
    if fn.empty(packer_compiled) == 0 then
        fn.system({ 'rm', packer_compiled })
    end
end

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()
local function init()
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
        packer.sync()
    end
end

if vim.fn.filereadable(packer_compiled) == 1 then
    require('packer_compiled')
else
    if ensure_packer then -- 新装的
        init()
    else -- 手动把 packer_compiled 删除了
        packer.compile()
        require('packer_compiled')
    end
end

local _packer = setmetatable({}, {
    __index = function(_, key)
        if not packer then
            init()
        end
        return packer[key]
    end
})

vim.api.nvim_create_user_command("PackerCompile", function()
    _packer.compile()
    vim.notify('Packer Compiled Success', vim.log.levels.INFO, { title = "Packer" })
end, {})
vim.api.nvim_create_user_command("PackerInstall", function()
    remove_compiled();
    _packer.install();
end, {})
vim.api.nvim_create_user_command("PackerUpdate", function() _packer.update() end, {})
vim.api.nvim_create_user_command("PackerSync", function() _packer.sync() end, {})
vim.api.nvim_create_user_command("PackerClean", function() _packer.clean() end, {})
vim.api.nvim_create_user_command("PackerStatus", function() _packer.status() end, {})
vim.api.nvim_create_user_command("PackerProfile", function() _packer.profile_output() end, {})
