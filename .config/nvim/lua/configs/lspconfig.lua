local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")

-- :help lspconfig-all for a list of servers

local servers = {
  "cssls",
  "html",
  "rubocop",
  "ruby_lsp",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
end

lspconfig.elixirls.setup({
  cmd = { vim.env.HOME .. "/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" },
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
})

lspconfig.eslint.setup({
  on_attach = function(client, buffer)
    on_attach(client, buffer)
    client.server_capabilities.documentFormattingProvider = true
  end,
  on_init = on_init,
  capabilities = capabilities,
})

lspconfig.tsserver.setup({
  on_attach = function(client, buffer)
    on_attach(client, buffer)
    client.server_capabilities.documentFormattingProvider = false
  end,
  on_init = on_init,
  capabilities = capabilities,
})
