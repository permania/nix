{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"

    ./hardware-configuration.nix
    ./mod/userland.nix
    ./mod/system.nix
  ];

  networking.hostName = "neptune";
  system.stateVersion = "25.05";
}
