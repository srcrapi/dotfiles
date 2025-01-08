{ config, pkgs, ... }: {
  systemd.services."sddm-avatar" = {
    description = "Service to copy or update users Avatars at startup.";
    wantedBy = [ "multi-user.target" ];
    before = [ "sddm.service" ];
    script = ''
		set -eu
		mkdir -p /var/lib/users-avatar

		for user in /home/*; do
			username=$(basename "$user")
			if [ -f "$user/.face.icon" ]; then
				if [ ! -f "/var/lib/users-avatar/$username" ]; then
					mkdir -p /var/lib/users-avatar/$username
					cp "$user/.face.icon" "/var/lib/users-avatar/$username"
				else
					if [ "$user/.face.icon" -nt "/var/lib/users-avatar/$username" ]; then
						cp "$user/.face.icon" "/var/lib/users-avatar/$username"
					fi
				fi
			fi
		done
    '';
    serviceConfig = {
      Type = "simple";
      User = "root";
      StandardOutput = "journal+console";
      StandardError = "journal+console";
    };
  };

  # Ensures SDDM starts after the service.
  systemd.services.sddm = {
    after = [ "sddm-avatar.service" ];
  };
}
