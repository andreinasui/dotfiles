return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lua",
    "saadparwaiz1/cmp_luasnip",
    "lukas-reineke/cmp-under-comparator",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "https://github.com/tzachar/cmp-fuzzy-path",
    { "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
    { "https://github.com/tzachar/fuzzy.nvim", dependencies = "nvim-telescope/telescope-fzf-native.nvim" },
  },
  event = "InsertEnter",
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    luasnip.filetype_extend("javascript", { "javascriptreact" })
    luasnip.config.set_config({
      -- This tells LuaSnip to remember to keep around the last snippet.
      -- You can jump back into it even if you move outside of the selection
      history = false,

      -- This one is cool cause if ou have dynamic snippets, it updates as you type!
      updateevents = "TextChanged,TextChangedI",
      region_check_events = "InsertEnter",
      delete_check_events = "InsertLeave",
    })
    local lspkind = require("lspkind")
    require("luasnip.loaders.from_vscode").lazy_load()
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      formatting = {
        -- format = function(entry, vim_item)
        --   -- fancy icons and a name
        --   vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
        --   local source_name = entry.source.name
        --   -- set a name for each source
        --   vim_item.menu = ({
        --     buffer = "[buf]",
        --     nvim_lsp = "[LSP]",
        --     nvim_lua = "[api]",
        --     path = "[path]",
        --     luasnip = "[snip]",
        --   })[source_name]

        --   -- remove duplicate suggestions from LSP and snip plugins
        --   vim_item.dup = ({
        --     nvim_lsp = 0,
        --     luasnip = 0,
        --   })[source_name] or 0
        --   return vim_item
        -- end,
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping.confirm({
          behaviour = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
        ["<M-n>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<M-p>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        {
          name = "nvim_lsp",
          priority = 8,
          -- entry_filter = function(entry, ctx)
          --   if entry:get_kind() == cmp.lsp.CompletionItemKind.File then
          --     return false
          --   end
          --   if entry:get_kind() == cmp.lsp.CompletionItemKind.Folder then
          --     return false
          --   end
          --   return true
          -- end,
        },
        { name = "buffer", keyword_length = 3, priority = 7 },
        { name = "nvim_lua", priority = 6 },
        { name = "fuzzy_path", priority = 5 },
        -- { name = "path" },
        { name = "luasnip", max_item_count = 20, keyword_length = 3, priority = 3 },
        { name = "nvim_lsp_signature_help", priority = 3 },
      }),
      sorting = {
        comparators = {
          cmp.config.locality,
          cmp.config.recently_used,
          cmp.config.compare.score,
          cmp.config.compare.exact,
          cmp.config.compare.offset,
          require("cmp-under-comparator").under,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
    })
  end,
}
