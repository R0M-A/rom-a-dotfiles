{
  config,
  pkgs,
  lib,
  ...
}:
{
#   services.keyd = {
#     enable = true;
#
#     keyboards = {
#       default = {
#         ids = [ "*" ];
#         settings = {
# #           main = {
# #             mouse2 = "C-w";
# #           };
#           otherlayer = {};
#         };
#         extraConfig = ''
#           [mouse]
#           BTN_EXTRA = w
#         '';
#       };
#     };
#   };

  # Razer mouse
#   hardware.openrazer.enable = true;
#   environment.systemPackages = with pkgs; [
#     openrazer-daemon
#     polychromatic
#   ];
#   users.users.romana.extraGroups = [ "openrazer" ];
}
