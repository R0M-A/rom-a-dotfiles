{
  lib,
  pkgs,
  config,
}:
{
  hardware.openrazer.enable = true;
  environment.systemPackages = with pkgs; [
    openrazer-daemon
    polychromatic
  ];
  users.users.romana.extraGroups = [ "openrazer" ];
}
