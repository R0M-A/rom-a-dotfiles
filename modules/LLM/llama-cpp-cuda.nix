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
    ctx-size = 32768
    n-predict = 8192
    parallel = 1

    # Use as much GPU, but leave 5GB for the rest
    fit = on
    fit-target = 5120

    # Don't eat the whole CPU pls
    threads = 8        # generation
    threads-batch = 8  # batch and prompt processing

    # Batch sizes
    batch-size = 2048    # logical
    ubatch-size = 2048   # physical

    [Qwen3.8-27B:UD-Q4_K_XL]
    hf-repo = unsloth/Qwen3.8-27B-GGUF
    hf-file = Qwen3.8-27B-UD-Q4_K_XL.gguf
    alias = Qwen3.8-27B:UD-Q4_K_XL

    # From unsloth's thinking mode suggestion https://unsloth.ai/docs/models/qwen3.8#run-qwen3.8
    temp = 1.0
    top-p = 0.95
    top-k = 20
    min-p = 0.0
    repeat-penalty = 1.0

    # Reasoning budget
    reasoning-budget = 8192
    reasoning-budget-message = Thinking budget reached. Give the best answer you have now.
    chat-template-kwargs = {"reasoning_effort":"medium"}

    # Native MTP speculative decoding
    spec-type = draft-mtp
    spec-draft-n-max = 2

    # Vision projector stays on CPU
    mmproj-url = https://huggingface.co/unsloth/Qwen3.8-27B-GGUF/resolve/main/mmproj-F16.gguf
    no-mmproj-offload = true
    image-max-tokens = 4096
    image-min-tokens = 1024
  '';

  mcp-servers-config = pkgs.writeText "mcp-servers.json" ''
    {
      "mcpServers": {
        "web": {
          "command": "${pkgs.mcp-server-fetch}/bin/mcp-server-fetch"
        }
      }
    }
  '';
in
{
  hardware.graphics.enable = true;

  services.llama-cpp = {
    enable = true;
    package = pkgs.llama-cpp.override { cudaSupport = true; };

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
    };
  };

  environment.systemPackages = with pkgs; [
    nvtopPackages.nvidia
  ];
}
