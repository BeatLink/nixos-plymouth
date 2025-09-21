{
    description = "A plymouth theme for NixOS that pulsates the NixOS logo.";

    outputs = inputs: {
        nixosModules.default = ./default.nix;
    };
}
