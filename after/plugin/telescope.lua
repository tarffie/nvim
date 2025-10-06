local actions = require('telescope.actions')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>xb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)


require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<M-d>"] = actions.delete_buffer,
      },
      n = {
        ["<M-d>"] = actions.delete_buffer,
        ["dd"] = actions.delete_buffer,
      },
    },
  },
}
