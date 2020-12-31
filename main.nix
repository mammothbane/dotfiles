{
  pkgs,
  lib,
  config,
  localConfigFile ? ./local.nix,
  ...
}:

{
  imports = [
    ./git.nix
    ./vim.nix
    ./shells.nix
    ./packages.nix
    ./fs.nix
    ./env.nix
    ./email.nix
  ];

  options = with lib; {
    pinentry = mkOption {
      description = "pinentry program";
      type = types.package;
      default = pkgs.pinentry;
    };
  };

  config = {
    home.stateVersion = "20.09";
    news.display = "silent";

    programs = {
      bat = {
        enable = true;
        config = {
          pager = "less -FR";
          theme = "OneHalfDark";
        };
      };

      broot = {
        enable = true;

        enableZshIntegration = true;
        enableBashIntegration = true;
      };

      go = {
        enable = true;
        goPath = "src/go";
      };

      htop = {
        enable = true;
        delay = 6;
        hideThreads = true;
        hideUserlandThreads = true;
        highlightBaseName = true;
      };

      lesspipe.enable = true;

      gpg = {
        enable = true;

        settings = {
          keyserver = "hkps://keys.openpgp.org";
        };
      };

      # TODO
      irssi = {};
      starship = {};
    };

    services = {
      gpg-agent = {
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

      keybase.enable = true;
      lorri.enable = true;

      spotifyd.enable = true;
    };

    systemd.user.startServices = true;
  };
}
