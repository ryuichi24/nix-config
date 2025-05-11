{ pkgs, username, ... }:

#  macOS's System configuration
#  All the configuration options are documented here:
#  https://daiderd.com/nix-darwin/manual/index.html#sec-options
{
  system = {
    stateVersion = 5;
    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    # activationScripts.postUserActivation.text = '';
    activationScripts = {
      postUserActivation = {
        text =  ''
        # change the default shell to bash
        # activateSettings -u will reload the settings from the database and apply them to the current session,
        # so we do not need to logout and login again to make the changes take effect.
        /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
      '';
      };
    };

    defaults = {
      menuExtraClock = {
        Show24Hour = true;  # show 24 hour clock
      };

      # other macOS's defaults configuration.

      # finder configs
      finder = {
        # Show all file extensions: When set to true, the extensions of all files are displayed.
        AppleShowAllExtensions = true;

        # Show hidden files: When set to true, files starting with a dot (.) that are usually hidden will be displayed.
        AppleShowAllFiles = true;

        # Hide desktop icons: When set to false, icons on the desktop will be hidden.
        CreateDesktop = false;

        # Disable warning whe changing file extensions: When set to false, the warning that appears when changing file extensions will be disabled.
        FXEnableExtensionChangeWarning = false;

        # Show path bar: When set to true, the file path will be displayed at the bottom of the Finder window.
        ShowPathbar = true;

        # Show status bar: When set to true, information about the selected items (such as file count and size) will be displayed
        # at the bottom of the Finder window. 
        ShowStatusBar = true;
      };

      # dock configs
      dock = {
        # Auto-hide Dock: When set to true, the Dock will automatically hide.
        autohide = true;

        # Hide recently used applications: When set to false, recent apps will no longer appear in the Dock. 
        show-recents = false;

        # Dock icon size: Sets the icon size in pixels. 50px is a moderate size.
        tilesize = 25;

        # Dock icon magnification: When set to true, icons will enlarge when hovered over with the mouse.
        magnification = true;

        # Icon size on magnification: Sets the icon size in pixels when hovered over. 
        largesize = 32;

        # Icon size on magnification: Sets the icon size in pixels when hovered over. 64px is a moderate enlargement.
        orientation = "left";

        # Window minimize effect: "scale" uses a shrinking effect. 
        mineffect = "scale";

        # Disable application launch animation: When set to false, the launch animation will be disabled.
        launchanim = false;

        # apps to be showen on the dock
        # persistent-apps = [
        #   "/System/Applications/Calendar.app"
        #   "${pkgs.obsidian}/Applications/Obisidian.app"
        # ]
      };

      WindowManager = {
        # https://daiderd.com/nix-darwin/manual/index.html#opt-system.defaults.WindowManager.EnableStandardClickToShowDesktop
        EnableStandardClickToShowDesktop = false;
      };

      # configs
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        KeyRepeat = 2;
        # https://daiderd.com/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain._HIHideMenuBar
        _HIHideMenuBar = false;
      };
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;
}
