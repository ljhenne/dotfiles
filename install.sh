# MANUAL INSTALLATIONS
#
#
## Homebrew installation
which -s brew
if [[ $? != 0 ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    brew update
fi

ver=$(python -c "import sys; print(sys.version_info.major)")
if [ $ver -eq 2 ]; then
    brew install python
elif [ $ver -eq 3 ]; then
    echo "Python3 already installed"
else 
    echo "Unknown python version: $ver"
fi

# DOWNSTREAM INSTALLATIONS
#
#
## Brew bundle, installs all homebrew binaries, depends on `Brewfile` copied in previous step
brew bundle install

## oh-my-zsh Installation
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# DOTFILES
#
#
## Copy dotfiles and configs to home directory
python bootstrap.py

