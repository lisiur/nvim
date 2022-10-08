if vim.g.vscode then
    require("config")
    require("core.basic")
    require("core.keymap")
else
    require("core")
end
