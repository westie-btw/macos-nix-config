{ config, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;

    history = {
      size = 100000;
      save = 100000;
      ignoreDups = true;
      ignoreSpace = true;
    };

    shellAliases = {
      la = "eza -la";
      nixcfg = "just --justfile ${config.home.homeDirectory}/.config/nix/Justfile";
    };
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;

    extraOptions = [
      "--group-directories-first"
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
