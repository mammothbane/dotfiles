# lieer doesn't seem to want to sync with the
# config files as-generated, giving up for now.

{ config, ... }:
{
  accounts.email = {
    maildirBasePath = "${config.xdg.configHome}/mail";

    accounts = {
      personal = {
        primary = true;
        address = "itsamammoth@gmail.com";
        realName = "Nathan Perry";

        aliases = [
          "np@nathanperry.dev"
          "avaglir@gmail.com"
          "nmp2@williams.edu"
        ];

        flavor = "gmail.com";

        notmuch.enable = true;

        lieer = {
          enable = true;
          sync = {
            enable = true;
            frequency = "*:0/25";
          };
        };
      };

      tulip = {
        address = "nathan.perry@tulip.co";
        realName = "Nathan Perry";

        flavor = "gmail.com";

        notmuch.enable = true;

        lieer = {
          enable = true;
          sync = {
            enable = true;
            frequency = "*:0/25";
          };
        };
      };
    };
  };


  programs = {
    notmuch.enable = false;
    lieer.enable = config.programs.notmuch.enable;
  };

  services.muchsync = {};
}
