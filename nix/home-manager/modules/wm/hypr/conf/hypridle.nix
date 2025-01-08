{
	services.hypridle = {
		enable = true;

		settings = 
		let 
			lock_cmd = "pidof ~/.config/hypr/scripts/setup_hyprlock.sh || ~/.config/hypr/scripts/setup_hyprlock.sh";
			suspend_cmd = "pidof steam || systemctl suspend || loginctl suspend";
		in {
			general = {
				lock_cmd = lock_cmd;
				before_sleep_cmd = "loginctl lock-session";
			};

			listener = [
				{
					timeout = 600; # 10mins
					on-timeout = "loginctl lock-session";
				}
				{
					timeout = 1000; # 20mins
					on-timeout = "hyprctl dispatch dpms off";
					on-resume = "hyprctl dispatch dpms on";
				}
				{
					timeout = 1800; # 30mins
					on-timeout = suspend_cmd;
				}
			];
		};
	};
}
