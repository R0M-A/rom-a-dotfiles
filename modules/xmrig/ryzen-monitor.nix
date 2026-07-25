{ stdenv, pkgs, fetchFromGitHub, makeWrapper, lib, ... }:

stdenv.mkDerivation rec {
  pname = "ryzen-monitor-ng";
  version = "git";

  src = fetchFromGitHub {
    owner = "plasmin";
    repo = "ryzen_monitor_ng";
    rev = "8b7854791d78de731a45ce7d30dd17983228b7b1";
    sha256 = "fcW2fEsCFliRnMFnboR0jchzVIlCYbr2AE6AS06cb6o=";
  };

  nativeBuildInputs = [ makeWrapper ];

  NIX_CFLAGS_COMPILE = "-O3";
  makeFlags = [ "PREFIX=${placeholder "out"}" ];

  postUnpack = ''
    # remove old SMU binaries and libs
    rm -rf $sourceRoot/src/lib/*
    rm -f $sourceRoot/src/ryzen_monitor

    # copy SMU libs (same version as kernel module)
    echo " "
    cp -r ${pkgs.linuxPackages.ryzen-smu.src}/lib/* $sourceRoot/src/lib
    ls $sourceRoot/src/lib
  '';

  meta = with lib; {
    description = "Ryzen SMU monitor (patched build using ryzen_smu source)";
    platforms = [ "x86_64-linux" ];
  };
}
