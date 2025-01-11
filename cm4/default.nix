{
  config,
  lib,
  nixos-hardware,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  inherit (lib) mkDefault;
  cfg = config.hardware.cm4;
  rpi-utils = pkgs.callPackage ../raspberry-pi/packages/rpi-utils {};
in {
  options.hardware.cm4 = {
    enable = mkEnableOption "custom CM4";
  };

  imports =
    [nixos-hardware.nixosModules.raspberry-pi-4]
    ++ [../raspberry-pi/overlays]
    ++ [../raspberry-pi/apply-overlays];

  config = mkIf cfg.enable {
    environment.systemPackages = [rpi-utils];

    hardware.raspberry-pi."4" = {
      apply-overlays-dtmerge.enable = true;
      xhci.enable = mkDefault true;
      overlays = {
        cpu-revision.enable = mkDefault true;
        audremap.enable = mkDefault true;
        spi-gpio40-45.enable = mkDefault true;
      };
    };

    hardware.deviceTree = {
      enable = true;
      filter = "bcm2711-rpi-cm4.dtb";
      overlaysParams = [
        {
          name = "bcm2711-rpi-cm4";
          params = {
            spi = mkDefault "on";
          };
        }
        {
          name = "audremap";
          params = {pins_12_13 = mkDefault "on";};
        }
      ];
    };

    users.groups.spi = {};
    services.udev.extraRules = ''
      SUBSYSTEM=="spidev", KERNEL=="spidev0.0", GROUP="spi", MODE="0660"
    '';
  };
}
