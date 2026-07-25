{
  description = "Python developement shell";
  inputs.nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs-unstable }:
  let
    pkgs = import nixpkgs-unstable { system = "x86_64-linux"; };
  in
  {
    devShells.${pkgs.stdenv.hostPlatform.system}.default = pkgs.mkShell {
      name = "C#";
      buildInputs = with pkgs; [
        (with dotnetCorePackages;
          combinePackages [
            # sdk_8_0 # if you need more than 1 sdk
            sdk_9_0
          ]
        )
        avalonia
        vscodium
      ];
    };
  };
}
