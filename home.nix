# This package just delegates to main.nix with the default local config
# file. This is used for non-NixOS installs of home-manager.

# NixOS installs should call main.nix directly if they want to control
# the location of the local config file (e.g. to have a separate one
# per user).

(import ./main.nix) {}
