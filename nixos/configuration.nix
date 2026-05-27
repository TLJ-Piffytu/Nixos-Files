{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];
	
  # BootLoader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ]; 

  # Networking
  networking.hostName = "t440p"; 
  networking.networkmanager.enable = true;
  
  # Locale
  time.timeZone = "Europe/Budapest";
  i18n.defaultLocale = "en_US.UTF-8";

  services.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
      naturalScrolling = false;
    };
  };
  services.upower.enable = true;

  # User
  users.users.piffytu = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  # Shell
  programs.zsh.enable = true;
  users.users.piffytu.shell = pkgs.zsh;
  console.keyMap = "hu";

  # WindowManager
  programs.hyprland = {
    enable = true;
  };

  # Wayland & XDG
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  # Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  security.rtkit.enable = true;

  # Power
  services.power-profiles-daemon = {
    enable = true;
  };

  # Login
  services.logind = {
    settings.Login.HandlePowerKey = "suspend";
  };
  services.getty.autologinUser = "piffytu"; # temporary, will be used until I rice a DM

  # Basic Fonts
  fonts.packages = with pkgs; [
    iosevka
    nerd-fonts.jetbrains-mono
  ];
  
  # System packages
  environment.systemPackages = with pkgs; [
    # Compiling
    gcc
    gnumake
    cmake
    pkg-config
    
    # Dev
    python3
    nodejs
    git
    tree-sitter

    # Misc
    wget
    curl
    unzip
    ripgrep
    fd
    
    # desktop
    brightnessctl
    wl-clipboard
    fastfetch
    neovim

    # LSP
    lua-language-server
    pyright
    clang-tools
    rust-analyzer
    gopls
    nil
    vscode-langservers-extracted
  ];

  # Steam
  programs.steam = {
    enable = true;
  };

  # Other
  nixpkgs.config.allowUnfree = true; # for brave

  # Enable (snow)flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11"; # Did you read the comment?

}

