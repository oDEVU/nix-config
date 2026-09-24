{ inputs, vars, ... }:

{
  imports = [ inputs.noctalia.nixosModules.default ];

  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
  };

  nix.settings = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  };

  home-manager.sharedModules = [ inputs.noctalia.homeModules.default ];
  home-manager.users.${vars.userName}.programs.noctalia = {
    enable = true;
    settings.theme.mode = "dark";
  };

  my.hyprland.autostart = [
      "noctalia"
    ];

  my.hyprland.extraConfig = ''
    local ipc = "noctalia msg "

    hl.bind(mainMod .. "+Super_L", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
    hl.bind(mainMod .. " + S",     hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
    hl.bind(mainMod .. " + comma", hl.dsp.exec_cmd(ipc .. "settings-toggle"))
    hl.bind("ALT + Tab",           hl.dsp.exec_cmd(ipc .. "window-switcher"))

    hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd(ipc .. "volume-up"))
    hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd(ipc .. "volume-down"))
    hl.bind("XF86AudioMute",         hl.dsp.exec_cmd(ipc .. "volume-mute"))
    hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(ipc .. "brightness-up"))
    hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"))

    hl.window_rule({
      match = { class = "dev.noctalia.Noctalia" },
      float = true,
      size = { 1080, 920 },
    })

    hl.layer_rule({
      name = "noctalia",
      match = { namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$" },
      no_anim = true,
      ignore_alpha = 0.5,
      blur = true,
      blur_popups = true,
    })
  '';
}
