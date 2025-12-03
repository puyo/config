require("nvchad.configs.lspconfig").defaults()

-- :help lspconfig-all for a list of servers

local servers = {
  "cssls",
  "elixirls",
  "eslint",
  "html",
  "rubocop",
  "ruby_lsp",
  "ts_ls",
}

vim.lsp.enable(servers)

vim.lsp.config("elixirls", {
  cmd = { vim.env.HOME .. "/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" },
})
