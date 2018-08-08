{ pkgs }:
with pkgs;

[
  acpi
  coreutils
  cryptsetup
  curl
  gtk3
  openssh
  openssl
  utillinux
  vim
  wget
  zip
  usbutils
  pciutils

  xorg.xbacklight

  # For virtualisation
  #virtmanager
]
