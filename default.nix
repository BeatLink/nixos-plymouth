{ pkgs, ... }:
{
    config = {
        boot.plymouth = {
            enable = true;
            themePackages = [ (pkgs.callPackage ./default.nix { }) ];
            theme = "nixos-pulse";
        };
    };
}
