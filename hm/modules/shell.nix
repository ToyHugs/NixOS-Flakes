{ pkgs, ... }: {
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };
  programs.starship.enable = true;

  home.packages = with pkgs; [ fzf ];
}
