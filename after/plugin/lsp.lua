local lsp = require('lsp-zero')
lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)
lsp.preset('recommended')

-- Get the lspconfig module directly
local lspconfig = require('lspconfig')

-- Configure lua_ls using lsp-zero's method
lsp.configure('lua_ls', {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

local clangd_path = "/usr/local/bin/clangd20"  

-- Configure clangd using lsp-zero's method
lsp.configure('clangd', {
  cmd = {
    clangd_path,
    "--background-index",
    "--header-insertion=never",
    "--clang-tidy",
    "--offset-encoding=utf-16",  -- Important for Neovim compatibility
  },
  filetypes = {"c", "cpp", "objc", "objcpp"},
  root_dir = function(fname)
    return lspconfig.util.root_pattern(
      'compile_commands.json',
      'compile_flags.txt',
      '.git'
    )(fname) or vim.fn.getcwd()
  end,
  single_file_support = true,
})

-- Your cmp configuration (this part was correct)
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ['<C-Space>'] = cmp.mapping.complete(),
})

-- Your keymaps configuration (this part was correct but redundant)
-- Note: lsp.default_keymaps() already sets most of these, so you might not need this
lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = {
    style = 'minimal',
    border = 'square',
    source = true,
    header = '',
    prefix = '',
  },
})

lsp.setup()
