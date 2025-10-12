{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../lib/common.nix
    ../../lib/sydney.nix
    ../../lib/plasma.nix
    ../../lib/fam.nix
    ../../lib/git.nix
    ../../lib/intel-graphics.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "virginia";

  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  environment.systemPackages = with pkgs; [
    alejandra
    diff-so-fancy
    htop
    jq
    kdotool # bin/n
    librewolf
    neofetch
    neovim
    neovim-qt
    networkmanager-openvpn
    openvpn
    qbittorrent
    ruby # bin/n etc.
    vlc
    wget
    wireguard-tools
    wl-clipboard # neovim
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
