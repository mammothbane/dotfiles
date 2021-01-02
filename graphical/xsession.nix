{ config, pkgs, lib, ... }:

let
  m = keyspec: "${config.xsession.windowManager.i3.config.modifier}+${keyspec}";

in {
  services.picom = {
    enable = true;

    fade = true;
    fadeDelta = 6;

    activeOpacity = "1.0";

    inactiveOpacity = "0.9";

    opacityRule = [
      "99:class_g = 'XScreenSaver'"
    ];
  };

  xsession = {
    enable = true;

    numlock.enable = true;

    windowManager.i3 = {
      enable = true;

      config = {
        modifier = "Mod4";

        bars = [];

        terminal = "${pkgs.alacritty}/bin/alacritty";

        startup = [
          { command = "systemctl --user restart polybar"; always = true; notification = false; }
        ];

        menu = "${config.programs.rofi.package}/bin/rofi -combi-modi drun#run#window#ssh -show combi";

        keybindings = lib.mkOptionDefault {
          ${m "h"} = lib.mkForce "focus left";
          ${m "j"} = lib.mkForce "focus down";
          ${m "k"} = lib.mkForce "focus up";
          ${m "l"} = lib.mkForce "focus right";

          ${m "Shift+h"} = lib.mkForce "move left";
          ${m "Shift+j"} = lib.mkForce "move down";
          ${m "Shift+k"} = lib.mkForce "move up";
          ${m "Shift+l"} = lib.mkForce "move right";

          ${m "b"} = "split h";

          ${m "Control+l"} = "exec ${config.services.screen-locker.lockCmd}";
        };

        gaps = {
          smartBorders = "on";
          smartGaps = false;

          outer = 0;
          inner = 23;
        };
      };
    };
  };
}
