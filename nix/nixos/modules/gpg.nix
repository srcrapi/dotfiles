{ pkgs, ... }: {
	programs.gnupg.agent = {
		enable = true;

		settings = {
			default-cache-ttl = 86400;
			max-cache-ttl = 2592000;
		};

		pinentryPackage = pkgs.pinentry-curses;
	};
}
