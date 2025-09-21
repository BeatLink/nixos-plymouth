{
    pkgs ? import <nixpkgs> { },
}:
pkgs.stdenv.mkDerivation {
    pname = "nixos-plymouth-theme";
    version = "master";

    src = ./src;

    dontUnpack = true;
    dontBuild = true;

    installPhase = ''
        # Copy files
        install -m 755 -vDt "$out/share/plymouth/themes/nixos-plymouth" nixos-plymouth.plymouth
        install -m 644 -vDt "$out/share/plymouth/themes/nixos-plymouth" resources/*

        # Fix path
        sed -i "s@\/usr\/@$out\/@" "$out/share/plymouth/themes/nixos-plymouth/nixos-plymouth.plymouth"
    '';
}
