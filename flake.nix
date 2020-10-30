{
  description = "my home manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-20.09";
    flake-util.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hies = {
      url = "github:infinisil/all-hies/master";
      flake = false;
    };

    ownpkgs = {
      url = "github:mammothbane/nixpkgs-own/master";
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
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = import ./nixpkgs-config.nix;
      };

    in {
      overlay = import ./vim-plugins.nix {
        inherit (inputs) darcula ncm2-alchemist ncm2-go ncm2-pyclang ncm2-racer ncm2-tern nvim-typescript ncm2-vim vim-mix-format;
      };

      lib.mkActivator = { username, homeDirectory }: (inputs.home-manager.lib.homeManagerConfiguration {
        configuration = {
          nixpkgs.overlays = [
            self.overlay
          ];

          imports = [ ./main.nix ];
        };

        system = "x86_64-linux";

        inherit pkgs username homeDirectory;
      }).activationPackage;

      defaultApp.x86_64-linux = (
        let
          username      = builtins.getEnv "USER";
          homeDirectory = /. + "/${builtins.getEnv "HOME"}";

          activator     = self.lib.mkActivator { inherit  username homeDirectory; };

        in {
          type = "app";
          program = "${activator}/activate";
        }
      );
    };
}
