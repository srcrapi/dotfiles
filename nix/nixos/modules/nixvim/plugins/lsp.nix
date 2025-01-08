{
	programs.nixvim.plugins = {
		treesitter = {
			enable = true;

			nixvimInjections = true;
			indent = true;
		};

		hmts.enable = true;

		treesitter-refactor = {
			enable = true;

			highlightDefinitions = {
				enable = true;

				clearOnCursorMove = false;
			};
		};

		lsp = {
			enable = true;

      keymaps.lspBuf = {
        "<leader>lR" = "references";
        "<leader>lr" = "rename";
        "<leader>ld" = "hover";
        "<leader>lD" = "type_definition";
      };

			servers = {
				nil-ls.enable = true;
        html = {
          enable = true;

          settings = {
            format = {
              templating = true;
              wrapLineLength = true;
              wrapAttributes = "auto";
            };
            hover = {
              documentation = true;
              references = true;
            };
          };
        };
				cssls.enable = true;
				eslint.enable = true;
        pylsp.enable = true;
				nixd.enable = true;
        tsserver.enable = true;
			};
		};
	};
}
