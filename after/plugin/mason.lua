require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'omnisharp' },
  automatic_enable = {
    exclude = { 'csharp_ls' }
  },
})

