{
    description = "A NixOS Plymouth theme displaying a pulsating NixOS Logo";

    outputs = inputs: {
        nixosModules.default = ./modules.nix;
    };
}
