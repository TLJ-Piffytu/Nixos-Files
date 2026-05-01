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
  programs.mango.enable = true;

  # Wayland & XDG
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };

  # Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  security.rtkit.enable = true;

  # Login
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

    # Misc
    wget
    curl
    unzip
    wl-clipboard
    fastfetch
    neovim
    ripgrep
    fd
    neovim
    tree-sitter

    # LSP
    lua-language-server
    pyright
    clang-tools
    rust-analyzer
    gopls
    nil
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

