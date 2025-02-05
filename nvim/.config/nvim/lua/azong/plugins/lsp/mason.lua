return {
	{ -- Mason
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{ -- Mason lspconfig
		"williamboman/mason-lspconfig.nvim",
		dependencies = "williamboman/mason.nvim",
		lazy = true,
		opts = {
			ensure_installed = {
				"html",
				-- "ts_ls",
				"cssls",
				-- "jdtls",
				"sqlls",
				"jsonls",
				"eslint",
				"lua_ls",
				"clangd",
				"csharp_ls",
				"typos_lsp",
				"tailwindcss",
				"somesass_ls",
				"css_variables",
				"emmet_language_server",
			},
		},
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvimtools/none-ls.nvim", "williamboman/mason.nvim" },
		opts = {
			ensure_installed = { "stylua", "prettierd", "shfmt", "clang-format", "sql-formatter", "csharpier" },
		},
	},
}
