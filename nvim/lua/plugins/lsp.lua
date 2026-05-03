return {
  -- =====================
  -- MASON (LSP installer)
  -- =====================
  {
    "williamboman/mason.nvim",
    config = true,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "clangd",
        "ts_ls",
        "html",
        "cssls",
        "pyright",
        "bashls",
        "powershell_es",
        "lua_ls",
      },
    },
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

          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
          -- 🎨 Rose Pine Moon highlight fixes (matches Telescope)
          vim.api.nvim_set_hl(0, "CmpNormal", { bg = "NONE" })
          vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })
          vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#6e6a86", bg = "NONE" })
          vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#393552" }) -- subtle selection
      end,
  },


  -- =====================
  -- LSP CONFIG
  -- =====================
  {
    "neovim/nvim-lspconfig",

    config = function()
      -- 🔑 connect cmp with LSP
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- keymaps when LSP attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

          vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)

          vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "[d", function()
            vim.diagnostic.jump({ count = -1 })
          end, opts)
          vim.keymap.set("n", "]d", function()
            vim.diagnostic.jump({ count = 1 })
          end, opts)

          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

          vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
        end,
      })

      -- =====================
      -- SERVERS
      -- =====================
      local servers = {
        "clangd",
        "ts_ls",
        "html",
        "cssls",
        "pyright",
        "bashls",
        "powershell_es",
      }

      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
      end

      -- Lua (special config)
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

      -- enable everything
      vim.lsp.enable({
        "clangd",
        "ts_ls",
        "html",
        "cssls",
        "pyright",
        "bashls",
        "powershell_es",
        "lua_ls",
      })
    end,
  },
}
