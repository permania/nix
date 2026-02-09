{
  description = "A very basic flake";

  inputs = {
	  nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
	  nixos-06cb-009a-fingerprint-sensor = {
            url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor?ref=25.05";
            inputs.nixpkgs.follows = "nixpkgs";
          };
          nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { nixpkgs, nix-colors, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.packages.${system};
  in
  {
    nixosConfigurations."neptune" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}
