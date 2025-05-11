# https://davi.sh/blog/2024/02/nix-home-manager/
{ pkgs, home-manager, hostname, username, gitusername, gituseremail, ... }: 

{
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
  };
}