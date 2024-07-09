vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move up and down on visual
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Append line without moving cursor
vim.keymap.set("n", "J", "mzJ`z")

-- Cntrl-d and Cntrl-u to half page jump up or down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor centered on search term
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Delete to void and paste
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy to clipboard : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete to void
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Do not press Q
vim.keymap.set("n", "Q", "<nop>")

-- Edit current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make file to executable
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Source file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

