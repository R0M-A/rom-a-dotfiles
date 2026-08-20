{
  stdenv,
  fetchFromGitHub,
  gtk3,
  pkg-config,
  wrapGAppsHook3,
}:

# Not needed anymore, this is now in nixpkgs

stdenv.mkDerivation {
  pname = "zenmonitor";
  version = "git";

  # https://github.com/detiam/zenmonitor3
  # https://aur.archlinux.org/packages/zenmonitor3-git
  src = fetchFromGitHub {
    owner = "detiam";
    repo = "zenmonitor3";
    rev = "1e1ceec7353dc418578fe8ae56536bfee6adeca3";
    sha256 = "q5BeLu0A2XJkJL8ptN4hj/iLhQmpb16QEhOuIhNzVaI=";
  };

  buildInputs = [ gtk3 ];
  nativeBuildInputs = [
    pkg-config
    wrapGAppsHook3
  ];

  makeFlags = [ "PREFIX=${placeholder "out"}" ];
}
