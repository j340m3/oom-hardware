{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkMerge mkOption types;
  cfg = config.hardware.raspberry-pi."4".overlays.spi-gpio40-45;
in {
  options.hardware.raspberry-pi."4".overlays.spi-gpio40-45 = {
    enable = mkEnableOption ''overlay enable'';
    name = mkOption {
      type = types.str;
      default = "spi-gpio40-45";
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      hardware.deviceTree.overlays = [
        {
          name = "${cfg.name}";
          filter = "bcm2711-rpi-*.dtb";
          dtsFile = ./source/spi-gpio40-45.dts;
        }
      ];
    })
  ];
}
