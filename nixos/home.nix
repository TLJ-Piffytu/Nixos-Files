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

  # Shell
  services.wayle = {
    enable = true;
    settings =
    {
      bar = {
        background-opacity = 90;
        bg = "bg-base";
        border-width = 0;
        button-bg-opacity = 0;
        button-group-rounding = "none";
        button-rounding = "none";
        button-variant = "basic";
        layout = [
          {
            center = [ "hyprland-workspaces" ];
            left = [
              "dashboard"
              "separator"
              "network"
              "clock"
            ];
            monitor = "*";
            right = [
              "battery"
              "notifications"
              "separator"
              "media"
              "separator"
              "volume"
            ];
            show = true;
          }
        ];
        padding = 0;
        padding-ends = 0;
        scale = 0.8;
      };
      modules = {
        clock = {
          format = "%a %b %d %H:%M";
          icon-show = false;
        };
        hyprland-workspaces = {
          min-workspace-count = 5;
        };
        media = {
          label-max-length = 15;
        };
        network = {
          label-show = false;
        };
        notification = {
          popup-max-visible = 3;
        };
        power = {
          left-click = "poweroff";
          right-click = "reboot";
        };
      };
      osd = {
        margin = 20;
        position = "bottom-right";
      };
      styling = {
        pywal-apply-globally = false;
        rounding = "none";
        scale = 0.86;
        theme-provider = "pywal";
      };
      wallpaper = {
        engine-enabled = false;
      };
    };
  };
	  
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
    pywal
  
    hyprshot
    hyprlock
  
    # Main apps
    kitty
    brave
    prismlauncher
	  
    freecad
    blender

    # Other apps
    btop
    neovim
  ];
}
