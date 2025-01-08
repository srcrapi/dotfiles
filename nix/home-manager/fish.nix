{
	programs.fish = {
		enable = true;

		shellAliases =
		let
			flakePath = "~/nix";
			general_scripts_path = "~/.local/bin";
		in {
			rebuild = "sudo nixos-rebuild switch --flake ${flakePath}";
			upd = "nix flake update ${flakePath}";
			upg = "sudo nixos-rebuild switch --upgrade --flake ${flakePath}";
			hms = "home-manager switch --flake ${flakePath}";

			conf = "nvim ~/nix/nixos/configuration.nix";
			pkgs = "nvim ~/nix/nixos/packages.nix";
			hypr = "nvim ~/nix/home-manager/modules/wm/hypr/default.nix";


			l = "eza -lh --icons=auto"; # long list
			lg = "eza -lh --icons=auto --grid"; # long list grid
			ls = "eza -1 --icons=auto"; # short list
			ll = "eza -lha --icons=auto --group-directories-first";
			llg = "eza -lha --icons=auto --group-directories-first --grid"; # long list all grid
			ld = "eza -lhD --icons=auto"; # long list only dirs 

			# kitty
			icat = "kitten icat";

			# apps
			vim = "nvim";
			cat = "bat";
			ff = "fastfetch";
			fzf = "fzf --preview='bat --color=always {}' --border=rounded";
			vfzf = "nvim $(fzf --preview='bat --color=always {}' --border=rounded)";
			rq = "python3 ${general_scripts_path}/random_quotes.py";

			# obsidian
			on = "python3 ${general_scripts_path}/obsidian.py -n";
			os = "python3 ${general_scripts_path}/obsidian.py -s";
			op = "python3 ${general_scripts_path}/obsidian.py -p";
		};

		shellInit = ''
		set -x GIT_EMAIL (pass github/email)
		set -x BROTHER_PC (pass ip/rovier)
		set -x MY_IP (pass ip/rap1)
		set -g fish_key_bindings fish_vi_key_bindings

		fastfetch
		zoxide init --cmd cd fish | source
		'';

	};
}
