return {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"rust-analyzer",
				"ruff",
				"prettier",
				"prettierd",
				"pylsp",
				"codelldb",
				"goimports",
				"gopls"
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			local lsps = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},

							completion = {
								callSnippet = "Replace",
							},

							runtime = {
								version = "LuaJIT",
							},

							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
							},

							telemetry = {
								enable = false,
							},
						},
					},
				},

				dartls = {
					cmd = { "dart", "language-server", "--protocol=lsp" },
				},

				vtsls = {
					settings = {
						typescript = {
							updateImportsOnFileMove = "prompt",
							preferences = {
								preferTypeOnlyAutoImports = true,
								useAliasesForRenames = false,
								renameShorthandProperties = false,
							},
						},
					},
				},

				clangd = {
					cmd = { "clangd", "--background-index", "--clang-tidy" },
				},
			}

			local border = {
				{ "╭", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╮", "FloatBorder" },
				{ "│", "FloatBorder" },
				{ "╯", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╰", "FloatBorder" },
				{ "│", "FloatBorder" },
			}

			local handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
			}

			require("mason").setup()
			require("mason-lspconfig").setup()
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					local server = lsps[server_name] or {}
					require("lspconfig")[server_name].setup({ server = server, handlers = handlers })
				end,
			})
		end,
	},
}
