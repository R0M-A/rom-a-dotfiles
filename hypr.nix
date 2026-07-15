{
  config,
  lib,
  inputs,
  pkgs,
  imports,
  ...
}:
let
  hyprland = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  xdg-desktop-portal-hyprland =
    inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  hyprsplit = inputs.hyprsplit.packages.${pkgs.stdenv.hostPlatform.system}.hyprsplit;
  split-monitor-workspaces =
    inputs.split-monitor-workspaces.packages.${pkgs.stdenv.hostPlatform.system}.split-monitor-workspaces;
in
{
  #     inputs = {
  #       hyprland.url = "github:hyprwm/Hyprland";
  #
  #       hyprland-plugins = {
  #         url = "github:hyprwm/hyprland-plugins";
  #         inputs.hyprland.follows = "hyprland"; # Prevents version mismatch.
  #       };
  #     };

  imports = [ inputs.hyprland.nixosModules.default ];

  programs.hyprland = {
    package = hyprland;
    portalPackage = xdg-desktop-portal-hyprland;

    enable = true;
    # withUWSM = true; # I have SDDM soooooo... ¯\_(ツ)_/¯
    xwayland.enable = true; # Compatibility
    plugins = [
      split-monitor-workspaces
      hyprsplit
    ];
  };

  #     xdg.portal = {
  #       enable = true;
  #       extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  #     };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = with pkgs; [
    kitty
    anyrun
    pwvucontrol
    waybar
    hypridle
    imv
    # Add other packages as needed
  ];

  #     nix.settings = {
  #         substituters = ["https://hyprland.cachix.org"];
  #         trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  #     };

}
