{
  lib,
  pkgs,
  config,
  ...
}:
{
  # More configuration is possible with home-manager
  environment.systemPackages = with pkgs; [
    vesktop
  ];

  # Autostarts minimized
  systemd.user.services.vesktop = {
    enable = true;
    description = "Autostarts ${pkgs.vesktop.pname}";
    unitConfig.ConditionUser = "romana";
    wantedBy = [ "graphical-session.target" ];
    after    = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "exec";
      ExecStart = "${lib.getExe pkgs.vesktop} -m";

      Restart = "on-failure";
      RestartSec = "1s";
      RestartSteps= "5";
      RestartMaxDelaySec= "60s";

      NoNewPrivileges = true;
      PrivateTmp = true;
    };
  };
}
