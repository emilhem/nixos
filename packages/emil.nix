{ pkgs }:
with pkgs;

[
  # Applications
  alsaUtils
  bashCompletion
  blueman
  bluez
  firefox
  gitAndTools.gitFull
  gnome3.dconf
  gnome3.gnome-terminal
  gnupg
  keepassx2
  man
  mupdf
  networkmanager
  networkmanagerapplet
  openssh
  pavucontrol
  pciutils
  psmisc
  pulsemixer
  redshift
  sshfs
  sublime3
  tdesktop
  xfce.thunar
  thunderbird
  zip
  unzip
  usbutils
  vlc
  vscode-with-extensions

  # MySQL
#  mysql

  # Node.js
  nodejs-8_x

  # Libs
  ffmpeg-full

  # Python
  python3Full

  # C/C++ stuff
#  gcc6
  gcc7
  gnumake
  patchelf

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
#  compton
#  scrot

  # Network Course (Chalmers)
#  bochs
#  perl
]
