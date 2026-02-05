{ pkgs, lib, ... }: {

  # Packages
  environment.systemPackages = with pkgs; [
    home-manager
    nix-search-cli

    alsa-utils
  ];

  # Services
  networking.networkmanager.enable = true;

  # Fingerprint
  services."06cb-009a-fingerprint-sensor" = {                                 
	  enable = true;                                                            
	  backend = "python-validity";                                              
  };   

  security.pam.services = {
	  sudo.fprintAuth = true;
	  login.fprintAuth = true;
  };
  #

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = { main = { capslock = "overload(control, esc)"; }; };
    };
  };

  services.printing.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Desktop Environment
  services.xserver = {
    enable = true;
    windowManager.qtile = {
	    enable = true;
	    extraPackages = python3Packages: with python3Packages; [
		    qtile-extras
	    ];
    };
    displayManager.startx.enable = true;
    displayManager.lightdm.enable = false;

    xkb = {
      layout = "us";
      variant = "";
    };
  };

  programs.dconf.enable = true;
}
