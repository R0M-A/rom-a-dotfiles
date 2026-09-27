{ pkgs, ... }:
let
  modelsPreset = ''
    version = 1

    # Shared runtime settings.
    [*]
    jinja = true
    flash-attn = on
    cache-type-k = q8_0
    cache-type-v = q8_0
    load-mode = mmap
    batch-size = 512
    ubatch-size = 256
    parallel = 1

    # Qwen3-Coder-30B-A3B-Instruct
    #
    # Unsloth's recommended Q4 GGUF:
    # UD-Q4_K_XL (~17.7 GB)
    [qwen3-coder]
    hf-repo = unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:UD-Q4_K_XL

    ctx-size = 32768

    # Unsloth recommended sampling:
    temp = 0.7
    top-p = 0.8
    top-k = 20
    repeat-penalty = 1.05

    load-on-startup = true

    # DavidAU Qwen3.8-27B TURBO MTP
    #
    # Q4_K_M MTP (~18 GB)
    [davidau-qwen38-mtp]
    hf-repo = DavidAU/Qwen3.8-27B-TURBO-Fable-Cold-Fusion-735-882-Heretic-Uncensored-NEO-CODER-MAX-MTP-GGUF:Q4_K_M

    # DavidAU specifically recommends 8-16K context.
    ctx-size = 16384

    # DavidAU "precise coding" settings:
    temp = 0.6
    top-p = 0.95
    top-k = 20
    min-p = 0.0
    presence-penalty = 0.0
    repeat-penalty = 1.0

    # Use the MTP heads included in this GGUF.
    spec-type = draft-mtp
    spec-draft-n-max = 2

    load-on-startup = false
  '';
in
{
  hardware.graphics.enable = true;

  services.llama-cpp = {
    enable = true;
    package = pkgs.llama-cpp.override { vulkanSupport = true; }; # RX 6500 XT not on ollama ROCm support list, so vulkan it is.

    settings = {
      host = "127.0.0.1";
      port = 8080;

      models-preset = modelsPreset; # Router mode: models are loaded on demand.
      models-max = 1;
      models-autoload = true;
    };
  };

#   # The NixOS llama.cpp service uses DynamicUser.
#   # Give it access to the GPU render device.
#   systemd.services.llama-cpp.serviceConfig.SupplementaryGroups = [
#     "render"
#   ];


  environment.systemPackages = with pkgs; [
    vulkan-tools
  ];
}
