# home.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kdePackages.kate
    kdePackages.filelight
    kdePackages.skanlite
    kdePackages.isoimagewriter
    kdePackages.kdenlive
    kdePackages.kgpg
    kdePackages.plasma-login-manager
    kdePackages.audiocd-kio
    kdePackages.k3b
    osu-lazer-bin
    (prismlauncher.override { jdks = [ jdk25 ]; })
  ];

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      hyfetch
    '';
  };

  # Use the Home Manager release you started with; same as system.stateVersion, don't change!
  home.stateVersion = "26.11";
}
