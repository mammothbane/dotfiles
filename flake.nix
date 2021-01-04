{
  description = "my home manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    flake-util.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mammothoverlays.url = "github:mammothbane/nixpkgs-own/master?dir=overlays";
    nix-bisect.url = "github:mammothbane/nixpkgs-own/master?dir=pkgs/nix-bisect";


    hies = {
      url = "github:infinisil/all-hies/master";
      flake = false;
    };


    neuron = {
      url = "github:srid/neuron/master";
      flake = false;
    };

    cachix = {
      url = "github:cachix/cachix/master";
      flake = false;
    };


    darcula = {
      url = "github:blueshirts/darcula/master";
      flake = false;
    };

    ncm2-alchemist = {
      url = "github:pbogut/ncm2-alchemist/master";
      flake = false;
    };

    ncm2-go = {
      url = "github:ncm2/ncm2-go/master";
      flake = false;
    };

    ncm2-pyclang = {
      url = "github:ncm2/ncm2-pyclang/master";
      flake = false;
    };

    ncm2-racer = {
      url = "github:ncm2/ncm2-racer/master";
      flake = false;
    };

    ncm2-tern = {
      url = "github:ncm2/ncm2-tern/master";
      flake = false;
    };

    nvim-typescript = {
      url = "github:mhartington/nvim-typescript/master";
      flake = false;
    };

    ncm2-vim = {
      url = "github:ncm2/ncm2-vim/master";
      flake = false;
    };

    vim-mix-format = {
      url = "github:mhinz/vim-mix-format/master";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-util, ... } @ inputs:
    let
      vim-overlay = (import ./vim-plugins.nix {
        inherit (inputs) darcula ncm2-alchemist ncm2-go ncm2-pyclang ncm2-racer ncm2-tern nvim-typescript ncm2-vim vim-mix-format;
      });

      additional-packages = (self: super:
        {
          cachix = import inputs.cachix;
          neuron = import inputs.neuron {};
          nix-bisect = inputs.nix-bisect;

          direnv = super.direnv.overrideAttrs (old: {
            version = "2.27.0";
          });
        } //
        (import ./pkgs {
          inherit (self) callPackage;
        })
      );

      overlays = [
        vim-overlay
        additional-packages
        inputs.mammothoverlays.overlay
      ];

      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = import ./nixpkgs-config.nix;

        inherit overlays;
      };

      composeOverlays = builtins.foldl' pkgs.lib.composeExtensions (self: super: {});

      home-manager-patched = pkgs.applyPatches {
        name = "home-manager-patched";
        src = inputs.home-manager;
        patches = [
          ./patches/ssh_auth_sock.patch
          ./patches/x-targets.patch
        ];
      };

      mkActivator = { username, homeDirectory, graphical ? false }:
        (import "${home-manager-patched}/modules" {
          check = true;

          inherit pkgs;

          configuration = {
            nixpkgs.overlays = self.overlays;

            imports = [
              ./main.nix
            ]
            ++ pkgs.lib.optional graphical ./graphical;

            home = {
              inherit username homeDirectory;
            };
          };
        }).activationPackage;

      username      = builtins.getEnv "USER";
      homeDirectory = /. + "/${builtins.getEnv "HOME"}";

      app = activator: {
        type = "app";
        program = "${activator}/activate";
      };

      packages = {
        minimal = mkActivator { inherit username homeDirectory; };
        graphical = mkActivator {
          inherit username homeDirectory;
          graphical = true;
        };
      };

      apps = builtins.mapAttrs (name: value: app value) packages;

    in {
      inherit overlays;

      lib = {
        inherit mkActivator;
      };

      nixosModule = ({ config, pkgs, lib, ... }: {
        environment.systemPackages = [
          (let
            users = config.users.users;

            extractName = attrName:
            let maybeName = users.${attrName}.name;
            in if maybeName == null then attrName else maybeName;

            isHomeManageable = attrName: let
              home = users.${attrName}.home;
              pref = lib.flip lib.strings.hasPrefix home;
            in
            home != null &&
            (
              (extractName attrName) == "root" ||
              pref "/home"
              );

              manageableUsers = builtins.filter isHomeManageable (builtins.attrNames users);

              userDb = pkgs.writeText "users.json" (builtins.toJSON (
                builtins.foldl'
                (acc: x:
                  let
                    username = extractName x;
                    homeDirectory = users.${x}.home;
                    activator = mkActivator { inherit username homeDirectory; };
                  in acc // {
                    ${username} = "${activator}/activate";
                  })
                {}
                manageableUsers
                ));

          in pkgs.writeShellScriptBin "hm-system" ''
                set -uo pipefail

                me=$(id -u -n)

                activator=$(<"${userDb}" "${pkgs.jq}/bin/jq" -re ".\"$me\"")

                if [ $? -ne 0 ]; then
                  echo "this user is not capable of using $(basename ''${BASH_SOURCE[0]}) (no home directory in nixos)" >&2

                  exit 1
                fi

                exec "$activator"
          '')
        ];
      });

      packages.x86_64-linux = packages;
      apps.x86_64-linux = apps;

      defaultPackage.x86_64-linux = packages.minimal;
      defaultApp.x86_64-linux = apps.minimal;
    };
}
