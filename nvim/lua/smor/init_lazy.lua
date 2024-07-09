-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "smor.plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false },
  install = {
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "catppuccin-mocha" },
  },
  defaults = { lazy = false },
  change_detection = { notify = false },
  performance = {
    cache = {
      enabled = true,
    },
  },
})
