{
  programs.ssh = {
    enable = true;
    controlMaster = "no";
    controlPersist = "10m";
    forwardAgent = true;

    matchBlocks = let
      viaProxy = { host, user, name ? null }: let
        config = {
          inherit user;
          hostname = host;
          proxyJump = "vpn.tulip.co";
        };
      in

      { "${host}" = config; }
        // (if name != null then { "${name}" = config; } else {});

      nonProxied = {
        "somali-derp.com" = {
          user = "mammothbane";
        };

        "nathanperry.dev" = {
          user = "mammothbane";
        };

        "vpn.tulip.co" = {
          user = "developer";
        };
      };

      proxied = [
        { user = "ubuntu"; host = "deploy.bulb.cloud"; name = "tulip-staging"; }
        { user = "ubuntu"; host = "deploy.tulip.co"; name = "tulip-prod"; }
        { user = "ubuntu"; host = "deploy-eu-central-1.tulipintra.net"; name = "tulip-eu"; }
        { user = "ubuntu"; host = "deploy-eu-central-1.dmgmori-tulipintra.net"; name = "tulip-dmgm"; }
      ];
    in
    builtins.foldl' (acc: x: acc // (viaProxy x))
      nonProxied
      proxied;

    extraConfig = ''
      StreamLocalBindUnlink yes
    '';
  };
}
