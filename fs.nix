{ lib, ... }:
{
  home.file."home" = {
    source = ./override/home;
    recursive = true;
    target = ".";
  };

  xdg.configFile = {
    "nixpkgs/config.nix".source = ./nixpkgs-config.nix;

    "alacritty/alacritty.yml".text = builtins.toJSON {
      env.TERM = "xterm-256color";
      window.dimensions = {
      };

      key_bindings = [
      ];

      draw_bold_text_with_bright_colors = true;

      colors = builtins.fromJSON (builtins.readFile ./alacritty/base16-tomorrow-night.json);
    };
  } // (
    let
      overrides = builtins.attrNames (builtins.readDir ./override/xdg-config);
    in
      builtins.foldl'
      (acc: x: acc // { "${x}" = { recursive = true; source = ./override/xdg-config + "/${x}"; }; })
      {}
      overrides
  );
}
