# Made by Computer_Q (https://github.com/QuintenMuyllaert)
# Lightly modified by Romana (https://github.com/HyprGirl)
{
  lib,
  kdePackages,
  wakatime-cli,
  fetchFromGitHub
}:

# Derivation for kate-wakatime plugin
kdePackages.mkKdeDerivation rec {
  pname = "kate-wakatime";
  version = "1.5.4";

  src = fetchFromGitHub {
    owner = "Tatsh";
    repo = "kate-wakatime";
    tag = "v${version}";
    hash = "sha256-LNWQE1nwiENoWlYyzWIBWe60wD4ZI3aq4UqmUNk8M7k=";
  };

  buildInputs = [
    kdePackages.ktexteditor
#     wakatime-cli
  ];

  meta = {
    description = "WakaTime plugin for Kate";
    homepage = "https://github.com/Tatsh/kate-wakatime";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
#     maintainers = with lib.maintainers; [ ];
  };
}
