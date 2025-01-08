{ pkgs, ... }: {
	programs.tmux = {
		enable = true;
		shell = "${pkgs.fish}/bin/fish";
		keyMode = "vi";
		prefix = "C-a";
		baseIndex = 1;
		terminal = "tmux-256color";

		plugins = with pkgs; [
			{
				plugin = tmuxPlugins.resurrect;
				extraConfig = ''
				set -g @resurrect-strategy-nvim 'session'
				set -g @resurrect-capture-pane-contents 'on'
				'';
			}
			{
				plugin = tmuxPlugins.tokyo-night-tmux;
				extraConfig = ''
				set -g @tokyo-night-tmux_show_datetime 0
				set -g @tokyo-night-tmux_show_path 1
				set -g @tokyo-night-tmux_path_format relative
				set -g @tokyo-night-tmux_window_id_style dsquare
				set -g @tokyo-night-tmux_window_id_style dsquare
				set -g @tokyo-night-tmux_show_git 0
				'';
			}
			{
				plugin = tmuxPlugins.tmux-floax;
				extraConfig = ''
				set -g @floax-width '80%'
				set -g @floax-height '80%'
				set -g @floax-border-color 'magenta'
				set -g @floax-text-color 'blue'
				set -g @floax-bind 'p'
				set -g @floax-change-path 'true'
				'';
			}
		];

		extraConfig = ''
		bind h select-pane -L
		bind j select-pane -D
		bind k select-pane -U
		bind l select-pane -R
		'';
	};
}
