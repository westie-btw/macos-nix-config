_: {
  programs.git = {
    enable = true;

    ignores = [
      ".DS_Store"
    ];

    settings = {
      user = {
        name = "westie";
        email = "westie.dev@proton.me";
      };

      github.user = "dev-westie";

      init.defaultBranch = "main";

      core.editor = "nvim";

      # `git pull` replays local commits instead of merge-committing.
      pull.rebase = true;

      # `git push` on a new branch works without --set-upstream.
      push.autoSetupRemote = true;
    };
  };
}
