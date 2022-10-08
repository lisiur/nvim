local M = {}

-------------------------------

local create_autocmd_index = 0
function M.create_autocmd(pattern, callback, oneshot)
    create_autocmd_index = create_autocmd_index + 1
    local group = "_user_autocmd_" .. create_autocmd_index
    local id = vim.api.nvim_create_augroup(group, { clear = true })
    vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = pattern,
        callback = function()
            callback()
            if oneshot then
                vim.api.nvim_create_augroup(group, { clear = true })
            end
        end,
    })
    return id
end

function M.create_oneshot_autocmd(pattern, callback)
    return M.create_autocmd(pattern, callback, true)
end

-------------------------------------

function M.set_keymap(mode, key, cmd, desc, opt)
    if not desc then
        desc = cmd
    end
    if not opt then
        opt = {}
    end
    opt.desc = desc
    vim.keymap.set(mode, key, cmd, opt)
end

function M.set_keymap_cmd(mode, key, cmd, desc, opt)
    cmd = "<cmd>" .. cmd .. "<cr>"
    M.set_keymap(mode, key, cmd, desc, opt)
end

function M.set_keymap_prefix(mode, prefix)
    return {
        raw = function(key, cmd, desc, opt)
            key = prefix .. key
            M.set_keymap(mode, key, cmd, desc, opt)
        end,
        cmd = function(key, cmd, desc, opt)
            key = prefix .. key
            M.set_keymap_cmd(mode, key, cmd, desc, opt)
        end,
        vscode_call = function(key, cmd, desc, opt)
            cmd = "call VSCodeCall(\"" .. cmd .. "\")"
            M.set_keymap_cmd(mode, key, cmd, desc, opt)
        end
    }
end

---------------------------------------

function M.set_term_keymap(mode, name, start_cmd)
    local key = '<A-' .. name .. '>'
    local cmd = nil
    if start_cmd then
        cmd = string.format('<cmd>lua require("core.commands.toggleterm").toggle_%s("%s", "%s")<cr>', mode, name,
            start_cmd)
    else
        cmd = string.format('<cmd>lua require("core.commands.toggleterm").toggle_%s("%s")<cr>', mode, name)
    end
    M.set_keymap('n', key, cmd)
    M.set_keymap('i', key, cmd)
    M.set_keymap('t', key, cmd)
end

function M.set_float_term_keymap(name, start_cmd)
    M.set_term_keymap('float', name, start_cmd)
end

function M.set_vertical_term_keymap(name, start_cmd)
    M.set_term_keymap('vertical', name, start_cmd)
end

function M.set_horizontal_term_keymap(name, start_cmd)
    M.set_term_keymap('horizontal', name, start_cmd)
end

-----------------------------------------

return M
