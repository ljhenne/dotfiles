# MANUAL INSTALLATIONS
#
#
## Homebrew installation
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

## oh-my-zsh Installation
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# DOTFILES
#
#
## Copy dotfiles and configs to home directory
python bootstrap.py

# DOWNSTREAM INSTALLATIONS
#
#
## Brew bundle, installs all homebrew binaries, depends on `Brewfile` copied in previous step
brew bundle install
