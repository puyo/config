{
  config,
  pkgs,
  ...
}: {
  # asdf plugin add ruby
  # nix-shell -p gcc pkg-config zlib libffi --run 'asdf install ruby'
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
    ];
  };
}
