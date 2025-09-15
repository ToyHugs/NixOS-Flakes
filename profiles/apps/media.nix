{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ ffmpeg mpv imagemagick ];
}
