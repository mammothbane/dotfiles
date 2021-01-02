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
    };
  };
}
