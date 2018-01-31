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
      shell = "/run/current-system/sw/bin/zsh";
      hashedPassword = "CREATE WITH mkpasswd -m sha-512";
      packages = with pkgs;
      [
        # Applications
        termite conkeror firefox
        dropbox-cli drive pass
        keybase pavucontrol stow
        steam

        # Haskell development
        haskellPackages.ghc
        haskellPackages.hlint
        haskellPackages.cabal-install
        haskellPackages.cabal2nix

        # For my XMonad setup
        rofi dunst sxhkd
        compton scrot imagemagick
        xorg.xbacklight libnotify
     ];
    };
  };
}
