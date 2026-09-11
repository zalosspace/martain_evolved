return {
  "catppuccin/nvim",
  as = "catppuccin",
  config = function()
    require("catppuccin").setup({
      -- flavour = "latte",
      flavour = "frappe",
    })
    vim.cmd("colorscheme catppuccin")
  end,
}
