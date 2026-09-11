vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.autoindent = true
vim.opt.smartindent = false
vim.opt.cindent = false

return {
    require("plugins.treesitter"),
    require("plugins.catppuccin"),
    require("plugins.autopairs"),
    require("plugins.telescope"),
    require("plugins.undotree"),
    require("plugins.fugitive"),
    require("plugins.harpoon"),
    require("plugins.lsp"),
}
