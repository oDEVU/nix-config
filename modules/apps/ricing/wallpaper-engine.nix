{ pkgs, lib, vars, ... }:

let
  wallpiper = pkgs.stdenv.mkDerivation {
    pname = "wallpiper";
    version = "2.1.0";

    src = pkgs.fetchFromGitHub {
      owner = "ejalxndr";
      repo = "wallpiper";
      rev = "e9e191fdd7e7f1f86ea64e45d57537dd0776a51e"; # v2.1.0
      hash = "sha256-/VMpQ2qK8MHDATAQoI//8vC6hTxvETjWxxL2ltS6MO0=";
      fetchSubmodules = true;
    };

    nativeBuildInputs = with pkgs; [
      gnumake
      pkg-config
      wayland-scanner
    ];

    buildInputs = with pkgs; [
      dbus
      libgbm
      libglvnd
      libx11
      libxrandr
      vulkan-headers
      vulkan-loader
      wayland
      wayland-protocols
    ];

    hardeningDisable = [ "all" ];

    dontConfigure = true;
    enableParallelBuilding = true;

    buildPhase = ''
      runHook preBuild
      make build-core build-hyprland
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out/lib/wallpiper $out/bin
      install -m755 build/release/wallpiperd                      $out/lib/wallpiper/
      install -m755 build/release/wallpiperctl                    $out/lib/wallpiper/
      install -m755 build/release/libwallpiper-preload.so         $out/lib/wallpiper/
      install -m755 build/release/libVkLayer_wallpiper_capture.so $out/lib/wallpiper/
      install -m644 build/release/dwmapi.dll                      $out/lib/wallpiper/
      install -m755 build/release/wallpiper-portal-hyprland       $out/lib/wallpiper/
      ln -s $out/lib/wallpiper/wallpiperd   $out/bin/wallpiperd
      ln -s $out/lib/wallpiper/wallpiperctl $out/bin/wallpiperctl
      runHook postInstall
    '';

    meta = {
      description = "Wallpaper Engine translation layer for Wayland/X11 compositors";
      homepage = "https://github.com/ejalxndr/wallpiper";
      license = lib.licenses.mit;
      platforms = [ "x86_64-linux" ];
      mainProgram = "wallpiperd";
    };
  };
in
{
  my.hyprland.autostart = [
    "sh -c 'sleep 5; env > /tmp/wp-env-auto.txt; WALLPIPER_PORTAL=hyprland exec wallpiperd > /tmp/wallpiperd-auto.log 2>&1'"
  ];

  home-manager.users.${vars.userName} = {
    home.packages = [ wallpiper ];
  };
}
