local vars = require('core.vars')

local options = {}

function options:new()
    local instance = {
        value = nil,
    }
    setmetatable(instance, self)
    self.__index = self
    return instance
end

function options:mac(arg)
    if vars.is_mac then
        self.value = arg
    end
    return self
end

function options:linux(arg)
    if vars.is_linux then
        self.value = arg
    end
    return self
end

function options:windows(arg)
    if vars.is_windows then
        self.value = arg
    end
    return self
end

local config = {}

config.colorscheme = "catppuccin"
config.catppuccin_flavour = "latte"
config.neovide_font = "FiraCode\\ Nerd\\ Font:h15"
config.python_host_prog = options:new():mac("/usr/bin/python"):linux("/usr/bin/python"):windows("python2").value
config.python3_host_prog = options:new():mac("/usr/local/bin/python3"):linux("/usr/local/bin/python3"):windows("python")
    .value
config.sqlite_clib_path = options:new():mac(""):linux(""):windows("C:\\Users\\lisiu\\.local\\bin\\sqlite3.dll").value

return config
