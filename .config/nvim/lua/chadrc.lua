-- NvChad UI configuration: theme and Mason package list.
-- Structure must match https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@type ChadrcConfig
return {
  base46 = {
    theme = "onedark",
  },
  mason = {
    pkgs = {
      "css-lsp",
      "elixir-ls",
      "eslint-lsp",
      "html-lsp",
      "js-debug-adapter",
      "lua-language-server",
      "prettier",
      "rubocop",
      "ruby-ls",
      "stylua",
      "tailwindcss-language-server",
      "typescript-language-server",
    },
  },
}
