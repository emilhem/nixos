{ pkgs }:
with pkgs;

[
  # Applications
  termite
  firefox
  dropbox-cli
  drive
  pass
  keybase
  pavucontrol
  stow
  steam
  rofi-pass
  gitAndTools.gitFull
  bashCompletion
  gnupg
  openssh
  usbutils
  pciutils
  virtmanager
  sshfs

  # Haskell development
  haskellPackages.ghc
  haskellPackages.hlint
  haskellPackages.cabal-install
  haskellPackages.cabal2nix

  # For my XMonad setup
  rofi
  dunst
  sxhkd
  pamixer
  pavucontrol
  compton
  scrot
  imagemagick
  ncmpcpp
  xorg.xmessage
  libnotify
]
