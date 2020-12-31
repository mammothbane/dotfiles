{ pkgs, ... }:
{
  imports = [
    ./xsession.nix
  ];

  pinentry = pkgs.pinentry_qt5;

  home.packages = with pkgs; [
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
