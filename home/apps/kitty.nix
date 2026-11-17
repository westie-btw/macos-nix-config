_: {
  # Kitty is provided by nixpkgs; Home Manager copies the app bundle
  # into ~/Applications/Home Manager Apps and manages the config.
  programs.kitty = {
    enable = true;

    settings = {
      # Hide the macOS title bar and traffic lights.
      hide_window_decorations = true;
      macos_show_window_title_in = "none";

      # Extra breathing room at the top and sides (top right bottom left).
      window_padding_width = "10 14 0 14";
    };
  };
}
