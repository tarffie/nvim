
local lsp = require('lsp-zero')
lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })

  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.preset('recommended')

-- ─── OmniSharp (C# — Unity) ───────────────────────────────────────────────────
lsp.configure('omnisharp', {
  cmd                 = {
    'dotnet',
    vim.fn.stdpath('data') .. '/mason/packages/omnisharp/libexec/OmniSharp.dll',
    '--languageserver',
    '--hostPID', tostring(vim.fn.getpid()),
  },
  filetypes           = { 'cs' },
  single_file_support = false,
  root_dir            = function(fname)
    return require('lspconfig.util').root_pattern(
      'Assets', 'ProjectSettings', '*.sln'
    )(fname) or vim.fn.getcwd()
  end,
  settings            = {
    FormattingOptions = {
      EnableEditorConfigSupport = true,
      OrganizeImports           = true,
    },
    RoslynExtensionsOptions = {
      EnableAnalyzersSupport   = false,
      EnableImportCompletion   = true,
      AnalyzeOpenDocumentsOnly = true,
    },
    MsBuild = {
      UseLegacySdkResolver = true,
    },
  },
})

-- ─── BSD-specific servers ─────────────────────────────────────────────────────
local osname = GetOS()
if osname == "BSD" then
  local user   = os.getenv("USER")  -- no '$' prefix in os.getenv
  local clangd = "/usr/local/bin/clangd20"
  local lua_ls = "/home/" .. user .. "/.local/bin/lua-language-server"

  lsp.configure('clangd', {
    cmd                 = {
      clangd,
      "--background-index",
      "--header-insertion=never",
      "--clang-tidy",
      "--offset-encoding=utf-16",
    },
    filetypes           = { "c", "cpp", "objc", "objcpp" },
    single_file_support = true,
    root_dir            = function(fname)
      return require('lspconfig.util').root_pattern(
        'compile_commands.json', 'compile_flags.txt', '.git'
      )(fname) or vim.fn.getcwd()
    end,
  })

  lsp.configure('lua_ls', {
    cmd = { lua_ls },
    settings = {
      Lua = {
        runtime     = { version = 'LuaJIT' },
        diagnostics = { globals = { 'vim' } },
        workspace   = {
          library         = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry   = { enable = false },
      },
    },
  })
end

-- ─── Completion (nvim-cmp) ────────────────────────────────────────────────────
local cmp     = require('cmp')
local cmp_sel = { behavior = cmp.SelectBehavior.Select }

lsp.setup_nvim_cmp({
  mapping = lsp.defaults.cmp_mappings({
    ['<C-p>']     = cmp.mapping.select_prev_item(cmp_sel),
    ['<C-n>']     = cmp.mapping.select_next_item(cmp_sel),
    ['<C-y>']     = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
})

-- ─── Preferences & diagnostics ───────────────────────────────────────────────
lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn  = 'W',
    hint  = 'H',
    info  = 'I',
  },
})

vim.diagnostic.config({
  virtual_text  = true,
  severity_sort = true,
  float         = {
    style  = 'minimal',
    border = 'rounded',
    source = true,
    header = '',
    prefix = '',
  },
})

lsp.setup()
