require("nvchad.configs.lspconfig").defaults()

-- :help lspconfig-all for a list of servers

local servers = {
  "cssls",
  "elixirls",
  "eslint",
  "html",
  "rubocop",
  "ruby_lsp",
  "tailwindcss",
  "ts_ls",
}

vim.lsp.enable(servers)

vim.lsp.config("elixirls", {
  cmd = { vim.env.HOME .. "/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" },
})

vim.lsp.config("tailwindcss", {
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
