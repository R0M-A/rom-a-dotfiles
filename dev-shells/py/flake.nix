{
  description = "Python developement shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in
    {
      devShells."x86_64-linux".default = pkgs.mkShell {
        buildInputs = with pkgs; [
          (python3.withPackages (
            p: with p; [
              black
              openpyxl
              jupyter
              ipython
              numpy
              scipy
              matplotlib
            ]
          ))
        ];
      };
    };
}
