return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "LspAttach",
	priority = 1000,
	config = function()
		require("tiny-inline-diagnostic").setup({
			-- "modern", "classic", "minimal", "powerline",
			-- "ghost", "simple", "nonerdfont", "amongus"
			preset = "ghost",

			hi = {
				error = "DiagnosticError",
				warn = "DiagnosticWarn",
				info = "DiagnosticInfo",
				hint = "DiagnosticHint",
				arrow = "NonText",
				background = "CursorLine",
				mixing_color = "None",
			},

			options = {
				show_source = false,
				use_icons_from_diagnostic = false,
				add_messages = true,
				throttle = 0,
				softwrap = 30,
				multiple_diag_under_cursor = false,
				multilines = {
					enabled = true,
					always_show = true,
				},
				show_all_diags_on_cursorline = false,
				enable_on_insert = true,
				enable_on_select = false,

				overflow = {
					-- Manage how diagnostic messages handle overflow
					-- Options:
					-- "wrap" - Split long messages into multiple lines
					-- "none" - Do not truncate messages
					-- "oneline" - Keep the message on a single line, even if it's long
					mode = "wrap",
				},
				break_line = {
					enabled = false,
					after = 30,
				},
				format = function(diagnostic)
					return diagnostic.message .. " [" .. diagnostic.source .. "]"
				end,
				virt_texts = {
					priority = 2048,
				},
				severity = {
					vim.diagnostic.severity.ERROR,
					vim.diagnostic.severity.WARN,
					vim.diagnostic.severity.INFO,
					vim.diagnostic.severity.HINT,
				},
				overwrite_events = nil,
			},
		})
	end,
}
