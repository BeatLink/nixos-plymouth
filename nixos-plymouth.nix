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
        INSTALL_PATH="$out/share/plymouth/themes/nixos-plymouth"
        mkdir -p $INSTALL_PATH
        install -m 755 -vDt $INSTALL_PATH nixos-plymouth.plymouth
        install -m 644 -vDt $INSTALL_PATH resources/*

        # Fix path
        sed -i "s@\/usr\/@$out\/@" $INSTALL_PATH/nixos-plymouth.plymouth"
    '';
}
