{ pkgs }:
with pkgs;

[
  acpi
  coreutils
  cryptsetup
  curl
  ghostscript
  gtk3
  openssh
  openssl
  utillinux
  unrar
  vim
  wget
  zip
  usbutils
  pciutils

  # For terminfo we need to install termite as system package
  termite

  # For virtualisation
  virtmanager
]
