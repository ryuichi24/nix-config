{ pkgs, ... }:
let
  helpers = import ./helpers.nix { inherit pkgs; };
in
{
  # by wrapping an attribute set with parentheses, you can inherit individual attributes directly.
  # https://nix.dev/manual/nix/2.24/language/syntax.html?highlight=inherit#inheriting-attributes
  inherit (helpers)
    importExtensions
    importSettings
    importKeyBindings;
}