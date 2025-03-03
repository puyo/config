return {
  -- {
  --   "preservim/vim-pencil",
  --   init = function()
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = "markdown,mkd,norg",
  --       callback = function(_)
  --         require("lazy").load({ plugins = "vim-pencil" })
  --         vim.call("pencil#init", { wrap = "hard", autoformat = 1 })
  --         vim.bo.textwidth = 120
  --       end,
  --     })
  --   end,
  -- },

  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = function()
      require("orgmode").setup({
        org_agenda_files = "~/notes/**/*",
        org_default_notes_file = "~/notes/refile.org",
      })
    end,
  },

  {
    "rickhowe/wrapwidth",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown,mkd,norg,org",
        callback = function(_)
          require("lazy").load({ plugins = "wrapwidth" })
          vim.cmd([[
          setlocal wrap breakindent linebreak
          Wrapwidth 120
          ]])
        end,
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require("configs.conform")
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require("configs.lspconfig")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      config = function()
        -- https://www.josean.com/posts/nvim-treesitter-and-textobjects
        require("nvim-treesitter.configs").setup({
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

                ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
                ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

                ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
                ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

                ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
                ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

                ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
                ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

                ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
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
        })
      end,
    },
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
        "org",
        "ruby",
        "rust",
        "typescript",
        "vim",
        "vimdoc",
      },
    },
  },

  {
    "ahmedkhalf/project.nvim",
    lazy = false,
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

  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = false,
    opts = { useDefaultKeymaps = true },
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitlinker").setup({
        callbacks = {
          ["github.nearmap.com"] = require("gitlinker.hosts").get_github_type_url,
        },
      })
    end,
  },

  {
    "rebelot/kanagawa.nvim", -- neorg needs a colorscheme with treesitter support
    config = function()
      vim.cmd.colorscheme("kanagawa")
    end,
  },

  {
    "vhyrro/luarocks.nvim", -- used by neorg
    priority = 1000,
    config = true,
  },

  {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    version = "*",
    ft = { "norg" },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes",
              },
              default_workspace = "notes",
            },
          },
        },
      })
      vim.wo.foldlevel = 99
    end,
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "haydenmeade/neotest-jest",
      "folke/which-key.nvim",
    },
    opts = {
      adapters = {},
      status = { virtual_text = true },
      output = { open_on_run = true },
      quickfix = {
        open = function()
          vim.cmd("copen")
        end,
      },
    },
    config = function(_, opts)
      table.insert(
        opts.adapters,
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        })
      )

      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            if type(config) == "string" then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == "table" and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif meta and meta.__call then
                adapter(config)
              else
                error("Adapter " .. name .. " does not support setup")
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require("neotest").setup(opts)
    end,

    -- stylua: ignore
    keys = {
      --{ "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file" },
      --{ "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Test files in directory" },
      { "<leader>tL", function() require("neotest").run.run_last({ strategy = "dap" }) end, desc = "Last test (debug)" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Output panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
      { "<leader>ta", function() require("neotest").run.run_last() end, desc = "Again (last test)" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Output" },
      { "<leader>tr", function() require("neotest").run.run() end, desc = "Run" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Summary" },
      { "<leader>tw", "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>", desc = "Watch (Jest)" },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = false,
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        -- stylua: ignore
        keys = {
          { "<leader>du", function() require("dapui").toggle({ }) end, desc = "UI" },
          { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
          { "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Debug" },
        },
        opts = {},
        config = function(_, opts)
          -- setup dap config by VsCode launch.json file
          -- require("dap.ext.vscode").load_launchjs()
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end
        end,
      },
    },
    opts = function()
      local dap = require("dap")
      if not dap.adapters["pwa-node"] then
        require("dap").adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            -- 💀 Make sure to update this path to point to your installation
            args = {
              require("mason-registry").get_package("js-debug-adapter"):get_install_path()
                .. "/js-debug/src/dapDebugServer.js",
              "${port}",
            },
          },
        }
      end
      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        if not dap.configurations[language] then
          dap.configurations[language] = {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              cwd = "${workspaceFolder}",
            },
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
            },
          }
        end
      end
    end,
    -- stylua: ignore
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint with condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      --{ "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Cursor, run to" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down (next line)" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Last run again" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },
    config = function()
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
    end,
  },

  -- { "tadmccorkle/markdown.nvim", ft = "markdown" },

  { "godlygeek/tabular", lazy = false },

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

  { "echasnovski/mini.nvim", version = false },

  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
    },
    opts = {
      daily_notes = { folder = "Daily" },
      disable_frontmatter = true,
      workspaces = {
        {
          name = "no-vault",
          path = function()
            return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
          end,
          overrides = {
            notes_subdir = vim.NIL,
            new_notes_location = "current_dir",
            templates = { folder = vim.NIL },
            disable_frontmatter = true,
          },
        },
      },
    },
  },

  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { -- Example mapping to toggle outline
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      -- Your setup opts here
    },
  },

  {
    "hrsh7th/nvim-cmp",
    opts = {
      enabled = function()
        -- ~= is not equal in lua
        return (vim.bo.ft ~= "markdown")
      end,
    },
  },
}
