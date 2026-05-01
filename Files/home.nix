{ pkgs, lib, ... }:
{
  # Defaults
  home.stateVersion = "25.11";
  home.username = "piffytu";
  home.homeDirectory = "/home/piffytu";

  programs.home-manager.enable = true;
  
  home.activation.copyDotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
    cp -rf ${./dotfiles/mango}/. ~/.config/mango/
    cp -rf ${./dotfiles/waybar}/. ~/.config/waybar/
    cp -rf ${./dotfiles/nvim}/. ~/.config/nvim/
    cp -rf ${./dotfiles/kitty}/. ~/.config/kitty/
  '';

  # zsh
  programs.zsh = {
    enable = true;
    initContent = builtins.readFile ./dotfiles/zsh/zshrc;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    # WM utils
    waybar
    mpvpaper
    rofi

    # Main apps
    kitty
    brave

    # Other apps
    btop
    neovim
  ];
}
