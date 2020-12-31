{ pkgs, ... }:
{
  imports = [
    ./xsession.nix
  ];

  pinentry = pkgs.pinentry_qt5;

  home.packages = with pkgs; [
    discord
    slack
    chromium
    spotify
    vscodium

    minecraft

    alacritty

    shutter

    yubikey-personalization
    yubioath-desktop

    jetbrains.idea-ultimate
    jetbrains.clion
    jetbrains.pycharm-professional
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
