# nix-config

## Stack
- **nix-darwin**
- **home-manager**
- **Nix-Homebrew**
- **nixpkgs-unstable**

## Layout

    .
    ├── README.md
    ├── TODO.md
    ├── flake.nix
    ├── flake.lock
    ├── Justfile
    ├── bootstrap              Setup script
    ├── darwin/
    │   ├── default.nix        Module wiring
    │   ├── settings.nix       macOS defaults
    │   └── homebrew.nix       Homebrew + nix-homebrew
    └── home/
        ├── default.nix
        ├── packages.nix       CLI packages
        ├── zsh.nix            Shell, eza and fzf
        ├── apps/
        │   └── kitty.nix      Kitty (nixpkgs app + config)
        └── tools/
            ├── aria2.nix
            ├── bat.nix
            ├── git.nix
            ├── nvim.nix       Neovim + LazyVim wiring
            ├── nvim/          LazyVim lua config
            ├── ollama.nix
            └── zoxide.nix

## Just commands

| Recipe | What it does | Manual equivalent |
|---|---|---|
| `just switch` | Apply the config | `sudo darwin-rebuild switch --flake .#MacBook` |
| `just build` | Build only. Validates without changing anything | `darwin-rebuild build --flake .#MacBook` |
| `just update` | Update inputs, build, then apply | `nix flake update`, then build, then switch |
| `just generations` | List saved system generations | `sudo darwin-rebuild --list-generations` |
| `just changelog` | Show nix-darwin release notes | `darwin-rebuild changelog --flake .#MacBook` |
| `just fmt` | Format all `.nix` files | `nix fmt` |
| `just check` | Evaluate the flake and run checks | `nix flake check` |
| `just rollback` | Go back one generation | `sudo darwin-rebuild switch --rollback` |
| `just brew-upgrade` | Upgrade Homebrew formulae and casks. The only place brew upgrades happen | `brew upgrade && brew upgrade --cask` |
| `just clean` | Full maintenance | see below |

`nixcfg` is a shell alias for `just --justfile ~/.config/nix/Justfile`, so every recipe works from any directory.

### `just clean`

    sudo nix-collect-garbage --delete-older-than 7d
    nix store optimise
    brew autoremove
    brew cleanup --prune=all

Determinate Nix already runs automatic garbage collection in the background;
this recipe only trims old system generations and Homebrew leftovers.

## Troubleshooting

### `Could not write domain com.apple.universalaccess; exiting`

`darwin/settings.nix` writes a Universal Access preference, and macOS protects
that domain with TCC. The terminal running `sudo darwin-rebuild` needs **Full
Disk Access**:

1. System Settings → Privacy & Security → Full Disk Access.
2. Add the terminal app you run `just switch` from.
3. Quit the terminal completely and reopen it.
4. Verify from that terminal:
   ```bash
   sqlite3 "/Library/Application Support/com.apple.TCC/TCC.db" "SELECT 1;"
   ```
   It should print `1`.
5. Run `just switch` again.

The generated activation script uses `set -e`, so a denied write aborts the rest
of activation (launchd services and Home Manager) rather than just skipping that
one preference.

### Full Disk Access is per terminal

If you switch terminals, grant Full Disk Access to the new one as well. Rights
given to one terminal app do not apply to another.

## First-time setup

1. Ensure Full Disk Access is enabled for the terminal.
2. Run `xcode-select --install`.
3. Clone: `git clone https://github.com/dev-westie/macos-nix-config.git ~/.config/nix`
4. Run the bootstrap script: `cd ~/.config/nix && ./bootstrap`

## Deliberate choices

- **Homebrew `cleanup = "zap"`**: activation removes any Homebrew formula or cask not listed in `darwin/homebrew.nix`, so the config is the single source of truth.
- **Homebrew upgrades are manual**: `onActivation.autoUpdate` and `upgrade` are off; use `just brew-upgrade` instead.
- **Homebrew is pinned by nix-homebrew**: `brew update` cannot update Homebrew itself because the Homebrew code lives in the Nix store.
- **Gatekeeper quarantine is off**: `LaunchServices.LSQuarantine = false` means downloaded files are not quarantined. This weakens Gatekeeper; remove the setting if you want the default protection.
- **Nix** is managed by the Determinate installer (`nix.enable = false`).
- **Kitty is installed from nixpkgs**; Home Manager copies the app bundle into `~/Applications/Home Manager Apps` and manages `~/.config/kitty/kitty.conf`.
- **Ghostty is no longer declared**; `cleanup = "zap"` removes it on the next activation.
- **Neovim is LazyVim**: `home/tools/nvim/` holds the config and Home Manager links it into `~/.config/nvim`. `lazy.nvim` installs plugins and `mason` installs LSP servers at runtime, so those versions come from upstream rather than Nix unless `lazy-lock.json` is added to the repo.
