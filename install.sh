#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

echo "=== 1. Installing Homebrew dependencies ==="
if command -v brew >/dev/null 2>&1; then
    brew bundle install --file ./Brewfile
else
    echo "Homebrew not found. Please install Homebrew first."
    exit 1
fi

echo "=== 2. Backing up existing non-symlink dotfiles ==="
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

for file in .zshrc .pg_service.conf .tmux.conf; do
    if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
        echo "Backing up existing ~/$file -> $BACKUP_DIR/$file"
        mkdir -p "$BACKUP_DIR"
        mv "$HOME/$file" "$BACKUP_DIR/"
    fi
done

if [ -d "$HOME/.config/kitty" ] && [ ! -L "$HOME/.config/kitty" ]; then
    echo "Backing up existing ~/.config/kitty -> $BACKUP_DIR/kitty"
    mkdir -p "$BACKUP_DIR"
    mv "$HOME/.config/kitty" "$BACKUP_DIR/"
fi

echo "=== 3. Stowing dotfile packages ==="
stow zsh kitty postgres tmux

echo "=== Dotfiles installation complete! ==="
