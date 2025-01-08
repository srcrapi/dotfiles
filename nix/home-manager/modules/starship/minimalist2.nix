{
  programs.starship = {
    enable = true;

    settings = {
      format = ''
$username[@](fg:green)$hostname $directory$git_branch$character
      '';

      right_format = "$cmd_duration";

      character = {
        success_symbol = "[\\$](fg:green)";
        error_symbol = "[\\$](fg:red)";
      };

      package.disabled = true;
      line_break.disabled = false;

      username = {
        style_user = "bg:black fg:white";
        style_root = "red bold";
        format = "\\[$user";
        disabled = false;
        show_always = true;
      };

      hostname = {
        ssh_only = false;
        format = "$hostname";
        trim_at = ".companyname.com";
        disabled = false;
      };

      memory_usage = {
        disabled = true;
        threshold = -1;
        symbol = " ";
        style = "bold dimmed green";
      };

      time = {
        disabled = true;
        format = "🕙[\[ $time \]]($style) ";
        time_format = "%T";
      };

      directory = {
        style = "bg:green fg:black";
        truncation_length = 6;
        truncation_symbol = "••/";
        format = "$path\\]";
      };

      directory.substitutions = {
        "Desktop" = "  ";
        "Documents" = "  ";
        "Downloads" = "  ";
        "Music" = " 󰎈 ";
        "Pictures" = "  ";
        "Videos" = "  ";
      };

      cmd_duration = {
        min_time = 0;
        format = "[ $duration](bold fg:yellow)";
      };

      git_branch = {
        style = "bg: green";
        symbol = "󰘬";
        truncation_length = 4;
        truncation_symbol = "";
        format = " [$symbol $branch(:$remote_branch)](fg:cyan) ";
      };

      git_commit = {
        commit_hash_length = 4;
        tag_symbol = " ";
      };

      git_state = {
        format = "[\($state( $progress_current of $progress_total)\)]($style) ";
        cherry_pick = "[🍒 PICKING](bold red)";
      };

      git_status = {
        conflicted = " 🏳 ";
        ahead = " 🏎💨 ";
        behind = " 😰 ";
        diverged = " 😵 ";
        untracked = " 🤷 ";
        stashed = " 📦 ";
        modified = " 📝 ";
        staged = "[++\($count\)](green)";
        renamed = " ✍️ ";
        deleted = " 🗑 ";
      };

    };
  };
}
