{
  config,
  pkgs,
  lib,
  ...
}:
{
  # There's no support for my scanner 22.1.2025., 2nd try 11.10.2025.
  #     systemd.services.fprintd = {
  #         wantedBy = [ "multi-user.target" ];
  #         serviceConfig.Type = "simple";
  #     };
  #
  #     services.fprintd = {
  #         enable = true;
  #         tod.enable = true;
  #         tod.driver = pkgs.libfprint-2-tod1-goodix;
  #     };

  # Razer mouse
  hardware.openrazer.enable = true;
  environment.systemPackages = with pkgs; [
    openrazer-daemon
    polychromatic
  ];
  users.users.romana.extraGroups = [ "openrazer" ];

  services = {
    supergfxd.enable = true;
    asusd = {
      enable = true;
      enableUserService = true;
    };
  };

  boot.blacklistedKernelModules = [ "nouveau" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  boot.kernelParams = [ "NVreg_UsePageAttributeTable=1" ];

  nix.settings = {
    auto-optimise-store = true;
    max-jobs = "auto";
    cores = 8;
  };

  # https://github.com/NixOS/nixos-hardware/blob/master/common/gpu/nvidia/prime.nix#L7C1-L7C145
  hardware.nvidia.primeBatterySaverSpecialisation = true;

  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      TLP_DEFAULT_MODE = "BAT";

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      RUNTIME_PM_DRIVER_DENYLIST="mei_me";
      RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
      RADEON_DPM_PERF_LEVEL_ON_BAT = "low";
      AMDGPU_ABM_LEVEL_ON_AC = 0;
      AMDGPU_ABM_LEVEL_ON_BAT = 0;

      # START_CHARGE_THRESH_BAT0 = 40; # Doesn't work
      STOP_CHARGE_THRESH_BAT0 = 60;

      DISK_DEVICES = "nvme-WDC_PC_SN530_SDBPNPZ-1T00-1002_204118803696";
    };
  };
}
