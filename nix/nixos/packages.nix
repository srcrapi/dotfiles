{ pkgs, ... }: {
	nixpkgs.config.allowUnfree = true;
  
	environment.systemPackages = with pkgs; [
		gnupg
		ripgrep
		blender
		tldr
		pinentry-curses
		pass
		kitty
		neovim
		vscode
		obsidian
		obs-studio
		mpv
		openvpn

		# gaming
		lutris
		wineWow64Packages.base
		winetricks
		steam
		protonup

		vesktop
		nautilus
		curl
		zoxide
		tree
		nmap
		spotify
		mpd-mpris
		spicetify-cli
		waybar
		swaynotificationcenter
		libnotify
		rofi-wayland
		openssh
		swww
		eza
		pamixer
		flatpak
		fish
		starship
		git
		gh
		lazygit
		electron
		xsel
		libsForQt5.sddm
		qt6.qtwayland
		unzip
		unrar-wrapper

		# dev
		mariadb
		mariadb-connector-c
		go

		## python
		python312
		python3Packages.tkinter
		python312Packages.pillow
		python312Packages.pip
		python312Packages.fastapi
		python312Packages.uvicorn
		ruff

		corepack
		ninja
		gobject-introspection.dev
		meson
		cmake
		pywal
		pywalfox-native
		gcc
		home-manager
		libsForQt5.qtstyleplugin-kvantum
		libsForQt5.qt5ct
		libsForQt5.qt5.qtquickcontrols2
		libsForQt5.qt5.qtgraphicaleffects
		brightnessctl
		pipewire
		pulseaudio
		fastfetch
		htop
		btop
		tty-clock
		tmux
		cava
		bat
		alsa-utils
		killall
		networkmanagerapplet
		adwaita-qt
		herbstluftwm

		# hyprland
		hyprland
		hyprlock
		hyprpicker
		hypridle
		xdg-desktop-portal-hyprland

		nwg-look
		glib
		wlogout
		swappy
		seatd
		xwayland
		wl-clipboard
		wf-recorder
		#nodejs_20
		firefox-devedition
		chromium
		libreoffice
		playerctl
		(tela-circle-icon-theme.override { colorVariants = [ "dracula" ]; })
		#tela-circle-icon-theme
		imagemagick
		jq
		parallel
		catppuccin
		catppuccin-kvantum
		bibata-cursors
		vanilla-dmz
		grim
		grimblast
		slurp
		udiskie
		feh
		fzf
		service-wrapper
		cargo
		tlp
		bluez
		bluez-tools
		blueman
		pavucontrol
		nix-prefetch-git
	];

	fonts.packages = with pkgs; [
		noto-fonts
		noto-fonts-emoji
		noto-fonts-cjk-sans
		twemoji-color-font
		font-awesome
		cantarell-fonts
		cascadia-code
		powerline-fonts
		powerline-symbols
		material-symbols
		roboto
		montserrat
		(nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
  ];
}
