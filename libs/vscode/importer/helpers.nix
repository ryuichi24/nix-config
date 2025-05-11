{ pkgs, ... }:

{
    # function
    importExtensions = path: let
    importedJson = builtins.fromJSON (builtins.readFile path);
    importedExtensions = builtins.map (ext:
    let
      parts = builtins.split "\\." ext;
      publisher = builtins.elemAt parts 0;
      name = builtins.elemAt parts 2;
    in
      # https://github.com/nix-community/nix-vscode-extensions
      pkgs.vscode-marketplace.${publisher}.${name}
  ) (importedJson);
    in importedExtensions;

    # function
    importSettings = path: let
    importedSettings = builtins.fromJSON (builtins.readFile path);
    in importedSettings;

    # function
    importKeyBindings = path: let
    importedKeyBindings = builtins.fromJSON (builtins.readFile path);
    in importedKeyBindings;
}
