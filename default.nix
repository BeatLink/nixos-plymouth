{ pkgs, ... }:
{
    config.boot.plymouth = {
        enable = true;
        themePackages = [ (pkgs.callPackage ./nixos-plymouth.nix { }) ];
        theme = "nixos-plymouth";
    };
}
