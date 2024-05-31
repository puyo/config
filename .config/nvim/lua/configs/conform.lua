require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    ruby = { "rubocop" },
  },

  format_on_save = {
    timeout_ms = 3000,
    lsp_fallback = true,
  },
})
