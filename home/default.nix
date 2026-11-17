{ primaryUser, ... }:
{
  imports = [
    # Core
    ./packages.nix
    ./shell.nix

    # Apps
    ./apps/kitty.nix

    # Tools
    ./tools/aria2.nix
    ./tools/bat.nix
    ./tools/git.nix
    ./tools/nvim.nix
    ./tools/ollama.nix
    ./tools/zoxide.nix
  ];

  home = {
    username = primaryUser;
    stateVersion = "26.05";

    file.".hushlogin".text = "";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
