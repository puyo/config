{
  config,
  pkgs,
  ...
}: {
  config = {
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
      spotify
    ];
  };
}
