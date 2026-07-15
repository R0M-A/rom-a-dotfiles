{config, pkgs, ...}:
{
services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            tab = "";
            pageup = "tab";
          };
          otherlayer = {};
        };
        extraConfig = ''
          # put here any extra-config, e.g. you can copy/paste here directly a configuration, just remove the ids part
        '';
      };
    };
  };
}
