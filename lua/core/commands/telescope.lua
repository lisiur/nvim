local root_dir = require("core.vars").root_dir

local M = {}

function M.find_files_under(path)
    local opts = {
        cwd = path,
        file_ignore_patterns = { ".git", "node_modules", "target" }
    }

    require('telescope.builtin').find_files(opts)
end

function M.search_under(path)
    local opts = {
        cwd = path,
        file_ignore_patterns = { ".git", "node_modules", "target" }
    }

    require('telescope.builtin').live_grep(opts)
end

function M.find_files_under_project()
    M.find_files_under(root_dir)
end

function M.search_under_project()
    M.search_under(root_dir)
end

return M
