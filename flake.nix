{
    description = "A NixOS Plymouth theme fades into the NixOS Logo";

    outputs = inputs: {
        nixosModules.default = ./default.nix;
    };
}
