{ pkgs, nix-homebrew, ...}: 

{
   nix-homebrew = {
      # Install Homebrew under the default prefix
      enable = true;

      # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
      enableRosetta = true;

      # User owning the Homebrew prefix
      user = builtins.getEnv "NIX_USERNAME";

      # in case homebrew is already installed on the machine
      autoMigrate = true;
  };
}