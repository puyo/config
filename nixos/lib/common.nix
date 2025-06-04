{
  networking.networkmanager.enable = true;
  networking.networkmanager.settings.connectivity.uri = "http://nmcheck.gnome.org/check_network_status.txt";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.config.allowUnfree = true;

  services.openssh.enable = true;
}
