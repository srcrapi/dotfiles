{
	wayland.windowManager.hyprland.settings = {
		#############
		# Variables #
		#############

		"$mainMod" = "SUPER";

		# Apps

		"$term" = "kitty";
		"$browser" = "zen";
		"$musicPlayer" = "spotify";
		"$file" = "nautilus";

		# Scripts

		"$lock" = "$scrPath/setup_hyprlock.sh";
		"$colorPicker" = "$scrPath/color_picker.sh";
		"$powerMenu" = "pkill -x wlogout || wlogout";
		"$keyboard" = "$scrPath/keyboard-switch.sh";
		"$recordScreen" = "$scrPath/recorder.sh";
		"$reloadDesktop" = "$scrPath/reload.nix";
		"$screenshot" = "$scrPath/screenshot.sh";
		"$volume" = "$scrPath/volume.sh";
		"$brightness" = "$scrPath/brightness.sh";
		"$rofiLauncher" = "$scrPath/rofi_launcher.sh";


		bind = [
			# Main
			"$mainMod, Q, killactive"
			"$mainMod, M, exit"
			"$mainMod, W, togglefloating"
			"$mainMod, J, togglesplit"
			"Alt, Return, fullscreen"

			# Apps
			"$mainMod, T, exec, $term"
			"$mainMod, F, exec, $browser"
			"$mainMod, E, exec, $file"
			"$mainMod, S, exec, $musicPlayer"
			"$mainMod, V, exec, vesktop"

			# Scripts
			## Print
			"$mainMod+Ctrl, P, exec, $screenshot p"
			"$mainMod, P, exec, $screenshot s"
			", Print, exec, $screenshot m"

			## PowerMenu
			"$mainMod, Backspace, exec, $powerMenu"
			"$mainMod, L, exec, $lock"

			## Keyboard
			"$mainMod, K, exec, $keyboard"

			## Reload Desktop
			"$mainMod, R, exec, nix-shell $reloadDesktop"

			## Rofi
			"$mainMod, D, exec, $rofiLauncher -d"
			"$mainMod+Shift, W, exec, $rofiLauncher -wall"
			"$mainMod+Shift, P, exec, $rofiLauncher -p"
			"$mainMod, Tab, exec, $rofiLauncher -w"
			"$mainMod+Shift, E, exec, $rofiLauncher -f"
			"$mainMod, B, exec, $rofiLauncher -b"
			"$mainMod+Shift, B, exec, $rofiLauncher -bs"

			## Record
			"$mainMod+Shift, R, exec, $recordScreen -sd"
			"$mainMod+Ctrl+Shift, R, exec, $recordScreen -sm"
			"$mainMod+Ctrl, R, exec, $recordScreen --start-no-audio"
			"$mainMod+Ctrl, E, exec, $recordScreen --stop"

			## Color Picker
			"$mainMod+Shift, C, exec, $colorPicker"

			# Hyprland Workspaces, Windows focus
			## Move focus with mainMod + arrow keys
			"$mainMod, left, movefocus, l"
			"$mainMod, right, movefocus, r"
			"$mainMod, up, movefocus, u"
			"$mainMod, down, movefocus, d"

			"$mainMod, 1, workspace, 1" 
			"$mainMod, 2, workspace, 2" 
			"$mainMod, 3, workspace, 3" 
			"$mainMod, 4, workspace, 4" 
			"$mainMod, 5, workspace, 5" 
			"$mainMod, 6, workspace, 6" 
			"$mainMod, 7, workspace, 7" 
			"$mainMod, 8, workspace, 8" 
			"$mainMod, 9, workspace, 9" 
			"$mainMod, 0, workspace, 10" 

			## Move active window to a workspace with mainMod + SHIFT + [0-9]
			"$mainMod SHIFT, 1, movetoworkspace, 1"
			"$mainMod SHIFT, 2, movetoworkspace, 2"
			"$mainMod SHIFT, 3, movetoworkspace, 3"
			"$mainMod SHIFT, 4, movetoworkspace, 4"
			"$mainMod SHIFT, 5, movetoworkspace, 5"
			"$mainMod SHIFT, 6, movetoworkspace, 6"
			"$mainMod SHIFT, 7, movetoworkspace, 7"
			"$mainMod SHIFT, 8, movetoworkspace, 8"
			"$mainMod SHIFT, 9, movetoworkspace, 9"
			"$mainMod SHIFT, 0, movetoworkspace, 10"


			"$mainMod+Shift+Ctrl, Left, movewindow, l"
			"$mainMod+Shift+Ctrl, Right, movewindow, r"
			"$mainMod+Shift+Ctrl, Up, movewindow, u"
			"$mainMod+Shift+Ctrl, Down, movewindow, d"

			# "$mainMod, S, togglespecialworkspace, magic"
			# "$mainMod SHIFT, S, movetoworkspace, special:magic"

			"$mainMod, mouse_down, workspace, e+1"
			"$mainMod, mouse_up, workspace, e-1"
		];

		bindel = [
			# Volume
			", XF86AudioMute, exec, $volume t"
			", XF86AudioLowerVolume, exec, $volume d"
			", XF86AudioRaiseVolume, exec, $volume i"

			# brightness
			", XF86MonBrightnessUp, exec, $brightness -i"
			", XF86MonBrightnessDown, exec, $brightness -d"
		];

		bindl = [
			# media control
			", XF86AudioPlay, exec, playerctl play-pause" # toggle between media play and pause
			", XF86AudioPause, exec, playerctl play-pause" # toggle between media play and pause
			", XF86AudioNext, exec, playerctl next" # media next 
			", XF86AudioNext, exec, playerctl previous" # media previous
		];

		binde = [
			# resize windows
			"$mainMod+Shift, Right, resizeactive, 30 0"
			"$mainMod+Shift, Left, resizeactive, -30 0"
			"$mainMod+Shift, Up, resizeactive, 0 -30"
			"$mainMod+Shift, Down, resizeactive, 0 30"
		];

		bindm = [
			# Move/resize windows with mainMod + LMB/RMB and dragging
			"$mainMod, mouse:272, movewindow"
			"$mainMod, mouse:273, resizewindow"
		];
	};
}
