{ config, lib, pkgs, ... }: {
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
}
