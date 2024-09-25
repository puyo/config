-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "onedark",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

M.mason.pkgs = {
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
}

return M
