{ pkgs, lib, ... }: {
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-57af3897-06bb-4e24-b1a8-006a62d52c3e".device =
    "/dev/disk/by-uuid/57af3897-06bb-4e24-b1a8-006a62d52c3e";

  fileSystems."/" = lib.mkForce {
    device = "/dev/mapper/luks-cb1542e8-824a-42ad-baf9-c9bf80f3c6e7";
    fsType = "btrfs";
    options = [ "subvol=@" "compress=zstd" "ssd" "discard=async" ];
  };

  fileSystems."/home" = lib.mkForce {
    device = "/dev/mapper/luks-cb1542e8-824a-42ad-baf9-c9bf80f3c6e7";
    fsType = "btrfs";
    options = [ "subvol=@home" "compress=zstd" "ssd" "discard=async" ];
  };

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Nix Features
  nixpkgs.config.allowUnfree = true;

  # Packages
  environment.systemPackages = with pkgs; [ brightnessctl ];

  # Services
  services.openssh.enable = true;

  # Nix Features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Admin User
  users.users.corn = {
    isNormalUser = true;
    description = "corn";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  security.sudo = {
	  enable = true;
	  extraConfig = "Defaults timestamp_timeout=0";
  };
}
