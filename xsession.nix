{ config, pkgs, lib, ... }:

let
  m = keyspec: "${config.xsession.windowManager.i3.config.modifier}+${keyspec}";

in {
  home.packages = with pkgs; [
    i3lock
    i3status-rust
    i3lock-fancy

    lighthouse
  ];

  xsession = {
    enable = true;

    numlock.enable = true;

    windowManager.i3 = {
      enable = true;

      config = {
        modifier = "Mod4";

        terminal = "${pkgs.alacritty}/bin/alacritty";

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
        };

        gaps = {
          smartGaps = false;
          outer = 0;
          inner = 23;
        };
      };
    };
  };
}
