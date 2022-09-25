local vars = require('core.vars')

local function option(opt)
    return vars.is_mac and opt.mac
    or vars.is_linux and opt.linux
    or vars.is_windows and opt.windows
end

return {
    neovide_font = "FiraCode\\ Nerd\\ Font:h15",
    python_host_prog = option({
        mac = "/usr/bin/python",
        linux = "/usr/bin/python",
        wndows = "python2",
    }),
    python3_host_prog = option({
        mac = "/usr/local/bin/python3",
        linux = "/usr/local/bin/python3",
        wndows = "python",
    }),
    sqlite_clib_path = option({
        windows = "C:\\Users\\lisiu\\.local\\bin\\sqlite3.dll"
    })
}
