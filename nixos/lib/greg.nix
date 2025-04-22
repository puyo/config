{
  config,
  pkgs,
  ...
}: let
  zipResult = pkgs.fetchzip {
    url = "https://github.com/xremap/xremap/releases/download/v0.10.10/xremap-linux-x86_64-kde.zip";
    postFetch = "mv $out/xremap /home/greg/bin/xremap";
  };
in {
  config = {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.greg = {
      isNormalUser = true;
      description = "Greg";
      extraGroups = ["networkmanager" "wheel" "input"];
    };

    services.udev.extraRules = ''
      KERNEL=="uinput", GROUP="input", TAG+="uaccess"
    '';

    systemd.user.services.xremap = {
      enable = true;
      after = ["graphical-session.target"];
      wantedBy = ["default.target"];
      description = "Xremap";
      serviceConfig = {
        Type = "simple";
        ExecStart = ''/home/greg/bin/xremap --watch /home/greg/.xremap.yml'';
      };
    };
  };
}
