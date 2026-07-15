{
  description = "An attempt at a clangd Language server thing";
  inputs.nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs-unstable }:
  let
    pkgs = import nixpkgs-unstable { system = "x86_64-linux"; };
  in
  {
    devShells.${pkgs.system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        wayland
        wayland-protocols
        wayland-scanner
        pkg-config
        clang-tools
        clang
        vscodium
      ];
    };
  };
}
