{
  imports = [
	./variables.nix
	./conf/keybindings.nix
	./conf/window_rules.nix
	#./conf/hypridle.nix
	#./conf/hyprlock.nix
	./conf/animations.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      monitor = ",preferred,auto,1";

      exec-once = [
        "waybar &"
        "swaync"
        "swww-daemon"
		"hypridle"
		"udiskie --no-automount --smart-tray"
        "hyprctl setcursor all-scroll 24"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      env = [
		"XCURSOR_SIZE,24"
		"HYPERCURSOR_SIZE,24"
		"QT_QPA_PLATFORM,wayland"
		"XDG_CURRENT_DESKTOP,Hyprland"
		"XDG_SESSION_TYPE,wayland"
		"XDG_SESSION_DESKTOP,Hyprland"
      ];

      general = {
        gaps_in = 3;
        gaps_out = 11;
      
        border_size = 3;

        "col.active_border" = "$borderActive";
        "col.inactive_border" = "$borderInactive";

        resize_on_border = false;
        allow_tearing = false;

        layout = "dwindle";
      };

      decoration = {
        rounding = 20;
        drop_shadow = false;
		"col.shadow" = "$background";

        blur = {
          enabled = true;
          size = 6;
          passes = 3;
          new_optimizations = "on";
          ignore_opacity = "on";
          xray = false;
        };
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      input = {
        kb_layout = "us,pt";
		#kb_variant = "colemak_dh,";
		kb_options = "caps:escape";

        follow_mouse = 1;

        sensitivity = 0; 

        touchpad = {
          natural_scroll = true;
        };
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };

      device = {
        name = "epic mouse V1";
        sensitivity = -0.5;
      };
    };
  };
}
