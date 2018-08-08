{ config, lib, pkgs, ...}:

{
  # Define your hostname.
  networking.hostName = "nix-desk";

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;

  hardware = {
    bluetooth.enable = false;
    cpu.intel.updateMicrocode = false;

    opengl.extraPackages = [];
    opengl.driSupport32Bit = true;
   };

  services.xserver.libinput = {
    enable = true;
  };
}
