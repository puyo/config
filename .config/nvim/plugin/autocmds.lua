-- Autocmds: file reloading, directory creation, filetype detection/settings.

require("nvchad.autocmds")

---------------------------------------------------------------------------
-- File reloading
---------------------------------------------------------------------------

-- Reload files that changed on disk (e.g. after git pull)
-- https://unix.stackexchange.com/questions/149209
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  desc = "Check for file changes on disk",
  pattern = "*",
  command = "if mode() !~ '\\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif",
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  desc = "Notify when a file is reloaded from disk",
  pattern = "*",
  command = "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None",
})

---------------------------------------------------------------------------
-- Directory creation
---------------------------------------------------------------------------

-- Create parent directories automatically when saving a new file
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Auto-create missing parent directories on save",
  callback = function(args)
    local dir = vim.fs.dirname(args.file)
    if not args.file:match("^%w+://") and not vim.uv.fs_stat(dir) then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

---------------------------------------------------------------------------
-- LSP fixes
---------------------------------------------------------------------------

-- Fix gq wrapping in LSP-enabled buffers
-- https://vi.stackexchange.com/questions/39200
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Clear formatexpr so gq uses normal formatting",
  callback = function(args)
    vim.bo[args.buf].formatexpr = nil
  end,
})

---------------------------------------------------------------------------
-- Recent files tracking
---------------------------------------------------------------------------

-- Keep v:oldfiles up to date so <leader><tab> can switch to the last file
vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Move current file to top of v:oldfiles",
  callback = function()
    local file = vim.fn.expand("%:p")
    if file == "" then
      return
    end
    local oldfiles = vim.v.oldfiles
    for i, f in ipairs(oldfiles) do
      if f == file then
        table.remove(oldfiles, i)
        break
      end
    end
    table.insert(oldfiles, 1, file)
    vim.v.oldfiles = oldfiles
  end,
})

---------------------------------------------------------------------------
-- Filetype detection
---------------------------------------------------------------------------

-- Teach vim about file extensions it doesn't know
vim.filetype.add({
  extension = {
    rjs = "ruby",
    rbw = "ruby",
    gem = "ruby",
    gemspec = "ruby",
    ru = "ruby",
    ejs = "html",
    hamlc = "haml",
    as = "javascript",
    txt = "text",
  },
  filename = {
    ["Gemfile"] = "ruby",
    ["Guardfile"] = "ruby",
  },
  pattern = {
    [".*%.md%.erb"] = "markdown",
    [".*%.markdown%.liquid"] = "markdown",
    ["Dockerfile%..*"] = "dockerfile",
  },
})

---------------------------------------------------------------------------
-- Per-filetype settings
---------------------------------------------------------------------------

local ft = vim.api.nvim_create_augroup("filetype_settings", { clear = true })

local function on_filetype(pattern, callback)
  vim.api.nvim_create_autocmd("FileType", {
    group = ft,
    pattern = pattern,
    callback = callback,
  })
end

on_filetype("c", function()
  vim.opt_local.shiftwidth = 4
  vim.opt_local.softtabstop = 4
  vim.opt_local.makeprg = "make"
end)

on_filetype("ruby", function()
  vim.opt_local.makeprg = "rake"
  vim.opt_local.path:append("lib")
  vim.opt_local.textwidth = 78
  vim.opt_local.tabstop = 2
  vim.opt_local.expandtab = true
  vim.opt_local.shiftwidth = 2
  vim.opt_local.softtabstop = 2
  vim.b.surround_114 = "do\n\r\nend" -- surround with do..end (r key)
end)

on_filetype("eruby", function()
  vim.opt_local.makeprg = "rake"
end)

on_filetype("css", function()
  vim.opt_local.makeprg = "rake"
end)

on_filetype({ "text", "plaintex" }, function()
  vim.opt_local.wrap = true
  vim.opt_local.linebreak = true
  vim.opt_local.list = false
  vim.opt_local.textwidth = 0
  vim.opt_local.wrapmargin = 0
  vim.opt_local.spell = true
end)

on_filetype("python", function()
  vim.opt_local.expandtab = true
  vim.opt_local.tabstop = 4
  vim.opt_local.shiftwidth = 4
  vim.opt_local.softtabstop = 4
end)

on_filetype("markdown", function()
  vim.opt_local.conceallevel = 0
  vim.opt_local.iskeyword:remove("/")
  vim.opt_local.wrap = true
  vim.opt_local.linebreak = true
  vim.opt_local.list = false
  vim.opt_local.shiftwidth = 2
  vim.opt_local.textwidth = 0
  vim.opt_local.wrapmargin = 0
  vim.opt_local.spell = true
  vim.cmd("hi mkdCode guibg=NONE")
end)

on_filetype("slim", function()
  vim.opt_local.comments:append("b:'")
end)

on_filetype({ "coffee", "javascript", "typescript", "typescriptreact" }, function()
  vim.opt_local.tabstop = 2
  vim.opt_local.shiftwidth = 2
  vim.opt_local.softtabstop = 2
end)

on_filetype("json", function()
  vim.opt_local.wrap = false
  vim.opt_local.smartindent = true
end)
