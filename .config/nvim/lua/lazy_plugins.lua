-- Plugin specifications for lazy.nvim.
-- Each entry is a plugin with its config. Plugins load lazily unless specified.

return {
  ---------------------------------------------------------------------------
  -- Formatting
  ---------------------------------------------------------------------------

  -- Format on save (prettier for web, stylua for lua, etc.)
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        css = { "prettier" },
        html = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        nix = { "alejandra" },
      },
      format_on_save = {
        timeout_ms = 2000,
        lsp_format = "fallback",
      },
    },
  },

  ---------------------------------------------------------------------------
  -- LSP
  ---------------------------------------------------------------------------

  -- Auto-install LSP servers via Mason
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "cssls",
        "elixirls",
        "eslint",
        "html",
        "lua_ls",
        "tailwindcss",
        "ts_ls",
      },
    },
  },

  -- LSP server configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require("lsp")
    end,
  },

  ---------------------------------------------------------------------------
  -- Navigation
  ---------------------------------------------------------------------------

  -- Fuzzy finder: files, buffers, grep
  {
    "telescope.nvim",
    config = function()
      require("telescope").setup({
        defaults = {
          layout_config = { width = 0.99, height = 0.5, anchor = "S" },
          layout_strategy = "vertical",
          sorting_strategy = "ascending",
          mappings = {
            -- Close instantly on Esc (skip telescope's normal mode)
            i = { ["<esc>"] = require("telescope.actions").close },
          },
        },
      })
    end,
  },

  -- Auto-detect project root and chdir
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("nvim-tree").setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = { enable = true, update_root = true },
      })
      require("project_nvim").setup({
        manual = false,
        detection_methods = { "pattern" },
        patterns = { ".git", "Gemfile", "package.json", "cargo.toml" },
        silent_chdir = true,
        show_hidden = true,
      })
    end,
  },

  ---------------------------------------------------------------------------
  -- Treesitter: syntax highlighting, indentation, text objects
  ---------------------------------------------------------------------------

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
    config = function()
      pcall(function()
        -- The new nvim-treesitter no longer supports ensure_installed/auto_install
        -- in opts. Install parsers explicitly here.
        local installed = require("nvim-treesitter").get_installed()
        local wanted = {
          "cpp",
          "css",
          "eex",
          "elixir",
          "erlang",
          "heex",
          "html",
          "lua",
          "markdown",
          "markdown_inline",
          "norg",
          "ruby",
          "rust",
          "typescript",
          "vim",
          "vimdoc",
        }
        local to_install = vim.tbl_filter(function(lang)
          return not vim.tbl_contains(installed, lang)
        end, wanted)
        if #to_install > 0 then
          require("nvim-treesitter").install(to_install)
        end

        -- https://www.josean.com/posts/nvim-treesitter-and-textobjects
        local ts_select = require("nvim-treesitter-textobjects.select")
        local ts_swap = require("nvim-treesitter-textobjects.swap")

        require("nvim-treesitter-textobjects").setup({
          select = { lookahead = true },
        })

        local select_maps = {
          ["a="] = { "@assignment.outer", "outer assignment" },
          ["i="] = { "@assignment.inner", "inner assignment" },
          ["l="] = { "@assignment.lhs", "assignment LHS" },
          ["r="] = { "@assignment.rhs", "assignment RHS" },
          ["aa"] = { "@parameter.outer", "outer parameter" },
          ["ia"] = { "@parameter.inner", "inner parameter" },
          ["ac"] = { "@conditional.outer", "outer conditional" },
          ["ic"] = { "@conditional.inner", "inner conditional" },
          ["al"] = { "@loop.outer", "outer loop" },
          ["il"] = { "@loop.inner", "inner loop" },
          ["af"] = { "@call.outer", "outer function call" },
          ["if"] = { "@call.inner", "inner function call" },
          ["am"] = { "@function.outer", "outer function def" },
          ["im"] = { "@function.inner", "inner function def" },
        }
        for key, val in pairs(select_maps) do
          vim.keymap.set({ "x", "o" }, key, function()
            ts_select.select_textobject(val[1])
          end, { desc = val[2] })
        end

        vim.keymap.set("n", "<leader>na", function()
          ts_swap.swap_next("@parameter.inner")
        end, { desc = "swap next parameter" })
        vim.keymap.set("n", "<leader>nm", function()
          ts_swap.swap_next("@function.outer")
        end, { desc = "swap next function" })
        vim.keymap.set("n", "<leader>pa", function()
          ts_swap.swap_previous("@parameter.inner")
        end, { desc = "swap prev parameter" })
        vim.keymap.set("n", "<leader>pm", function()
          ts_swap.swap_previous("@function.outer")
        end, { desc = "swap prev function" })
      end)
    end,
  },

  ---------------------------------------------------------------------------
  -- Editing
  ---------------------------------------------------------------------------

  -- Surround text with brackets, quotes, tags (cs, ds, ys)
  { "kylechui/nvim-surround", event = "VeryLazy", opts = {} },

  -- Align text columns with :Tabularize (e.g. markdown tables)
  {
    "shirosaki/tabular",
    branch = "fix_leading_spaces",
    event = "VeryLazy",
  },

  -- Additional text objects (subword, entire buffer, etc.)
  {
    "chrisgrieser/nvim-various-textobjs",
    event = "VeryLazy",
    opts = { keymaps = { useDefaults = true } },
  },

  ---------------------------------------------------------------------------
  -- Git
  ---------------------------------------------------------------------------

  -- Open current file on github.com with gB
  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
      require("gitlinker").setup({
        mappings = "gB",
        opts = {
          action_callback = require("gitlinker.actions").open_in_browser,
          add_current_line_on_normal_mode = false,
          print_url = false,
        },
        callbacks = {
          ["github.nearmap.com"] = require("gitlinker.hosts").get_github_type_url,
        },
      })
    end,
  },

  ---------------------------------------------------------------------------
  -- Language-specific
  ---------------------------------------------------------------------------

  -- GraphQL syntax highlighting
  { "jparise/vim-graphql", ft = "graphql" },

  ---------------------------------------------------------------------------
  -- Overrides: disable NvChad defaults that get in the way
  ---------------------------------------------------------------------------

  -- Disable nvim-cmp completion in markdown files
  {
    "hrsh7th/nvim-cmp",
    opts = {
      enabled = function()
        return vim.bo.ft ~= "markdown"
      end,
    },
  },

  -- Disable indent guide lines
  { "lukas-reineke/indent-blankline.nvim", enabled = false },

  -- Disable auto-inserting closing brackets and quotes
  { "nvim-autopairs", enabled = false },
}
