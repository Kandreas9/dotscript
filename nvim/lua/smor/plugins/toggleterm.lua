return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-t>]],
      hide_numbers = true,
      direction = 'float'
    })
  end
}
