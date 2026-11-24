{ config, inputs, lib, pkgsUnstable, vars, ... }:

let
  hyprglass = pkgsUnstable.hyprlandPlugins.mkHyprlandPlugin {
    pluginName = "hyprglass";
    version = inputs.hyprglass.shortRev or "unstable";
    src = inputs.hyprglass;
    hyprland = config.programs.hyprland.package;

    nativeBuildInputs = [ pkgsUnstable.wayland-scanner ];
    dontConfigure = true;
    enableParallelBuilding = true;
    makeFlags = [ "HYPRGLASS_VERSION=${inputs.hyprglass.shortRev or "unstable"}" ];

    installPhase = ''
      runHook preInstall
      install -Dm755 hyprglass.so $out/lib/libhyprglass.so
      runHook postInstall
    '';

    meta = {
      description = "Liquid Glass effects for Hyprland";
      homepage = "https://github.com/hyprnux/hyprglass";
      license = lib.licenses.bsd3;
    };
  };

in
{
  home-manager.users.${vars.userName} = {
    programs.kitty = {
      enable = true;
      package = pkgsUnstable.kitty;
      # Noctalia keeps generating the palette; do not replace it with a Kitty theme.
      extraConfig = ''
        include themes/noctalia.conf
        background_opacity 1.0
      '';
    };

    programs.noctalia.settings = {
      shell = {
        settings_window_translucent = true;
        panel.transparency_mode = "glass";
      };
      bar.default.background_opacity = 0.55;
      dock.background_opacity = 0.55;
      notification.background_opacity = 0.65;
      osd.background_opacity = 0.55;
    };
  };

  my.hyprland.extraConfig = lib.mkAfter ''
    hl.plugin.load("${hyprglass}/lib/libhyprglass.so")

    if hl.plugin.hyprglass then
      local hg = hl.plugin.hyprglass


      hg.preset("liquidass", {
        blur_strength = 0.15,
        blur_iterations = 3,
        noise_strength = 0.0,
        edge_thickness_px = 15,
        edge_height = 15,
        refraction_strength = 2.0,
        fresnel_reflection = 0.5,
        chromatic_aberration = 0.55,
        fresnel_strength = 0.7,
        specular_strength = 0.5,
        bevel_strength = 0.5,
        bevel_size = 5,
        lens_distortion = 0.0,
        focus_light = 0.5,
        self_sample = 0.0,
        dark = {
          brightness = 1.0,
          contrast = 1.0,
          saturation = 1.0,
          adaptive_dim = 0.1,
          tint_color = 0x18202a18,
        },
      })

      hg.preset("liquidass-ui", {
        inherits = "liquidass",
        edge_thickness_px = 10,
        edge_height = 20,
        refraction_strength = 2.0,
        focus_light = 0.0,
      })

      hg.config({
        enabled = true,
        default_theme = "dark",
        default_preset = "liquidass",
        manage_window_blur = true,
        layers = {
          enabled = true,
          preset = "liquidass-ui",
          manage_blur = true,
          mask_mode = "contour",
          mask_threshold = 0.3,
          mask_feather = 0.05,
          live_resample = true,
          live_resample_fps = 30,
        },
        subsurfaces = { enabled = true, preset = "liquidass-ui" },
      })

      -- No whitelist: other applications' layer-based UI should get glass too.
      hg.layer("noctalia-wallpaper", { exclude = true })
      hg.layer("noctalia-lockscreen", { exclude = true })
    end

    -- Kitty uses compositor opacity, not its native background transparency.
    hl.window_rule({
      match = { class = "^(kitty)$" },
      opacity = "0.75 override 0.75 override 1.0 override",
    })

    -- Other application contents stay opaque; only standalone shell UI is faded.
    hl.window_rule({
      match = { class = "^(polkit-gnome-authentication-agent-1|dev[.]noctalia[.]Noctalia([.]Settings)?)$" },
      opacity = "0.75 0.75 1.0",
      tag = "+hyprglass_preset_liquidass-ui",
    })

    hl.window_rule({
      match = { class = "^(steam_app_.*|gamescope|mpv|vlc|org[.]videolan[.]VLC)$" },
      opacity = "1.0 override 1.0 override 1.0 override",
      tag = "+hyprglass_disabled",
    })

    -- Fullscreen stays opaque without a tag that can outlive fullscreen state.
    hl.window_rule({
      match = { fullscreen = true },
      opacity = "1.0 override 1.0 override 1.0 override",
    })
  '';
}
