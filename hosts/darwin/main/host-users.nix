
{ pkgs, hostname, username, ... }:

{
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  users.knownUsers = [ username ];

  users.users."${username}"= {
    home = "/Users/${username}";
    description = username;
    # check if the default shell is updated by "dscl . -read /Users/${username} UserShell"
    shell = pkgs.bash;
    # https://www.gitmemories.com/LnL7/nix-darwin/issues/811?utm_source=chatgpt.com
    uid = 501;
  };

  nix.settings.trusted-users = [ username ];
}
