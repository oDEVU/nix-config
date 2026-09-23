{ pkgs, ... }:

let
reshade-vulkan = pkgs.callPackage ./reshade.nix {
  inherit (pkgs)
    fetchFromGitHub cmake pkg-config python3 cacert
    wayland wayland-protocols wayland-scanner
    libxkbcommon fontconfig expat;
};
in
{
  environment.systemPackages = with pkgs; [
    mangohud
    vkbasalt
    goverlay
    reshade-vulkan
  ];

  hardware.graphics.extraPackages = [
    reshade-vulkan
  ];
}
