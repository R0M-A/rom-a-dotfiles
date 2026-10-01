{ pkgs, ... }:
let
  models-preset = pkgs.writeText "llama-cpp-models.ini" ''
    version = 1

    [*]
    jinja = true
    flash-attn = on
    load-mode = mmap
    load-on-startup = false

    # KV cache
    cache-type-k = q8_0
    cache-type-v = q8_0
    no-kv-offload = true
    ctx-size = 16384
    n-predict = 8192

    # Use as much GPU, but leave 512MB for the rest
    fit = on
    fit-target = 512

    # Don't eat the whole CPU pls
    threads = 16        # generation
    threads-batch = 20  # batch and prompt processing

    # Interactive single-user
    batch-size = 256    # logical
    ubatch-size = 128   # physical
    parallel = 1


    [Qwen3.8-4B-Distill:Q5_K_M-empero-ai]
    hf-repo = empero-ai/Qwen3.8-4B-Distill-GGUF:Q5_K_M
    load-on-startup = true
    no-kv-offload = false

    # Configuring chat_template
    # chat_template_kwargs = {"reasoning_effort":"low"}

    # Empero's published settings.
    temp = 0.6
    top-p = 0.95
    top-k = 20
    min-p = 0.0
    repeat-penalty = 1.0


    [Qwen3.8-27B:Q4_K_M-DavidAU]
    hf-repo = DavidAU/Qwen3.8-27B-TURBO-Fable-Cold-Fusion-735-882-Heretic-Uncensored-NEO-CODER-MAX-MTP-GGUF:Q4_K_M
    image-min-tokens = 1024

    # Use the MTP heads included in this GGUF.
    spec-type = draft-mtp
    spec-draft-n-max = 2

    # DavidAU "precise coding" settings:
    temp = 0.6
    top-p = 0.95
    top-k = 20
    min-p = 0.0
    presence-penalty = 0.0
    repeat-penalty = 1.0
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
    };
  };

  systemd.services.llama-cpp = {
    serviceConfig = {
      CacheDirectory = "llama-cpp";
      CacheDirectoryMode = "0750";
    };

    environment = {
      LLAMA_CACHE = "/var/cache/llama-cpp";
      XDG_CACHE_HOME = "/var/cache/llama-cpp";
      MESA_SHADER_CACHE_DIR = "/var/cache/llama-cpp";
    };
  };

  environment.systemPackages = with pkgs; [
    vulkan-tools
  ];
}
