vim.g.mapleader      = " "
vim.g.maplocalleader = " "

require("core.options")
require("core.autocmds")
require("keymaps.base")
require("keymaps.search")
require("keymaps.runner")
require("core.lazy")
