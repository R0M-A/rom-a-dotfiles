{ pkgs, ... }:
let
  models-preset = pkgs.writeText "llama-cpp-models.ini" ''
    version = 1

    [*]
    jinja = true
    flash-attn = on
    cache-type-k = q8_0
    cache-type-v = q8_0
    load-mode = mmap
    batch-size = 512
    ubatch-size = 256
    parallel = 1


    [qwen3-coder]
    hf-repo = unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:UD-Q4_K_XL
    ctx-size = 32768
    load-on-startup = false

    # Unsloth recommended sampling:
    temp = 0.7
    top-p = 0.8
    top-k = 20
    repeat-penalty = 1.05


    [davidau-qwen38-mtp]
    hf-repo = DavidAU/Qwen3.8-27B-TURBO-Fable-Cold-Fusion-735-882-Heretic-Uncensored-NEO-CODER-MAX-MTP-GGUF:Q4_K_M
    ctx-size = 32768
    image-min-tokens = 2048

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

    load-on-startup = true
  '';

  mcp-servers-config = pkgs.writeText "mcp-servers.json" ''
    {
      "mcpServers": {
        "web": {
          "command": "${pkgs.mcp-server-fetch}/bin/mcp-server-fetch"
        },

        "nixos": {
          "command": "${pkgs.mcp-nixos}/bin/mcp-nixos"
        }
      }
    }
  '';
in
{
  hardware.graphics.enable = true;

  services.llama-cpp = {
    enable = true;
    package = pkgs.llama-cpp.override { vulkanSupport = true; }; # RX 6500 XT not on ollama ROCm support list, so vulkan it is.

    settings = {
      host = "127.0.0.1";
      port = 9931;
      cors-origins = "localhost";

      inherit models-preset mcp-servers-config;
      models-max = 1;
      models-autoload = true;
    };
  };

  systemd.services.llama-cpp = {
#     serviceConfig.CacheDirectory = "llama-cpp";
    environment = {
      XDG_CACHE_HOME = "/var/cache/llama-cpp";
#       MESA_SHADER_CACHE_DIR = "/var/cache/llama-cpp";
    };
  };

  environment.systemPackages = with pkgs; [
    vulkan-tools
  ];
}
