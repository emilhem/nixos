# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./user-configuration.nix
      ./machines/nix-dell.nix
    ];

  # Supposedly better for SSDs.
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];
  boot.cleanTmpDir = true;

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;

    # NixOS allows either a lightweight build (default) or full build
    # of PulseAudio to be installed. Only the full build has
    # Bluetooth support, so it must be selected here.
    package = pkgs.pulseaudioFull;

    # Enable TCP streaming
    #tcp.enable = true;
    #tcp.anonymousClients.allowedIpRanges =
    #  [ "127.0.0.1" "192.168.1.0/24" ];
  };

  # Enables wireless support via network-manager.
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "term-32n";
    consoleKeyMap = "sv-latin1";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = import ./packages/system.nix { inherit pkgs; };

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services.upower.enable = true;
  systemd.services.upower.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  programs.light.enable = true;
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.ssh.forwardX11 = false;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.forwardX11 = false;

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable redshift
  services.redshift = {
    enable = false;
    brightness.day = "1.0";
    brightness.night = "0.6";
    longitude = "11.98";
    latitude = "57.68";
  };

  services.cron.enable = true;

  # Enable Mopidy music daemon if ./services/mopidy.nix exists
  #services.mopidy = if builtins.pathExists ./services/mopidy.nix
  #  then import ./services/mopidy.nix { pkg = pkgs.mopidy-spotify; }
  #  else { enable = false; };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    dpi = 170;

    #displayManager = {
    #  lightdm.enable = true;
    #  lightdm.greeters.gtk.enable = true;
    #  job.environment = { PATH = "$PATH:$HOME/.local/bin"; };
    #};

    desktopManager = {
      default = "none";
      xterm.enable = false;
    };

    windowManager = {
      i3.enable = true;
      default = "i3";
    };

    # Keyboard
    layout = "se";
    xkbOptions = "ctrl:nocaps";

    libinput.enable = true;
  };

  # MySQL
  services.mysql.package = pkgs.mariadb;
  services.mysql.enable = true; # I start it manually

  # TiMidity++ Daemon
  #systemd.user.services.timidity = {
  #  description = "TiMidity++ Daemon";
  #  after = [ "sound.target" ];
  #  serviceConfig = {
  #    ExecStart = "${pkgs.timidity}/bin/timidity -iA -Os";
  #    ExecStop = "/run/current-system/sw/bin/pkill timidity";
  #  };
  #  wantedBy = [ "default.target" ];
  #};

  virtualisation.docker.enable = true;

  #virtualisation.libvirtd.enable = true;
  #virtualisation.libvirtd.qemuPackage = pkgs.qemu_kvm;

  virtualisation.virtualbox.host.enable = true;
  

  nixpkgs.config = {
    # Enable support for broadcom_sta
    allowUnfree = true;
  };

  # Fonts
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      #corefonts # Microsoft free fonts
      inconsolata
      ubuntu_font_family
      dejavu_fonts
      fira-code
      fira-code-symbols
    ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?
}
