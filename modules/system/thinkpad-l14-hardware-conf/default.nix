{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp4s0.useDHCP = true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  # services.power-profiles-daemon.enable = false;
  # services.tlp = {
  #   enable = true;
  #   settings = {
  #     CPU_SCALING_ON_BAT="powersave";
  #     CPU_SCALING_ON_AC="performance";
  #     CPU_MAX_PERF_ON_AC=100;
  #     CPU_MAX_PERF_ON_BAT=50;
  #   };
  # };

  # disabled so I can use expo,
  # should re-enable this
  networking.firewall.enable = false;

  networking.hostName = "nixlen"; # Define your hostname.
}
