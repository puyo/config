{
  config,
  pkgs,
  ...
}: {
  config = {
    nixpkgs.config.allowUnfree = true;

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };

    environment.systemPackages = with pkgs; [
      steam-run
    ];

    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };
}
