-- Keymaps: leader groups, editor shortcuts, clipboard, navigation, and GUI.
-- All keymaps are in lua; no vimscript needed.

require("nvchad.mappings")

local map = vim.keymap.set

---------------------------------------------------------------------------
-- Which-key leader group labels
---------------------------------------------------------------------------

require("which-key").add({
  { "<leader>c", group = "code/current/cheatsheet/commits" },
  { "<leader>d", group = "debug" },
  { "<leader>f", group = "find/format/files" },
  { "<leader>g", group = "git" },
  { "<leader>l", group = "lsp" },
  { "<leader>m", group = "marks" },
  { "<leader>n", group = "next (swap)" },
  { "<leader>p", group = "preview/pick/prev (swap)" },
  { "<leader>r", group = "rename/reset/relative" },
  { "<leader>s", group = "signature" },
  { "<leader>t", group = "test" },
  { "<leader>w", group = "workspace/whichkey" },
  { "<leader>o", group = "org" },
})

---------------------------------------------------------------------------
-- Helpers
---------------------------------------------------------------------------

-- Directory of the current buffer, escaped for use in :e
local function current_buffer_dir()
  local name = vim.api.nvim_buf_get_name(0)
  return vim.fn.fnameescape(vim.fs.dirname(name))
end

-- Keep oldfiles up to date during the session so "Jump to last file" works
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local file = vim.fn.expand("%:p")
    if file == "" then return end
    local oldfiles = vim.v.oldfiles
    for i, f in ipairs(oldfiles) do
      if f == file then
        table.remove(oldfiles, i)
        break
      end
    end
    table.insert(oldfiles, 1, file)
  end,
})

-- Jump to the most recent file that isn't the current one
local function edit_last_file_expr()
  local current_file = vim.api.nvim_buf_get_name(0)
  for _, file in ipairs(vim.v.oldfiles) do
    local stat = vim.uv.fs_stat(file)
    if stat and stat.type == "file" and file ~= current_file then
      return ":e " .. file .. "<cr>"
    end
  end
  return ""
end

-- Adjust GUI font size by delta (for Neovide, VimR, etc.)
local function adjust_font_size(delta)
  local font = vim.o.guifont
  local name, size = font:match("^(.+:h)(%d+)$")
  if name and size then
    vim.o.guifont = name .. (tonumber(size) + delta)
  end
end

---------------------------------------------------------------------------
-- General
---------------------------------------------------------------------------

map("c", "<M-BS>", "<C-W>", { desc = "Delete back word" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("n", ";", ":", { desc = "Enter command mode" })

---------------------------------------------------------------------------
-- Cmd-key shortcuts (GUI: Neovide, VimR, etc.)
---------------------------------------------------------------------------

local tabufline = require("nvchad.tabufline")

-- Comment toggling
map({ "n", "v" }, "<D-/>", "gcc", { desc = "Toggle comment", remap = true })
map("i", "<D-/>", "<ESC>gcc", { desc = "Toggle comment", remap = true })

-- File navigation
map({ "n", "i", "v" }, "<D-b>", function()
  require("telescope.builtin").buffers()
end, { desc = "Browse buffers" })
map({ "n", "i", "v" }, "<D-o>", function()
  return ":e " .. current_buffer_dir() .. "/"
end, { desc = "Open file in buffer dir", expr = true })
map({ "n", "i", "v" }, "<D-p>", function()
  require("telescope.builtin").git_files()
end, { desc = "Browse project files" })
map({ "n", "i", "v" }, "<D-r>", function()
  require("telescope.builtin").oldfiles()
end, { desc = "Browse recent files" })

-- Buffer management
map({ "n", "i", "v" }, "<D-s>", "<cmd>w<cr>", { desc = "Save" })
map({ "n", "i", "v" }, "<D-w>", tabufline.close_buffer, { desc = "Close buffer" })
map({ "n", "i", "v" }, "<D-z>", "<cmd>undo<cr>", { desc = "Undo", silent = true })
map({ "n", "i", "v" }, "<S-D-{>", tabufline.prev, { desc = "Previous buffer" })
map({ "n", "i", "v" }, "<S-D-}>", tabufline.next, { desc = "Next buffer" })
map({ "n", "i", "v" }, "<S-D-[>", tabufline.prev, { desc = "Previous buffer" })
map({ "n", "i", "v" }, "<S-D-]>", tabufline.next, { desc = "Next buffer" })
map({ "n", "i", "v" }, "<D-[>", tabufline.prev, { desc = "Previous buffer" })
map({ "n", "i", "v" }, "<D-]>", tabufline.next, { desc = "Next buffer" })
map({ "n", "v" }, "<leader><tab>", edit_last_file_expr, { desc = "Jump to last file", expr = true, silent = true })

-- Select all
map("n", "<D-a>", "ggVG", { desc = "Select all" })
map({ "i", "v" }, "<D-a>", "<ESC>ggVG", { desc = "Select all" })

-- Font zoom
map("n", "<D-=>", function()
  adjust_font_size(1)
end, { desc = "Increase font size" })
map("n", "<D-->", function()
  adjust_font_size(-1)
end, { desc = "Decrease font size" })

---------------------------------------------------------------------------
-- Clipboard (system clipboard via Cmd shortcuts)
---------------------------------------------------------------------------

map("i", "<D-v>", '<ESC>"+pa', { desc = "Paste" })
map("n", "<D-v>", '"+P', { desc = "Paste" })
map("v", "<D-v>", '"+p', { desc = "Paste" })
map("v", "<D-c>", '"+ygv', { desc = "Copy" })
map("v", "<D-x>", '"+c', { desc = "Cut" })

---------------------------------------------------------------------------
-- Editing behaviour
---------------------------------------------------------------------------

-- Don't overwrite register when pasting in visual mode (allows repeated paste)
map("x", "p", "P", { desc = "Paste without yanking selection" })

-- Visual mode: s starts surround instead of substitute
map("v", "s", "S", { desc = "Surround selection", remap = true })

-- Keep selection after indenting
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Soft-wrap-aware movement (move by display line, not real line)
for _, key in ipairs({ "j", "k", "0", "^", "$" }) do
  map({ "n", "v" }, key, "g" .. key, { desc = "Soft-wrap " .. key })
end

-- Strip trailing whitespace (works on selection or whole file via :StripTrailingWhitespaces)
vim.api.nvim_create_user_command("StripTrailingWhitespaces", function(opts)
  vim.cmd(opts.line1 .. "," .. opts.line2 .. [[s/\s\+$//e]])
  vim.cmd([[normal! g`"]])
end, { range = "%" })

---------------------------------------------------------------------------
-- Fix NvChad defaults
---------------------------------------------------------------------------

-- NvChad maps <tab> which breaks <C-i> for jumplist navigation
vim.keymap.del("n", "<tab>")
