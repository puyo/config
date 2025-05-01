{
  config,
  pkgs,
  ...
}: {
  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  # https://nixos.wiki/wiki/NVIDIA
  config = {
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
      ];
    };

    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia.open = false; # proprietary driver pls
  };
}
