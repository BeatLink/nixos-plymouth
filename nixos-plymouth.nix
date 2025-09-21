{
    pkgs ? import <nixpkgs> { },
}:
pkgs.stdenv.mkDerivation {
    pname = "nixos-plymouth";
    version = "master";

    src = ./src;

    installPhase = ''
        # Copy files
        INSTALL_PATH="$out/share/plymouth/themes/nixos-plymouth"
        mkdir -p $INSTALL_PATH
        cp -v nixos-plymouth.plymouth $INSTALL_PATH
        cp -Rv resources $INSTALL_PATH

        # Fix path
        sed -i "s@\/usr\/@$out\/@" $INSTALL_PATH/nixos-plymouth.plymouth"
    '';
}
