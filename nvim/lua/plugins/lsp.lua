local servers = {
  "clangd",
  "ts_ls",
  "html",
  "cssls",
  "pyright",
  "bashls",
  "powershell_es",
  "lua_ls",
}

return {
  -- =====================
  -- MASON
  -- =====================
  {
    "williamboman/mason.nvim",
    config = true,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = servers,
      automatic_enable = true,
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end,
  },

  -- =====================
  -- AUTOCOMPLETION (CMP)
  -- =====================
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "windwp/nvim-autopairs",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            border = "rounded",
          }),
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),

        formatting = {
          fields = { "kind", "abbr", "menu" },
        },
      })

      local ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
      if ok then
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end

      vim.api.nvim_set_hl(0, "CmpNormal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#6e6a86", bg = "NONE" })
      vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#393552" })
    end,
  },

  -- =====================
  -- LSP CONFIG
  -- =====================
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.diagnostic.config({
        float = { border = "rounded" },
        severity_sort = true,
        update_in_insert = false,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }

          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
          end

          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "K", vim.lsp.buf.hover, "Hover docs")
          map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, "Workspace symbols")
          map("n", "<leader>vd", vim.diagnostic.open_float, "Line diagnostics")
          map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
          map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>gr", vim.lsp.buf.references, "References")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
          map("i", "<C-h>", vim.lsp.buf.signature_help, "Signature help")
        end,
      })

      for _, server in ipairs(servers) do
        if server ~= "lua_ls" then
          vim.lsp.config(server, {
            capabilities = capabilities,
          })
        end
      end

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- No manual vim.lsp.enable() here:
      -- mason-lspconfig auto-enables installed servers by default.
    end,
  },
}
