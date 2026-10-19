{
  description = "Sovereign of systems";

  inputs = {
    secrets.url = "/etc/nixos/.secrets";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    personal-nixpkgs.url = "github:HyprGirl/nixpkgs?ref=master";
    llamato-nixpkgs.url = "github:Llamato/nixpkgs?ref=master";

    nixos-hardware = {
      url = "github:nixos/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      home = {
        imports = [ inputs.home-manager.nixosModules.default ];
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = specialArgs;
          users.romana = ./home.nix;
        };
      };
    in
    {
      nixosConfigurations.labin-703 = nixpkgs.lib.nixosSystem {
        inherit specialArgs system;
        modules = [
          ./hosts/labin-703
          home
          ./modules/LLM/llama-cpp.nix
          ./modules/razer-mouse.nix
          ./modules/obs.nix
          ./modules/git.nix
          ./modules/tex.nix
          ./modules/jp.nix
          ./modules/vesktop.nix
          ./modules/wire-guard.nix
        ];
      };

      nixosConfigurations."misao-13" = nixpkgs.lib.nixosSystem {
        inherit specialArgs system;
        modules = [
          ./hosts/misao-13
          ./modules/obs.nix
          ./modules/git.nix
        ];
      };
    };
}
