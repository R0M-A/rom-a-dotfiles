# By Romana <3!
{ lib, pkgs, config, ... }:

{
  # Laptop power management https://linrunner.de/tlp/faq/ppd.html and https://wiki.nixos.org/wiki/Laptop
#   services.power-profiles-daemon.enable = false;
#   services.tlp.enable = true;

  ### NVIDIA GPU from https://wiki.nixos.org/wiki/NVIDIA and https://search.nixos.org/options?channel=unstable&query=hardware.nvidia and https://github.com/NixOS/nixos-hardware/tree/master/common/gpu/nvidia/ampere
  services.xserver.videoDrivers = [
    "modesetting" # Intel iGPU
  ];

  ### Intel GPU from https://wiki.nixos.org/wiki/Intel_Graphics and https://github.com/NixOS/nixos-hardware/blob/master/common/gpu/intel/kaby-lake/default.nix
#   hardware.intelgpu = {
#     computeRuntime = "legacy";
#     vaapiDriver = "intel-media-driver";
#   };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver     # VA-API (iHD) userspace
      vpl-gpu-rt             # oneVPL (QSV) runtime
      intel-compute-runtime  # OpenCL (NEO) + Level Zero for Arc/Xe
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";  # Prefer the modern iHD backend
  };

  # i915 setup
  boot = {
    initrd.kernelModules = [ "i915" ];
    kernelParams = [
      "i915.enable_guc=2"
      "i915.enable_fbc=1"
      "i915.enable_psr=2"
    ];
  };

  ### Intel CPU
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
