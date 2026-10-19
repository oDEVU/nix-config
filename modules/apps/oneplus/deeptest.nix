{ pkgs, ... }:

let
  deeptest2 = pkgs.stdenv.mkDerivation rec {
    pname = "deeptest2";
    version = "1.1.9";

    src = pkgs.fetchurl {
      url = "https://github.com/koaaN/DeepTest2.0/releases/download/V${version}/DeepTest2-linux-x86_64.tar.gz";
      sha256 = "e5d2e0da699bf16e9c09238633af67e8e38ee5d2a6ddc582a3dd92f7dc24c1ff";
    };

    # Added makeWrapper to nativeBuildInputs
    nativeBuildInputs = [ pkgs.autoPatchelfHook pkgs.wrapGAppsHook3 pkgs.makeWrapper ];

    buildInputs = with pkgs; [
          stdenv.cc.cc.lib
          zlib
          glib
          xorg.xcbutilimage
          xorg.xcbutilkeysyms
          xorg.xcbutilrenderutil
          libpulseaudio
          libdrm
          xorg.xcbutilcursor
          xorg.xcbutilwm
          xorg.xcbutil
          xkeyboard_config
          vulkan-loader
          libGL
          libglvnd # Added for proper EGL/GLX dispatching
          wayland
        ];

        unpackPhase = ''
          tar -xzf $src
        '';

        installPhase = ''
           mkdir -p $out/bin
           mkdir -p $out/share/deeptest2
           cp -r DeepTest2/* $out/share/deeptest2/

           makeWrapper $out/share/deeptest2/DeepTest2 $out/bin/deeptest2 \
             --set QT_QPA_PLATFORM "xcb" \
             --set XKB_CONFIG_ROOT "${pkgs.xkeyboard_config}/share/X11/xkb" \
             --set QT_XKB_CONFIG_ROOT "${pkgs.xkeyboard_config}/share/X11/xkb" \
             --set LIBGL_ALWAYS_SOFTWARE "1" \
             --set QT_XCB_FORCE_SOFTWARE_OPENGL "1" \
             --set QTWEBENGINE_DISABLE_GPU "1" \
             --set QTWEBENGINE_CHROMIUM_FLAGS "--no-sandbox --disable-gpu --disable-gpu-compositing" \
             --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath [ pkgs.vulkan-loader pkgs.libglvnd pkgs.libGL pkgs.wayland ]}:/run/opengl-driver/lib:/run/opengl-driver-32/lib" \
             --set LIBGL_DRIVERS_PATH "/run/opengl-driver/lib/dri"
         '';

    meta = with pkgs.lib; {
      description = "DeepTest 2.0 application for OnePlus";
      homepage = "https://github.com/koaaN/DeepTest2.0";
      platforms = [ "x86_64-linux" ];
      license = licenses.unfree;
    };
  };
in
{
  environment.systemPackages = [
    deeptest2
  ];
}
