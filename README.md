# Dotfiles

Personal dotfiles and configuration repository managed with **[GNU Stow](https://www.gnu.org/software/stow/)**.

## Overview

This repository uses **GNU Stow** to manage configuration files and symlinks cleanly in `$HOME`.

- **Zero Copying / Zero Friction:** Files in your home directory (e.g. `~/.zshrc`, `~/.config/kitty/kitty.conf`) are symbolic links pointing directly into this repository. Edits made in your editor or terminal automatically save directly to this repository!
- **Modular Packages:** Configurations are organized into app-specific packages (`zsh/`, `kitty/`, `postgres/`). You can stow or unstow packages independently.
- **Developer Friendly:** Simple, standardized setup for other developers.

---

## Repository Structure

```text
.
├── .stowrc               # Default Stow config (targets home directory)
├── Brewfile              # Homebrew package dependencies (stow, pyenv, etc.)
├── install.sh            # Automated setup script
├── zsh/                  # Zsh shell package (.zshrc)
├── kitty/                # Kitty terminal package (~/.config/kitty/...)
└── postgres/             # PostgreSQL config package (~/.pg_service.conf)
```

---

## Quick Start / Installation

1. **Clone the repository:**
   ```bash
   git clone git@github.com:ljhenne/dotfiles.git ~/Git/github.com/ljhenne/dotfiles
   cd ~/Git/github.com/ljhenne/dotfiles
   ```

2. **Run the installation script:**
   ```bash
   bash ./install.sh
   ```
   *Note: This script will install Homebrew dependencies, safely back up any existing non-symlink dotfiles to `~/.dotfiles_backup/`, and run `stow`.*

---

## GNU Stow Usage

If you want to stow or unstow individual packages manually:

- **Link (Stow) a package:**
  ```bash
  stow zsh
  stow kitty
  ```

- **Unlink (Unstow) a package:**
  ```bash
  stow -D zsh
  ```

- **Re-link (Restow) a package:** (use after adding new files inside a package folder)
  ```bash
  stow -R zsh
  ```

- **Preview changes (Dry run):**
  ```bash
  stow -n -v zsh
  ```

---

## Workflow: Updating Configuration Files

Since config files in `~` are symlinked to this repository, updating your dotfiles is seamless:

1. Edit your config as usual (e.g. edit `~/.zshrc` or `~/.config/kitty/kitty.conf`).
2. Open your terminal in this repository:
   ```bash
   cd ~/Git/github.com/ljhenne/dotfiles
   git status
   git commit -am "Update shell aliases"
   git push
   ```
