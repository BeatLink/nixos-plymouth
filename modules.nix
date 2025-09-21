{
    pkgs,
    lib,
    config,
    ...
}:
let
    cfg = config.nixos-pulse;
    nixos-pulse = pkgs.callPackage ./default.nix {
        theme = cfg.theme;
    };
in
{
    options.nixos-pulse = {
        enable = lib.mkEnableOption "nixos-pulse";
        theme = lib.mkOption {
            type = lib.types.enum [
                "dark"
                "light"
            ];
            default = "dark";
        };
        duration = lib.mkOption {
            type = lib.types.float;
            default = 0.0;
        };
    };
    config = {
        boot.plymouth = lib.mkIf cfg.enable {
            enable = true;
            themePackages = [ nixos-pulse ];
            theme = cfg.theme;
        };
        systemd.services.plymouth-quit =
            lib.mkIf (cfg.enable && cfg.duration > 0.0)
                {
                    preStart = "${pkgs.coreutils}/bin/sleep ${toString cfg.duration}";
                };
    };
}
