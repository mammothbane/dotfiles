{ pkgs, config, ... }:
{
  imports = [
    ./xsession.nix
    ./dunst.nix
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

    yubikey-personalization
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
    polybar = {
      enable = true;
      package = pkgs.polybar.override {
        i3GapsSupport = true;
        alsaSupport   = true;
        pulseSupport  = true;

        inherit (pkgs) wirelesstools libpulseaudio alsaLib;
        i3-gaps = config.xsession.windowManager.i3.package;
      };

      config = {
        "bar/bottom" = {
          width = "100%";
          height = "3%";
          radius = 0;

          font-0 = "Fira Code Mono:size=10";

          modules-right = "date battery pulse";
          modules-left = "i3";

          module-margin = 2;

          tray-position = "right";
          tray-maxsize = 16;
          tray-padding = 2;
          tray-background = "#88666666";

          background = "#88888888";

          pseudo-transparency = true;

          bottom = true;
        };

        "module/i3" = {
          type = "internal/i3";
          enable-scroll = false;
          label-visible-padding = 10;
          label-focused-underline = "#fba922";
        };

        "module/pulse" = {
          type = "internal/pulseaudio";
        };

        "module/battery" = {
          type = "internal/battery";
          battery = "BAT1";
          adapter = "ADP1";
          poll-interval = 5;
        };

        "module/date" = {
          type = "internal/date";
          internal = 5;
          date = "%m.%d";
          time = "%H:%M";
          label = "%time%  %date%";
        };
      };

      script = ''
        polybar bottom &
      '';
    };

    pasystray.enable = true;

    unclutter = {
      enable = true;
      timeout = 5;
    };

    screen-locker = {
      enable = true;
      lockCmd = "${pkgs.i3lock-fancy}/bin/i3lock-fancy";
    };

    random-background = {};
  };
}
