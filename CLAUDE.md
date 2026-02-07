# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Multi-system Nix configuration managing 6 hosts across NixOS (Linux), nix-darwin (macOS), and standalone home-manager (WSL). Uses Nix flakes for reproducibility.

## Build and Deploy Commands

```bash
# macOS (current machine) - rebuild system config
cd $CONFIG_DIR && git add -A && sudo darwin-rebuild switch --flake .#workMac

# NixOS (dell desktop)
sudo nixos-rebuild switch --flake "$CONFIG_DIR#dell"

# Remote deployment to servers via Lollypops
nix run "$CONFIG_DIR" -- -p zima nuc

# Format all Nix files (alejandra)
nix fmt

# Show all available flake outputs
nix flake show
```

## Hosts

| Alias | System | User | Type |
|-------|--------|------|------|
| `dell` | x86_64-linux | seb | NixOS desktop (Hyprland) |
| `nuc` | x86_64-linux | nuc | NixOS home server |
| `zima` | x86_64-linux | zima | NixOS server |
| `workMac` | aarch64-darwin | slopezsanchez | macOS (nix-darwin) |
| `macAir` | aarch64-darwin | seb | macOS (nix-darwin) |
| `workWsl` | x86_64-linux | slopezsanchez | Standalone home-manager |

## Architecture

### Flake Structure (`flake.nix`)

Three config builders pass `user`, `host`, and `host_alias` as `specialArgs` throughout:
- `mkConfig` - NixOS systems (imports lollypops, home-manager as NixOS module)
- `mkConfig-darwin` - macOS systems (imports home-manager as darwin module)
- `mkConfig-homeManager` - Standalone home-manager (WSL)

An `overlay-unstable` makes `pkgs.unstable.*` available everywhere.

### Directory Layout

- **`hosts/<name>/`** - Per-host configuration. Each has `default.nix` (system) and `home.nix` (user env). Servers have `services/` subdirectories and `deployment.nix` for Lollypops.
- **`common/`** - Shared NixOS system modules (base settings, packages, docker, fonts, garbage collection, NAS mounts).
- **`mixins/`** - Composable fragments. `system/darwin.nix` for macOS base. `home/seb.nix`, `home/darwin.nix`, `home/work.nix`, `home/ubuntu.nix` for user environments.
- **`home/`** - Reusable home-manager program configs (zsh, git, tmux, kitty, vim, vscode, modern_unix tools).
- **`home/neovim/standalone/`** - Declarative Neovim config via nixvim with modular `plugins/` directory.

### Key Patterns

- **`lib.mkDefault`** for values that hosts can override (e.g., the `update` alias defaults to NixOS rebuild but darwin overrides it).
- **Mixin composition** - macOS hosts compose `home.nix` from multiple mixins rather than defining config inline.
- **Service modularization** - Server services (nginx, mysql, nextcloud, photoprism, ssh, dawarich) are separate files under `hosts/<server>/services/`.
- **User parameterization** - `user`, `host`, `host_alias` flow through `specialArgs` enabling templates like `home.homeDirectory = "/home/${user}"`.
