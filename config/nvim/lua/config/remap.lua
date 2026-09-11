vim.g.mapleader = " "
local keymap = vim.keymap

local opts = { buffer = bufnr }
keymap.set("n", "gd", vim.lsp.buf.definition, opts)
keymap.set("n", "K", vim.lsp.buf.hover, opts)
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

-- File explorer
keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move selected lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centered
keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- Best paste ever
keymap.set("x", "<leader>p", "\"_dP")

-- Select All
keymap.set('n', '<C-a>', 'ggVG')

-- Clipboard yanks
keymap.set({ "n", "v" }, "<leader>y", "\"+y")
keymap.set("n", "<leader>Y", "\"+Y")

-- Delete without yanking
keymap.set({ "n", "v" }, "<leader>d", "\"_d")

-- Escape
keymap.set("i", "<C-c>", "<Esc>")

-- Disable Ex mode
keymap.set("n", "Q", "<nop>")

-- Format with LSP
keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format()
end)

-- Quickfix & loclist navigation
keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Search and replace word under cursor
keymap.set("n", "<leader>s",
  ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>"
)

-- Make file executable
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Rename word
vim.keymap.set("x", "<leader>r", function()
  -- yank visual selection
  vim.cmd('normal! "vy')
  -- open :s with the yanked word, whole-word bounded
  vim.cmd(':%s/\\<' .. vim.fn.getreg("v") .. '\\>/')
end, { desc = "Substitute visual selection" })

-- Increment next number in line
keymap.set("n", "<C-i>", function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col('.') - 1
  local s, e, num = line:find("%d+", col + 1)
  if s then
    local new_num = tostring(tonumber(num) + 1)
    local new_line = line:sub(1, s - 1) .. new_num .. line:sub(e + 1)
    vim.api.nvim_set_current_line(new_line)
  end
end, { desc = "Increment next number in line" })

-- Decrement next number in line
keymap.set("n", "<C-S-d>", function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col('.') - 1
  local s, e, num = line:find("%d+", col + 1)
  if s then
    local new_num = tostring(tonumber(num) - 1)
    local new_line = line:sub(1, s - 1) .. new_num .. line:sub(e + 1)
    vim.api.nvim_set_current_line(new_line)
  end
end, { desc = "Decrement next number in line" })
