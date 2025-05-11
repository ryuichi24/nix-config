#! /bin/bash

[ -f .env ] && export $(grep -v '^#' .env | xargs)

export NIX_USERNAME=$(whoami)
export NIX_HOSTNAME=$(hostname -s)

# Check if 'darwin-rebuild' is available
if command -v darwin-rebuild >/dev/null 2>&1; then
    # If available, use it to switch configurations
    darwin-rebuild switch --flake . --impure
else
    # If not available, use 'nix run' to execute the switch
    nix run nix-darwin -- switch --flake . --impure
fi
