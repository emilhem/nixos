{ pkgs }:
with pkgs;

[
  acpi
  bash
  coreutils
  cryptsetup
  curl
  dnsutils
  gtk3
  openssh
  openssl
  utillinux
  vim
  wget
  zip
  usbutils
  pciutils

  mysql

  xorg.xbacklight

  # For virtualisation
  docker
#  virtmanager
#  qemu
  virtualbox
#  linuxPackages.virtualbox
#  linuxPackages.virtualboxGuestAdditions
#  linuxPackages_xen_dom0.virtualbox
#  linuxPackages_xen_dom0.virtualboxGuestAdditions
]
