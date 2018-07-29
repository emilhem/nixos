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
      hashedPassword = "$6$WbQKtqt4Lc1MkLe$Y6bf6Vp65iRefeIxkJ7Pun77hHxoUwt.Xf/OV/xJIianVH2VfVkjdyXULx3zR5MLTxJknELaf2iW23ulFR3MC.";
      shell = pkgs.zsh;
      packages = import ./packages/jassob.nix { inherit pkgs; };
    };

    users.guest = {
      home = "/tmp/guest";
      description = "Guest account";
      extraGroups =
      [ "wheel" "disk" "audio" "video"
        "systemd-journal" "sudo" "users"
        "networkmanager" "docker"];
      createHome = true;
      uid = 1001;
      hashedPassword = "$6$eQ3.46J1$Xg6vvIiELtA1wAKCX24u1FUZjZkQLv82Kfq5MEpz09mX70R5YWQp2lAUDy.CwaVxXja7mRfDjDIhos0ofgC91.";
      packages = import ./packages/jassob.nix { inherit pkgs; };
      shell = pkgs.bash;
    };
  };
}
