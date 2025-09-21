{
    pkgs ? import <nixpkgs> { },
}:
pkgs.stdenv.mkDerivation {
    pname = "nixos-plymouth-theme";
    version = "0.0.1";

    src = ./src;

    buildInputs = [
        pkgs.git
    ];

    unpackPhase = '''';

    buildPhase = '''';

    installPhase = ''
        # Copy files
        install -m 755 -vDt "$out/share/plymouth/themes/nixos-plymouth" nixos-plymouth.plymouth
        install -m 644 -vDt "$out/share/plymouth/themes/nixos-plymouth" resources/*

        # Fix path
        sed -i "s@\/usr\/@$out\/@" "$out/share/plymouth/themes/nixos-plymouth/nixos-plymouth.plymouth"
    '';
}
