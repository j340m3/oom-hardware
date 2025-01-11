{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkMerge mkOption types;
  cfg = config.hardware.raspberry-pi."4".overlays.i2c-rtc;
in {
  options.hardware.raspberry-pi."4".overlays.i2c-rtc = {
    enable = mkEnableOption ''overlay enable'';
    name = mkOption {
      type = types.str;
      default = "i2c-rtc";
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      hardware.deviceTree.overlays = [
        {
          name = "${cfg.name}";
          filter = "bcm2711-rpi-*.dtb";
          dtsFile = ./source/i2c-rtc.dts;
        }
      ];
    })
  ];
}
