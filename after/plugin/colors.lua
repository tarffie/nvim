function ColorMyPencils(color)
  color = color or "rose-pine-moon"
  -- color = color or "tokyonight-night"
  -- color = color or "dogrun"
  -- color = color or "gruvbox-material"
  -- color = color or "moonfly"

  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

  -- Sign column (git signs, diagnostics, etc.)
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

  -- Fold column (if enabled)
  vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })

  -- Optional: fully clean column look
  vim.api.nvim_set_hl(0, "LineNrAbove", { bg = "none" })
  vim.api.nvim_set_hl(0, "LineNrBelow", { bg = "none" })
end

ColorMyPencils()
