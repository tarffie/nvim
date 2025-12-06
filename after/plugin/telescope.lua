local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local fb = require "telescope".extensions.file_browser

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-c>"] = false,
        ["<M-d>"] = actions.delete_buffer,
      },
      n = {
        ["<M-d>"] = actions.delete_buffer,
        ["dd"] = actions.delete_buffer,
      },
    },
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          ["<C-c>"] = false,
        },
        n = {
          default = true,
          ["%"] = fb.actions.create
        },
      },
    },
  },
}


vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>xb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

require("telescope").load_extension "file_browser"
