{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Development
    gh
    just

    # Editor
    neovim
    lazygit
    nodejs
    tree-sitter

    # Terminal utilities
    fd
    ripgrep
    tree

    # Languages and toolchains
    cmake
    python3

    # Media and metadata
    exiftool
    ffmpeg
    yt-dlp
  ];
}
