
{ config, pkgs, ... }:
{
  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-e2c988a6-41ef-4648-9540-e42331a490f5".device = "/dev/disk/by-uuid/e2c988a6-41ef-4648-9540-e42331a490f5";
  networking.hostName = "nixos";

  # Allows Hibernation
  security.protectKernelImage = false;

  services.thermald.enable = true;
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
       governor = "powersave";
       turbo = "never";
    };
    charger = {
       governor = "performance";
       turbo = "auto";
    };
  };

  services.tailscale.enable = true;
  services.tailscale.extraUpFlags = [
    "--login-server=https://headscale.emil.hemdal.se"
  ];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # Taken from https://nixos.wiki/wiki/GNOME
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gedit
  ]) ++ (with pkgs.gnome; [
    baobab      # disk usage analyzer
    eog         # image viewer
    simple-scan # document scanner
    yelp        # help viewer
    cheese # webcam tool
    gnome-music
    # gnome-terminal
    epiphany # web browser
    geary # email reader
    # evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game

  ]);


}
