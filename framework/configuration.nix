# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <nixos-hardware/framework/13-inch/amd-ai-300-series>
      ./hardware-configuration.nix
    ];

  # Kernel Choice
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Firmware Update
  services.fwupd.enable = true;

  # Graphics
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };

  # Btrfs Scrubbing
  services.btrfs.autoScrub.enable = true;
  services.btrfs.autoScrub.interval = "weekly";

  # Swap
  swapDevices = [ { device = "/swap/swapfile"; } ];

  # Power Management
  powerManagement.enable = true;
  services.thermald.enable = true;
  # services.tlp.enable = true;
  services.logind.lidSwitch = "hybrid-sleep";
  services.logind.lidSwitchExternalPower = "hybrid-sleep";
  services.logind.lidSwitchDocked = "ignore";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  hardware.wirelessRegulatoryDatabase = true;
  boot.extraModprobeConfig = ''
    options cfg80211 ieee80211_regdom="SE"
  '';

  # Enable networking
  networking.networkmanager.enable = true;

  # Fingerprint
  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };
  services.fprintd.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LANGUAGE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_MESSAGES = "en_US.UTF-8";
    LC_COLLATE = "sv_SE.UTF-8";
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.gnome.extraGSettingsOverridePackages = [ pkgs.mutter ];
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.mutter]
    experimental-features=['scale-monitor-framebuffer']
  '';

  # Inspired by https://nixos.wiki/wiki/GNOME
  environment.gnome.excludePackages = (with pkgs; [
    decibels    # Sound Player
    gnome-photos
    gnome-tour
    gedit
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:escape";
  };
  console.useXkbConfig = true;

  # Virtualization
  virtualisation.docker.enable = true;

  # AI / LLM
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    environmentVariables = {
      HSA_OVERRIDE_GFX_VERSION = "11.0.2";
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.e = {
    isNormalUser = true;
    description = "Emil Hemdal";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      gnomeExtensions.appindicator      
      gnome-tweaks

      librewolf
      libreoffice-fresh
      libreoffice-fresh-unwrapped
      keepassxc
      nextcloud-client
      obsidian
      signal-desktop
      spotify
      telegram-desktop
      thunderbird
      vscode-fhs
      whatsapp-for-linux
      gnome-decoder
      vlc

      lmstudio
      ollama
      alpaca

      libqalculate
    ];
  };

  # LocalSend
  programs.localsend.enable = true;
  programs.localsend.openFirewall = true;

  # Steam
  programs.steam.enable = true;

  # Do Not Install firefox.
  programs.firefox.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    vim
    neovim
    wget

    mullvad
    mullvad-vpn
    tkey-ssh-agent
    gnupg
    gpgme
    gpg-tui

    qrencode

    dig
    
    zoxide

    hunspell
    hunspellDicts.sv_SE
    hunspellDicts.en_US
    hunspellDicts.en_GB-ise

    clinfo
  ];

  services.mullvad-vpn.enable = true;
  #services.avahi.enable = true;

  programs.kdeconnect.enable = true;
  programs.ssh.startAgent = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.direnv.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
