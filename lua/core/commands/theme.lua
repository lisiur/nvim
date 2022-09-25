local M = {}

function M.change_theme()
    if vim.g.user_config.theme == "dark" then
        local user_config = vim.g.user_config
        user_config.theme = "light"
        vim.g.user_config = user_config

        vim.cmd("Catppuccin ".. user_config.prefer_light_theme)
    else
        local user_config = vim.g.user_config
        user_config.theme = "dark"
        vim.g.user_config = user_config

        vim.cmd("Catppuccin ".. user_config.prefer_dark_theme)
    end
end

return M
