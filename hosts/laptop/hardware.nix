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

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/735f1344-389f-4e34-8d5a-9dce7d0d5931";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/536400d4-75f3-4d67-aeaf-9165d8abb0ac";
    fsType = "ext4";
  };
  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/BCA2-4C4C";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ libvdpau-va-gl libva-vdpau-driver ];
  };

  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];

  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "lz4";
    memoryPercent = 50;
  };
}
