set shell := ["bash", "-euo", "pipefail", "-c"]

host := "MacBook"
flake := justfile_directory()

# list all recipes
default:
    @just --list --unsorted

# apply the configuration
switch:
    sudo darwin-rebuild switch --flake {{ flake }}#{{ host }}

# build without applying
build:
    darwin-rebuild build --flake {{ flake }}#{{ host }}
    rm -f result

# update inputs, build, then apply
update:
    nix flake update
    darwin-rebuild build --flake {{ flake }}#{{ host }}
    rm -f result
    sudo darwin-rebuild switch --flake {{ flake }}#{{ host }}

# list saved system generations
generations:
    sudo darwin-rebuild --list-generations

# show nix-darwin release notes
changelog:
    darwin-rebuild changelog --flake {{ flake }}#{{ host }}

# format all .nix files
fmt:
    nix fmt

# evaluate the flake and run checks
check:
    nix flake check

# go back one generation
rollback:
    sudo darwin-rebuild switch --rollback

# upgrade Homebrew formulae and casks
brew-upgrade:
    brew upgrade
    brew upgrade --cask

# garbage collect and clean up
clean:
    sudo nix-collect-garbage --delete-older-than 7d
    nix store optimise
    brew autoremove
    brew cleanup --prune=all
