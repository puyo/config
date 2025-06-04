{
  config,
  pkgs,
  ...
}: {
  config = {
    environment.systemPackages = with pkgs; [
      mise
      unzip
    ];
  };
}
