{
  config,
  pkgs,
  ...
}: {
  config = {
    # List packages installed in system profile. To search, run:
    # $ nix search nixpkgs wget
    environment.systemPackages = with pkgs; [
      asdf-vm
      autoconf
      automake
      gcc
      gnumake
      gnupatch
      libyaml
      zlib
    ];
  };
}
