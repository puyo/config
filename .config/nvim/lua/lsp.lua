-- LSP server configuration and ElixirLS cache management.
--
-- Servers are enabled via vim.lsp.enable() and configured individually where
-- needed. ElixirLS gets special handling: when mix.lock is newer than the
-- .elixir_ls/build cache (e.g. after a git pull updates deps), the stale
-- cache is cleared and the server restarts automatically.

-- :help lspconfig-all for all available servers
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

-- ElixirLS needs a custom command name and explicit filetypes
vim.lsp.config("elixirls", {
  cmd = { "elixir-ls" },
  filetypes = { "elixir", "eelixir", "heex", "surface" },
  root_markers = { "mix.exs" },
})

---------------------------------------------------------------------------
-- ElixirLS stale cache detection
---------------------------------------------------------------------------

local function get_mtime(path)
  local stat = vim.uv.fs_stat(path)
  return stat and stat.mtime.sec or 0
end

local function check_and_refresh_elixir_ls()
  local root = vim.fs.root(0, "mix.exs")
  if not root then
    return
  end

  local lock_mtime = get_mtime(root .. "/mix.lock")
  local build_mtime = get_mtime(root .. "/.elixir_ls/build")

  if lock_mtime == 0 or build_mtime == 0 then
    return
  end
  if lock_mtime <= build_mtime then
    return
  end

  vim.notify(
    "mix.lock is newer than .elixir_ls/build — clearing stale cache and restarting ElixirLS",
    vim.log.levels.INFO
  )
  vim.fn.delete(root .. "/.elixir_ls/build", "rf")

  for _, client in ipairs(vim.lsp.get_clients({ name = "elixirls" })) do
    client:stop()
  end

  vim.defer_fn(function()
    vim.cmd("LspStart elixirls")
  end, 1000)
end

-- Trigger on focus gain (covers git pull in another terminal)
vim.api.nvim_create_autocmd("FocusGained", {
  desc = "Check if ElixirLS cache is stale",
  pattern = "*",
  callback = check_and_refresh_elixir_ls,
})

-- Trigger when mix.lock is written (covers mix deps.get in nvim terminal)
vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Check if ElixirLS cache is stale",
  pattern = "mix.lock",
  callback = check_and_refresh_elixir_ls,
})
