{ config, pkgs, lib, ... }:

{
  nixpkgs.hostPlatform = "x86_64-linux";

  boot.supportedFilesystems = lib.mkForce [ "btrfs" "ext4" "vfat" "xfs" "ntfs" "cifs" ];
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ehci_pci" "usb_storage" "usbhid" "amdgpu" ];
  boot.initrd.kernelModules = [ "amdgpu" ];

  boot.kernelParams = [
    "module_blacklist=nouveau"
    "nouveau.modeset=0"
    "rootdelay=15"
    "amdgpu.ppfeaturemask=0xffffffff"
  ];

  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/6fc9f8f7-1604-4571-a298-0fa1c9c559ac";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/0E48-C054";
    fsType = "vfat";
  };
  fileSystems."/mnt/58111611-84ab-47e2-a26c-78af6584fc0d" = {
    device = "/dev/disk/by-uuid/58111611-84ab-47e2-a26c-78af6584fc0d";
    fsType = "ext4";
    options = [ "nofail" "x-systemd.device-timeout=5s" ];
  };
  fileSystems."/mnt/38DE89444402D734" = {
    device = "/dev/disk/by-uuid/38DE89444402D734";
    fsType = "ntfs";
    options = [ "nofail" "x-systemd.device-timeout=5s" ];
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ libvdpau-va-gl libva-vdpau-driver ];
  };
  chaotic.mesa-git.enable = true;

  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];

  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "lz4";
    memoryPercent = 50;
  };
}
