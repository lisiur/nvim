local vars = {}
local os_name = vim.loop.os_uname().sysname

vars.is_mac = os_name == "Darwin"
vars.is_linux = os_name == "Linux"
vars.is_windows = os_name == "Windows_NT"

vars.path_sep = vars.is_windows and "\\" or "/"
vars.home_dir = vars.is_windows and os.getenv("USERPROFILE") or os.getenv("HOME")

vars.config_dir = vim.fn.stdpath("config") .. vars.path_sep
vars.data_dir = string.format("%s/site", vim.fn.stdpath("data")) .. vars.path_sep
vars.cache_dir = vars.home_dir .. vars.path_sep .. ".cache" .. vars.path_sep .. "nvim" .. vars.path_sep

return vars
