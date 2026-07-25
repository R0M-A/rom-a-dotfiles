{
  config,
  pkgs,
  ...
}:
{
  programs.obs-studio = {
    enable = true;

    # optional Nvidia hardware acceleration
#     package = pkgs.obs-studio.override {
#       cudaSupport = true;
#     };

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs # wayland wlroots
      obs-backgroundremoval # webcam blurryBG
      obs-pipewire-audio-capture
      obs-vaapi # optional AMD hardware acceleration
      #obs-gstreamer # Some library I don't quite undrstand
      obs-vkcapture
    ];
  };
}
