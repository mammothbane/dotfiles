{ config, lib, pkgs, ... }:
{
  home.sessionVariables.SSH_AUTH_SOCK = lib.mkForce "\${SSH_AUTH_SOCK:-$(${pkgs.gnupg}/bin/gpgconf --list-dirs agent-ssh-socket)}";

  services.gpg-agent = {
    enable = true;
    enableExtraSocket = true;
    enableSshSupport = true;
    enableScDaemon = true;

    defaultCacheTtl = 60;
    maxCacheTtl = 120;

    pinentryFlavor = null;

    extraConfig = ''
      pinentry-program ${config.pinentry}/bin/pinentry
    '';
  };

  programs.gpg = {
    enable = true;

    settings = {
      keyserver = "hkps://keys.openpgp.org";
      default-key = "5182 3FB7 8BDE 4316 BE0D  32DC BEC7 D571 1325 BB59";
      keyid-format = "long";
      with-fingerprint = "";
    };
  };
}
