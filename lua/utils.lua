local M = {}

local create_autocmd_index = 0
function M.create_autocmd(pattern, callback, oneshot)
    create_autocmd_index = create_autocmd_index + 1
    local group = "_user_autocmd_"..create_autocmd_index
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


return M
