{ pkgs, ... }:
{
  imports = [
    ./xsession.nix
  ];

  home.packages = [
    discord
    slack

    minecraft

    alacritty

    spotify

    shutter

    yubikey-personalization
    yubioath-desktop
  ];

  programs = {
    obs-studio.enable = true;
  };

  # TODO
  services = {
    polybar = {};
    random-background = {};
  };
}
