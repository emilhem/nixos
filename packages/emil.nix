{ pkgs }:
with pkgs;

[
  # Applications
  bashCompletion
  blueman
  bluez
  firefox
  gitAndTools.gitFull
  gnome3.dconf
  gnome3.gnome-terminal
  gnupg
  keepassxc
  man
  networkmanager
  networkmanagerapplet
  openssh
  pavucontrol
  pciutils
  pulsemixer
  redshift
  sshfs
  xfce.thunar
  thunderbird
  usbutils
  vlc

  # C/C++ stuff
  gcc6
# gcc7
  gccStdenv
  gnumake
  libcxx
  stdenv
  libcxxStdenv

  # Haskell development
  # haskellPackages.ghc
  # haskellPackages.hlint
  # haskellPackages.cabal-install
  # haskellPackages.cabal2nix

  # For my i3 setup
  i3
  i3status
  i3lock
  dmenu
  compton
  scrot
]
