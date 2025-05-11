{
    description = "Dev Environment for MacOS";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            # use the same nixpkgs defined in this flake above
            inputs.nixpkgs.follows = "nixpkgs";
        };
        
        # MacOS-specific inputs
        nix-darwin = {
            url = "github:nix-darwin/nix-darwin";
            # use the same nixpkgs defined in this flake above
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-homebrew = {
            url = "github:zhaofengli-wip/nix-homebrew";
            # use the same nixpkgs defined in this flake above
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    # the @ symbol is used to aggregate the destructured input items
    outputs = inputs@ { self, nixpkgs, home-manager, nix-darwin, nix-homebrew, ... }:
    let
    # local variables
    systemArch = "aarch64-darwin"; # or x86_64-darwin for intel mac
    # in order to get environmental variables in Nix, 
    # `--impure` option must be passed at the end of the execution commmand
    env = builtins.getEnv "NIX_ENV";
    username = builtins.getEnv "NIX_USERNAME";
    hostname = builtins.getEnv "NIX_HOSTNAME";
    gitusername = builtins.getEnv "NIX_GIT_USERNAME";
    gituseremail = builtins.getEnv "NIX_GIT_USEREMAIL";

    # "//" merges two attribute sets
    specialArgs = inputs // {
        # "inherit" add values into the attribute set
        inherit systemArch username hostname gitusername gituseremail;
    };

    in {
        darwinConfigurations = {
            # https://github.com/nix-darwin/nix-darwin/blob/6cb36e8327421c61e5a3bbd08ed63491b616364a/flake.nix#L21
            "${hostname}" = nix-darwin.lib.darwinSystem {
                # this make all of the args available in each module below
                inherit specialArgs;
                system = systemArch;
                modules = [
                    home-manager.darwinModules.home-manager
                    nix-homebrew.darwinModules.nix-homebrew
                    ./envs/${env}/default.nix
                ];
        
            };
        };
    };
}