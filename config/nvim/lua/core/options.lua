local opt = vim.opt

-- Numeros de linea
opt.number         = true
opt.relativenumber = false

-- Comportamiento general
opt.mouse          = "a"
opt.showmode       = false
opt.clipboard      = ""  -- p/yank use nvim internal register; Ctrl+C copies to system, Ctrl+V pastes from system
opt.confirm        = true
opt.undofile       = true
opt.updatetime     = 250
opt.timeoutlen     = 300

-- Busqueda
opt.ignorecase     = true
opt.smartcase      = true
opt.incsearch      = true
opt.hlsearch       = true
opt.inccommand     = "split"

-- Indentacion
opt.autoindent     = true
opt.tabstop        = 4
opt.shiftwidth     = 4
opt.expandtab      = true
opt.breakindent    = true

-- Apariencia
opt.termguicolors  = true
opt.cursorline     = true
opt.signcolumn     = "yes"
opt.scrolloff      = 10
opt.wrap           = false
opt.list           = true
opt.listchars      = { tab = "» ", trail = "·", nbsp = "␣" }
opt.laststatus     = 3
opt.cmdheight      = 1
opt.splitright     = true
opt.splitbelow     = true

vim.g.have_nerd_font = true

-- Kitty keyboard protocol: permite distinguir Ctrl+Enter de Enter normal
-- Requiere terminal compatible: kitty, wezterm, alacritty, ghostty
if vim.fn.has("nvim-0.10") == 1 then
    vim.o.exrc = false  -- no carga .nvimrc local por seguridad
end
