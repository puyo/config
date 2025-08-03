return {
  -- Format on save
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("configs.conform")
    end,
  },

  -- Language server protocols (LSP)
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require("configs.lspconfig")
    end,
  },

  -- Syntax highlighting and indent
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
    opts = {
      highlight = {
        enable = true,
      },

      ensure_installed = {
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
      },

      -- https://www.josean.com/posts/nvim-treesitter-and-textobjects
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
            ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },

            ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
            ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

            ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
            ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

            ["ac"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
            ["ic"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

            ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
            ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

            ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
            ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

            ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
            ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
            ["<leader>nm"] = "@function.outer", -- swap function with next
          },
          swap_previous = {
            ["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
            ["<leader>pm"] = "@function.outer", -- swap function with previous
          },
        },
      },
    },
  },

  -- Automatically change to root directory of projects
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("nvim-tree").setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
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

  -- Brackets and quotes (surrounds)
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- Open github.com and similar websites for the current file
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

  -- Align things like markdown table syntax
  {
    "shirosaki/tabular",
    branch = "fix_leading_spaces", -- https://github.com/godlygeek/tabular/issues/76
    event = "VeryLazy",
    config = function()
      -- Indent table when typing pipe symbols
      -- http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
      -- vim.cmd([[
      --   inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
      --
      --   function! s:align()
      --     let p = '^\s*|\s.*\s|\s*$'
      --     if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
      --       let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
      --       let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
      --       Tabularize/|/l1
      --       normal! 0
      --       call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
      --     endif
      --   endfunction
      -- ]])
    end,
  },

  -- GraphQL
  {
    "jparise/vim-graphql",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "graphql",
        callback = function(_)
          require("lazy").load({ plugins = "vim-graphql" })
        end,
      })
    end,
  },

  -- Disable nvim completion in markdown files
  {
    "hrsh7th/nvim-cmp",
    opts = {
      enabled = function()
        -- ~= is != in lua
        return (vim.bo.ft ~= "markdown")
      end,
    },
  },

  {
    "chrisgrieser/nvim-various-textobjs",
    event = "VeryLazy",
    opts = {
      keymaps = {
        useDefaults = true,
      },
    },
  },

  -- Disable indent indicators
  { "lukas-reineke/indent-blankline.nvim", enabled = false },

  -- Stop inserting closing brackets and quotes in the wrong places
  { "nvim-autopairs", enabled = false },
}
