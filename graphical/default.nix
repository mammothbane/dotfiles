{ pkgs, config, ... }:
{
  imports = [
    ./xsession.nix
    ./dunst.nix
    ./polybar.nix
  ];

  pinentry = pkgs.pinentry_qt5;

  home.packages = with pkgs; [
    discord
    slack
    spotify
    chromium
    tor-browser-bundle-bin

    steam
    minecraft

    shutter
    dolphin

    xclip

    yubioath-desktop

    alacritty
    vscodium
    jetbrains.idea-ultimate
    jetbrains.clion
    jetbrains.pycharm-professional
  ];

  programs = {
    obs-studio.enable = true;
    feh.enable = true;

    rofi = {
      enable = true;

      font = "Fira Code Mono 14";
      theme = "Arc-Dark";
    };

    # TODO
    browserpass = {};
  };

  services = {
    pasystray.enable = true;

    unclutter = {
      enable = true;
      timeout = 5;
    };

    screen-locker = {
      enable = true;
      lockCmd = "${pkgs.i3lock-fancy}/bin/i3lock-fancy";
    };

    random-background = {
      enable = true;
      imageDirectory = "%h/.local/wallpapers";
      interval = "5m";
    };
  };
}
