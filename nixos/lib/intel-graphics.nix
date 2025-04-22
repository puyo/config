{
  config,
  pkgs,
  ...
}: {
  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  # https://nixos.wiki/wiki/Intel_Graphics
  config = {
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vpl-gpu-rt # for newer GPUs on NixOS >24.05 or unstable
        vaapiIntel
        intel-media-driver
      ];
    };

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD"; # Force intel-media-driver
    };
  };
}
