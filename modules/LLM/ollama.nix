{ pkgs }:
{
  hardware.graphics.enable = true;

  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan; # RX 6500 XT not on ollama ROCm support list, so vulkan it is.

    host = "127.0.0.1";
    port = 11434;

    environmentVariables = {
      OLLAMA_NUM_PARALLEL = "1";
      OLLAMA_MAX_LOADED_MODELS = "1";

      OLLAMA_CONTEXT_LENGTH = "32768";
      OLLAMA_KV_CACHE_TYPE = "q8_0";
      OLLAMA_FLASH_ATTENTION = "1";
    };

    loadModels = [
      "qwen3-coder:30b"
      "hf.co/DavidAU/Qwen3.8-27B-TURBO-Fable-Cold-Fusion-735-882-Heretic-Uncensored-NEO-CODER-MAX-MTP-GGUF:Q4_K_M"
    ];

    syncModels = false; # Auto deletes old models
  };

  environment.systemPackages = with pkgs; [
    ollama-vulkan
    vulkan-tools
  ];
}
