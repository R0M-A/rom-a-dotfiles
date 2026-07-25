{ config, lib, ... }:

{
    programs.git = {
        enable = true;
#         config.user = { # Home manager
#             name  = "John Doe";
#             email = "johndoe@example.com";
#         };
    };
}
