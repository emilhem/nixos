{ pkgs }:
with pkgs;

[
  # Applications
  firefox
  thunderbird
  pulsemixer
  pavucontrol
  gitAndTools.gitFull
  bashCompletion
  gnupg
  openssh
  usbutils
  pciutils
  sshfs

  # Haskell development
  # haskellPackages.ghc
  # haskellPackages.hlint
  # haskellPackages.cabal-install
  # haskellPackages.cabal2nix

  # For my i3 setup
  i3
  compton
  scrot
]
