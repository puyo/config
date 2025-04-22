{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [../../hardware-configuration.nix ../../lib/efi.nix ../../lib/sydney.nix];

  networking.hostName = "opal";
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.greg = {
    isNormalUser = true;
    description = "Greg";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      kdePackages.kate
      #  thunderbird
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fam = {
    isNormalUser = true;
    description = "Fam";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      kdePackages.kate
      #  thunderbird
    ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "greg";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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

  programs.git = {
    enable = true;
    prompt.enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  # Steam
  programs.steam.enable = true;

  # Neovim
  #  programs.neovim = {
  #    enable = true;
  #    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  #    defaultEditor = true;
  #    configure = {
  #      packages.all.start = with pkgs.vimPlugins; [
  #        (nvim-treesitter.withPlugins (p: [
  #          p.c
  #          p.elixir
  #          p.nix
  #          p.ruby
  #        ]))
  #      ];
  #    };
  #  };
}
