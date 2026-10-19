# home.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [

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
