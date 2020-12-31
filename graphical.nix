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

    steam
    minecraft

    shutter

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
  };

  services = {
    # TODO
    polybar = {};
    random-background = {};
  };
}
