{ ... }: {
  programs.git = {
    enable = true;
    userName =
      "Your Name"; # Instance-specific values should be set in the user assembly if needed
    userEmail =
      "your@email"; # You can also override via HM's programs.git in the user file
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
