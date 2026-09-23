{ stdenv
, lib
, fetchFromGitHub
, cmake
, pkg-config
, python3
, cacert
, wayland
, wayland-protocols
, wayland-scanner
, libxkbcommon
, fontconfig
, expat
}:

stdenv.mkDerivation rec {
  pname = "reshade-vulkan-wayland";
  version = "6.8.0-beta.2";

  src = fetchFromGitHub {
    owner = "TheForgotten69";
    repo = "reshade";
    rev = "v${version}";
    fetchSubmodules = true;
    hash = "sha256-cT9nQtNj20YICdi4PQAybux/fxegIeANkVCws+GJvrA=";
  };

  __noChroot = true;

  nativeBuildInputs = [
    cmake
    pkg-config
    (python3.withPackages (ps: with ps; [ jinja2 ]))
    wayland-scanner
    cacert
  ];

  buildInputs = [
    wayland
    wayland-protocols
    libxkbcommon
    fontconfig
    expat
  ];

  cmakeFlags = [
    "-DRESHADE_VERSION=6.8.0"
  ];

  NIX_CFLAGS_COMPILE = "-Wno-error=format-security";

  SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";
  GIT_SSL_CAINFO = "${cacert}/etc/ssl/certs/ca-bundle.crt";
  NIX_SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";

  postPatch = ''
    grep -rl -- '-m glad' . | while read -r f; do
      sed -i -e 's/\(COMMAND[^)]*-m glad[^)]*\)/\1 --reproducible/' "$f"
    done
    find . -name "CMakeLists.txt" -exec sed -i 's/glad_add_library(\([A-Za-z0-9_]*\)/glad_add_library(\1 REPRODUCIBLE/' {} + 2>/dev/null || true
  '';

  # Safely update library_path structurally via Python without guessing its old value
  postInstall = ''
    for json in $out/share/vulkan/implicit_layer.d/*.json; do
      if [ -f "$json" ]; then
        ${python3.interpreter} -c "
import json
with open('$json', 'r') as f:
    data = json.load(f)
data['layer']['library_path'] = '$out/lib/reshade/ReShade64.so'
with open('$json', 'w') as f:
    json.dump(data, f, indent=4)
"
      fi
    done
  '';

  meta = with lib; {
    description = "ReShade Vulkan/Wayland native port compiled from source";
    homepage = "https://github.com/TheForgotten69/reshade";
    platforms = platforms.linux;
  };
}
