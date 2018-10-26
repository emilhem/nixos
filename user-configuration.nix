{ config, lib, pkgs, ... }:

{
# Define user accounts. This is the only way to add users to the
# system since mutableUsers are false.
  users = {
    mutableUsers = false;

    users.emil = {
      home = "/home/emil";
      description = "Emil Hemdal";
      extraGroups =
      [ "wheel" "disk" "audio" "video"
        "systemd-journal" "sudo" "users"
        "networkmanager" "docker"
        "wireshark" ];
      createHome = true;
      uid = 1000;
      hashedPassword = import ./passwd.nix;
      shell = pkgs.zsh;
      packages = import ./packages/emil.nix { inherit pkgs; };
    };

#    users.guest = {
#      home = "/tmp/guest";
#      description = "Guest account";
#      extraGroups =
#      [ "wheel" "disk" "audio" "video"
#        "systemd-journal" "sudo" "users"
#        "networkmanager"];
#      createHome = true;
#      uid = 1001;
#      hashedPassword = "";
#      packages = import ./packages/jassob.nix { inherit pkgs; };
#      shell = pkgs.bash;
#    };
  };
}
