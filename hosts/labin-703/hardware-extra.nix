{ config, pkgs, ... }:

{
  #CPU monitoring
#   hardware.cpu.amd.ryzen-smu.enable = true;

  # Enables the zenpower sensor in lieu of the k10temp sensor on Zen CPUs https://git.exozy.me/a/zenpower3
  # On Zen CPUs zenpower produces much more data entries
  # https://github.com/NixOS/nixos-hardware/blob/master/common/cpu/amd/zenpower.nix
  boot.blacklistedKernelModules = [ "k10temp" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.zenpower ];
  boot.kernelModules = [ "zenpower" ];

#   boot.kernelParams = [ "amd_pstate=guided" ];


  #Hardware specific packages
#   programs.coolercontrol.enable = true;
  environment.systemPackages = with pkgs; [
    rocmPackages.rocm-smi
    lm_sensors
#     liquidctl
    pciutils
    usbutils
#     openrgb-with-all-plugins
  ];
  #Hardware specific services
  #services.cpupower-gui.enable = true;
  #services.hardware.openrgb.enable = true;

  #GPU drivers (6500 xt)
#   services.xserver.videoDrivers = [ "amdgpu" ];
  hardware = {
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
      zluda.enable = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };


  hardware.enableRedistributableFirmware = true;
}
