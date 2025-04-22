{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../hardware-configuration.nix
    ../../lib/common.nix
    ../../lib/efi.nix
    ../../lib/sydney.nix
    ../../lib/plasma.nix
    ../../lib/steam.nix
    ../../lib/greg.nix
    ../../lib/fam.nix
    ../../lib/git.nix
  ];

  networking.hostName = "opal";

  # Enable automatic login for the user.
  #services.displayManager.autoLogin.enable = true;
  #services.displayManager.autoLogin.user = "greg";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    (
      vim_configurable.customize {
        # Specifies the vim binary name.
        name = "vim";

        # Here you can specify what usually goes into `~/.vimrc`
        vimrcConfig.customRC = ''
          syntax enable
          set sw=2
          set sts=2
          set clipboard+=unnamed " share windows clipboar
          set visualbell
        '';

        # Install plugins for example for syntax highlighting of nix files
        vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
          start = [vim-nix];
          opt = [];
        };
      }
    )

    alejandra
    asdf-vm
    autoconf # ruby-build
    automake # ruby-build
    diff-so-fancy
    gcc # ruby-build
    gnumake # ruby-build
    gnupatch # ruby-build
    htop
    jq
    kdotool # bin/n
    librewolf
    libyaml # ruby-build
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
    zlib # ruby-build
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
