{
  programs.starship = {
    enable = true;

    settings = {
      format = ''
$username$hostname $directory $git_branch
$character
      '';

      right_format = "$cmd_duration";

      character = {
        success_symbol = "[• ](bold fg:green) ";
        error_symbol = "[• 󰅙](bold fg:red) ";
      };

      package.disabled = true;
      line_break.disabled = false;

      username = {
        style_user = "bold bg:cyan fg:black";
        style_root = "red bold";
        format = "[](bold fg:cyan)[$user]($style)";
        disabled = false;
        show_always = true;
      };

      hostname = {
        ssh_only = false;
        format = "[•$hostname](bg:cyan bold fg:black)[](bold fg:cyan )";
        trim_at = ".companyname.com";
        disabled = false;
      };

      git_branch = {
        style = "bg: green";
        symbol = "󰘬";
        truncation_length = 4;
        truncation_symbol = "";
        format = "• [](bold fg:green)[$symbol $branch(:$remote_branch)](fg:black bg:green)[ ](bold fg:green)";
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
        home_symbol = "  ";
        read_only = "  ";
        style = "bg:green fg:black";
        truncation_length = 4;
        truncation_symbol = "••/";
        format = "[](bold fg:green)[$path ]($style)[](bold fg:green)";
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
        format = "[](bold fg:yellow)[ $duration](bold bg:yellow fg:black)[](bold fg:yellow) •• ";
      };
    };
  };
}
