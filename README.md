# Dotfiles

My dotfiles repo.

## Setup GitHub SSH key

Cloning this repo requires authorization to clone which requires GitHub authentication to be set up.

Create a new SSH key and add it to your GitHub account:

* [Generating a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key)
* [Adding a new SSH key to your account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account#adding-a-new-ssh-key-to-your-account)

## oh-my-zsh

Run this to get a sane terminal with nice colors.

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## pyenv

Install pyenv so we can get the right version of Python.

```
brew install pyenv
```

## Sign into the App Store

You'll need to do this if you want to install the App Store apps.

If you don't need them, you can comment out or delete the lines starting with `mas` from `dotfiles/Brewfile`.

## Installation

Just `git clone` and run this from within the repository.

```bash
bash ./install.sh
```
