{
  config,
  pkgs,
  ...
}: {
  config = {
    environment.systemPackages = [
      (
        pkgs.vim_configurable.customize {
          # Specifies the vim binary name.
          name = "vim";

          # Here you can specify what usually goes into `~/.vimrc`
          vimrcConfig.customRC = ''
            syntax enable
            set sw=2
            set sts=2
            set clipboard+=unnamed " share windows clipboard
            set visualbell
          '';

          # Install plugins for example for syntax highlighting of nix files
          vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
            start = [vim-nix];
            opt = [];
          };
        }
      )
    ];
  };
}
