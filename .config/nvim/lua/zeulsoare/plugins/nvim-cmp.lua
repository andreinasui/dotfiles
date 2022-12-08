vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- load friendly-snippets
require("luasnip/loaders/from_vscode").lazy_load()

local ok_cmp, cmp = pcall(require, "cmp")
if not ok_cmp then
	return
end

local ok_luasnip, luasnip = pcall(require, "luasnip")
if not ok_luasnip then
	return
end

luasnip.filetype_extend("javascript", { "javascriptreact" })
luasnip.config.set_config({
	-- This tells LuaSnip to remember to keep around the last snippet.
	-- You can jump back into it even if you move outside of the selection
	history = true,

	-- This one is cool cause if ou have dynamic snippets, it updates as you type!
	updateevents = "TextChanged,TextChangedI",
})

local ok_lspkind, lspkind = pcall(require, "lspkind")
if not ok_lspkind then
	return
end

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	formatting = {
		format = function(entry, vim_item)
			-- fancy icons and a name
			vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
			local source_name = entry.source.name
			-- set a name for each source
			vim_item.menu = ({
				buffer = "[buf]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[api]",
				path = "[path]",
				luasnip = "[snip]",
			})[source_name]

			-- remove duplicate suggestions from LSP and snip plugins
			vim_item.dup = ({
				nvim_lsp = 0,
				luasnip = 0,
			})[source_name] or 0
			return vim_item
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
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
		["<C-n>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-p>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "path" },
		{
			name = "nvim_lsp",
			entry_filter = function(entry, ctx)
				if entry:get_kind() == cmp.lsp.CompletionItemKind.File then
					return false
				end
				if entry:get_kind() == cmp.lsp.CompletionItemKind.Folder then
					return false
				end
				return true
			end,
		},
		{ name = "buffer", priority = 0, keyword_length = 3 },
	}),
})
