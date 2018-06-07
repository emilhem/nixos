{ config, lib, pkgs, ... }:

{
# Define user accounts. This is the only way to add users to the
# system since mutableUsers are false.
  users = {
    mutableUsers = false;

    users.jassob = {
      home = "/home/jassob";
      description = "Jacob Jonsson";
      extraGroups =
      [ "wheel" "disk" "audio" "video"
        "systemd-journal" "sudo" "users"
        "networkmanager" "docker"];
      createHome = true;
      uid = 1000;
      hashedPassword = "CREATE WITH mkpasswd -m sha-512";
      shell = pkgs.zsh;
      packages = import ./packages/jassob.nix { inherit pkgs; };
    };
  };
}
