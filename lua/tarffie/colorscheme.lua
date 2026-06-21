-- Old configuration options used:
-- vim.cmd 'colorscheme gruvbox-material'
-- vim.cmd.colorscheme(vim.moonfly)
-- vim.g.moonflyCursorColor = true
-- vim.cmd.colorscheme(vim.dogrun)
-- vim.cmd.colorscheme(vim.tokyonight_night)
-- vim.cmd.colorscheme(vim.rose_pine_moon)
-- vim.cmd 'colorscheme rose-pine-moon'


require("rose-pine").setup({
  variant = 'moon',
  dark_variant = 'moon',
  dim_inactive_windows = false,
  extend_background_behind_borders = true,

  enable = {
    terminal = true,
    legacy_highlights = true,
    migrations = true,
  },

  styles = {
    bold = true,
    italic = true,
    transparency = false,
  },

  groups = {
    border = "muted",
    link = "iris",
    panel = "surface",

    error = "love",
    hint = "iris",
    info = "foam",
    note = "pine",
    todo = "rose",
    warn = "gold",

    git_add = "foam",
    git_change = "rose",
    git_delete = "love",
    git_dirty = "rose",
    git_ignore = "muted",
    git_merge = "iris",
    git_rename = "pine",
    git_stage = "iris",
    git_text = "rose",
    git_untracked = "subtle",

    h1 = "iris",
    h2 = "foam",
    h3 = "rose",
    h4 = "gold",
    h5 = "pine",
    h6 = "foam",
  },
})

vim.cmd("colorscheme rose-pine")

