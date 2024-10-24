local nvlsp = require("nvchad.configs.lspconfig")
local on_attach = nvlsp.on_attach
local on_init = nvlsp.on_init
local capabilities = nvlsp.capabilities
local lspconfig = require("lspconfig")

-- :help lspconfig-all for a list of servers

local servers = {
  "cssls",
  "eslint",
  "html",
  "marksman",
  "rubocop",
  "ruby_lsp",
  "tailwindcss",
  "ts_ls",
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

lspconfig.tailwindcss.setup({
  filetypes = { "html", "elixir", "eelixir", "heex" },
  init_options = {
    userLanguages = {
      elixir = "html-eex",
      eelixir = "html-eex",
      heex = "html-eex",
    },
  },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          'class[:]\\s*"([^"]*)"',
        },
      },
    },
  },
})
