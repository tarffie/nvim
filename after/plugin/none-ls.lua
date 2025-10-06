local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  return
end

local null_ls_ok, null_ls = pcall(require, "none-ls")
if not null_ls_ok then
  return
end

mason.setup()

local mason_tool_installer_ok, mason_tool_installer = 
  pcall(require, "mason-tool-installer")

if mason_tool_installer_ok then
  mason_tool_installer.setup({
    ensure_installed = {
      "ocamlformat",
    },
  })
end

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.ocamlformat.with({
      extra_args = { "--if-then-else", "vertical" },
    }),
  },
})
