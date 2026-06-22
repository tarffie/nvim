vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  diagnostics = { globals = { 'vim' } },
  workspace = { checkThirdParty = false },
  telemetry = { enable = false },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.git' },
  settings = { Lua = { diagnostics = { globals = { "vim" } } } }
})

vim.lsp.config("roslyn", {
  settings = {
    ["csharp|inlay_hints"] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_implicit_variable_types = true
    },
    ["csharp|code_lens"] = {
      dotnet_enable_references_code_lens = false
    },
    ["csharp|background_analysis"] = {
      dotnet_analyzer_diagnostics_scope = "fullSolution"
    },
    ["csharp|completion"] = {
      dotnet_provide_regex_completions = true,
      dotnet_show_completion_items_from_unimported_namespaces = true,
      dotnet_show_name_completion_suggestions = true
    },
    ["csharp|symbol_search"] = {
      dotnet_search_reference_assemblies = true
    },
    ["csharp|formatting"] = {
      dotnet_organize_imports_on_format = true
    }
  }
})

vim.lsp.config('ts_ls', {
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true
      }
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true
      }
    }
  }
})

vim.lsp.enable({
  'lua_ls',
  'roslyn',
  'ts_ls',
  'jsonls'
})
