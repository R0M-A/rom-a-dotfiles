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
  };

  outputs = { self, nixpkgs, ... } @inputs:
    {
      nixosConfigurations.labin-703 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./hosts/labin-703/hardware-configuration.nix
          ./hosts/labin-703/hardware-extra.nix
          ./hosts/labin-703/configuration.nix
          ./modules/razer-mouse.nix
          ./modules/obs.nix
          ./modules/git.nix
          ./modules/vesktop.nix
          ./modules/wire-guard.nix
        ];
      };

      nixosConfigurations."misao-13" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./hosts/misao-13/configuration.nix
          ./hosts/misao-13/intel.nix
          ./modules/obs.nix
          ./modules/git.nix
        ];
      };
    };
}
