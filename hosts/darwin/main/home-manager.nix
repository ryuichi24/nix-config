# https://davi.sh/blog/2024/02/nix-home-manager/
{ pkgs, nixpkgs, nix-vscode-extensions, home-manager, hostname, username, gitusername, gituseremail, ... }: 

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      # allowBroken = true;
    
    };
    # https://davi.sh/blog/2024/11/nix-vscode/
    overlays = [nix-vscode-extensions.overlays.default];
  };
    
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    verbose = true;
    backupFileExtension = "backup";
  };

  home-manager.users.${username} = {
    programs.home-manager.enable = true;

    home.stateVersion = "23.05";

    # bash files
    home.file = {
      ".bash_profile".source = ./files/bash/.bash_profile;
      ".bashrc".source = ./files/bash/.bashrc;
    };

    home.packages = [
      # pkgs.hello
    ];

    # git
    programs.git = {
      enable = true;
      userName = gitusername;
      userEmail = gituseremail;
      ignores = [ ".DS_Store" ];
      extraConfig = {
          init.defaultBranch = "main";
          push.autoSetupRemote = true;
          core.ignorecase = true;
      };
    }; 

    # vscode
    # https://nixos.wiki/wiki/Visual_Studio_Code
    programs.vscode = {
      enable = true;
      # https://www.reddit.com/r/NixOS/comments/15mohek/installing_vscode_extensions_with_homemanager_not/
      mutableExtensionsDir = false;

      profiles = {
        default = let
        vscodeHelper = import ../../../libs/vscode/importer { inherit pkgs; };
        _userSettings = vscodeHelper.importSettings ./files/vscode/settings.json;
        _keybindings = vscodeHelper.importKeyBindings ./files/vscode/keybindings.json;
        _extensions = vscodeHelper.importExtensions ./files/vscode/extensions.json;
        in {
            userSettings = _userSettings;
            keybindings = _keybindings;
            extensions = _extensions;
        };
      };
    };
  };
}