{ pkgs, ... }:
{
  imports = [
    ./system.nix
    ./home-brew.nix
    ./nix-core.nix
    ./home-manager.nix
    # ./apps.nix
    ./host-users.nix
  ];
}