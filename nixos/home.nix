{ pkgs, lib, ... }:
{
  # Defaults
  home.stateVersion = "25.11";
  home.username = "piffytu";
  home.homeDirectory = "/home/piffytu";

  programs.home-manager.enable = true;
  
  home.activation.copyDotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
#    cp -rf ${./dotfiles/waybar}/. ~/.config/waybar/
#    cp -rf ${./dotfiles/nvim}/. ~/.config/nvim/
#    cp -rf ${./dotfiles/kitty}/. ~/.config/kitty/
  '';
  # shell
  services.wayle.enable = true;

  # Cursor
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
  
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Classic";
    size = 24;
  };
  
  # zsh
  programs.zsh = {
    enable = true;
    initContent = builtins.readFile ./dotfiles/zsh/zshrc;
  };
  
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.yazi.enable = true;
  
  home.packages = with pkgs; [
    # WM utils
    mpv
    mpvpaper
    waypaper
    rofi
    # pywal
	wallust
  
    hyprshot
    hyprlock
  
    # Main apps
    kitty
    brave
    prismlauncher
	  
    freecad
    blender
	
	kew
    # Other apps
    btop
    neovim
  ];
}
