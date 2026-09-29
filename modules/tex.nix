{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    texliveFull
    texstudio
  ];
}
