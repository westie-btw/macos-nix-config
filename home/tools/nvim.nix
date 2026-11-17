_: {
  # LazyVim config lives in the repo and is linked read-only into ~/.config/nvim.
  # lazy.nvim and mason still write their own state to the XDG data dirs.
  xdg.configFile = {
    "nvim/init.lua".source = ./nvim/init.lua;
    "nvim/lua".source = ./nvim/lua;
  };
}
