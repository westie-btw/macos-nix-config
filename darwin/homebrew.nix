{ primaryUser, ... }:
{
  nix-homebrew = {
    enable = true;
    user = primaryUser;
    autoMigrate = true;
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };

    casks = [
      "maccy"
      "protonvpn"
      "raycast"
      "legcord"
      "shottr"
      "iina"
      "librewolf"
      "photocraft"
      "spotifast"
      "zapfast"
      "utm"
      "helium-browser"
      "roblox"
    ];

    brews = [
      "mole"
      "opencode"
      "rustup"
      # "ghidra"
    ];

    taps = map (name: { inherit name; trusted = true; }) [
      "crmne/tap"
    ];
  };
}
