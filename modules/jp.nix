{ pkgs, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    fcitx5 = {
      waylandFrontend = true;
      ignoreUserConfig = true; # Everything must be configured through nix!

      addons = with pkgs; [ fcitx5-anthy ];

      settings.inputMethod = {
        GroupOrder."0" = "Default";

        "Groups/0" = {
          Name = "Default";
          "Default Layout" = "hr";
          DefaultIM = "keyboard-hr";
        };

        "Groups/0/Items/0".Name = "keyboard-hr";
        "Groups/0/Items/1".Name = "anthy"; # keybinds in settings
      };
    };
  };
}
