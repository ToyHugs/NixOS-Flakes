{ pkgs, pkgsUnstable ? null, ... }: {
  # Developer-focused CLI toolbox. Pure bundle (no user names).
  environment.systemPackages = (with pkgs; [
    gcc
    gnumake
    pkg-config
    git-lfs
    ripgrep
    fd
    bat
    jq
    unzip
    zip
    python3
    nodejs
    docker-compose
  ]) ++ (if pkgsUnstable != null then [ pkgsUnstable.neovim ] else [ ]);
}
