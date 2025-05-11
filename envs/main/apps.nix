{ pkgs, ... }:

{
  # Your can find all available options in:
  # https://daiderd.com/nix-darwin/manual/index.html

  environment.systemPackages = with pkgs; [
    git
    # Nix Package
    # https://search.nixos.org/packages?channel=24.05&show=pyenv&from=0&size=50&sort=relevance&type=packages&query=pyenv
    # Derivation Source
    # https://github.com/NixOS/nixpkgs/blob/nixos-24.05/pkgs/development/tools/pyenv/default.nix#L43
    pyenv
  ];

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = true;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      # https://mynixos.com/nix-darwin/option/homebrew.onActivation.cleanup
      cleanup = "zap";
    };

    taps = [
      "homebrew/services"
      # https://github.com/LyraPhase/homebrew-pcloud
      "lyraphase/pcloud"
    ];

    # `brew install`
    brews = [
      # to get an ID of apps in App Store
      "mas"
      "nvm"
      "pnpm"
      "yt-dlp"
      "ffmpeg"
      "imagemagick"
      "katana"
      "gcc"
      "cmake"

      # ************* uninstalled list below ****************
      # "readline"
      # "xz"
      # "sqlite3"
      # "qt"
    ];

    # `brew install --cask`
    casks = [
      "brave-browser"
      "google-chrome"
      "firefox"
      "visual-studio-code"
      "obsidian"
      "readdle-spark"
      "bitwarden"
      "karabiner-elements"
      "microsoft-teams"
      # https://github.com/MonitorControl/MonitorControl?tab=readme-ov-file
      "MonitorControl"
      "discord"
      "whatsapp"
      # screen capture
      "kap"
      "betterdisplay"
      "rectangle"
      "raycast"
      "cryptomator"
      "iterm2"
      "figma"
      "handbrake"
      "pcloud-drive" # lyraphase/pcloud tap is required
      "utm"
      "vmware-fusion"
      "rustdesk"
      "alt-tab"
      # file resolver
      "keka"
      "maccy"
      "obs"
      "blackhole-2ch"
      "blackhole-16ch"
      # https://formulae.brew.sh/cask/orbstack
      "orbstack"

      # ************* uninstalled list below ****************
      # "docker"
      # "clipgrab"
    ];

    masApps = {
      "LINE" = 539883307;
      "Presentify" = 1507246666;
      "Urban VPN Desktop" = 1517772049;
      "Xcode" = 497799835;
      "LadioCast" = 411213048;
      # ************* uninstalled list below ****************
      # "CrystalFetch ISO Downloader" = 6454431289;
      # "Yoink" = 457622435;
    };
  };
}
