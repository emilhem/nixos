
{ config, pkgs, ... }:
{
  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-b3a09a7f-28a7-4480-850e-155831a50aa1".device = "/dev/disk/by-uuid/b3a09a7f-28a7-4480-850e-155831a50aa1";
  networking.hostName = "nixos-asus-laptop";

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  programs.kdeconnect.enable = true;
  programs.chromium.enablePlasmaBrowserIntegration = true;
  programs.ssh.startAgent = true;

}
