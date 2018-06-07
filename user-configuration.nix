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
      packages = with pkgs;
      [
        # Applications
        termite conkeror firefox
        dropbox-cli drive pass
        keybase pavucontrol stow
        steam rofi-pass gitAndTools.gitFull
        bashCompletion gnupg openssh

        # Haskell development
        haskellPackages.ghc
        haskellPackages.hlint
        haskellPackages.cabal-install
        haskellPackages.cabal2nix

        # For my XMonad setup
        rofi dunst sxhkd pamixer pavucontrol
        compton scrot imagemagick ncmpcpp
        xorg.xmessage libnotify
     ];
    };
  };
}
