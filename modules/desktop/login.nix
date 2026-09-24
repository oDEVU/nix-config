{
  services.displayManager.ly = {
    enable = true;
    settings = { animation = "none"; clear_password = true; };
  };

  systemd.services.ly.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}
