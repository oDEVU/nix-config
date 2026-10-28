{ pkgs }:

let
  devTools = with pkgs; [
    clang cmake ninja pkg-config meson conan
    wayland-scanner
  ];
  devLibs = with pkgs; [
    vulkan-headers vulkan-loader vulkan-validation-layers libGL sdl3 wayland wayland-protocols
    libx11 libxrandr libxinerama libxcursor libxi libXScrnSaver libXtst libxcb libxkbcommon
    stdenv.cc.cc.lib
    boost ncurses
    wlr-protocols cairo libffi glib expat
    libxdmcp # <-- poprawiony warning
  ];

  pkgNames = builtins.concatStringsSep ", " (map (p: p.pname or p.name) devLibs);
in pkgs.mkShell {
  packages = devTools ++ devLibs;

  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath devLibs}:$LD_LIBRARY_PATH"
    export PKG_CONFIG_PATH="${pkgs.lib.makeSearchPathOutput "dev" "lib/pkgconfig" devLibs}:${pkgs.lib.makeSearchPath "lib/pkgconfig" devLibs}:$PKG_CONFIG_PATH"

    cat << 'EOF'
    -----------------------------------
    ▄▖    ▄▖▌   ▜ ▜   ▜      ▌   ▌
    ▌ ▟▖▟▖  ▚ ▛▌█▌▐ ▐   ▐ ▛▌▀▌▛▌█▌▛▌
    ▙▖▝ ▝   ▄▌▌▌▙▖▐▖▐▖  ▐▖▙▌█▌▙▌▙▖▙▌

    Libs available: ${pkgNames}
    -----------------------------------
    EOF
  '';
}
