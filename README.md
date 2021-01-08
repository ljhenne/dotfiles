# Dotfiles

My dotfiles repo.

## Prerequisites

Some things shouldn't be automated.

### Generate a new SSH key

Copied from [Github's docs](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) on the subject.

```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

Add the newly generated public key to GitHub and GitLab.

```
pbcopy < ~/.ssh/id_rsa.pub
```

## Sign into the App Store

You'll need to do this if you want to install the App Store apps.

If you don't need them, you can comment out or delete the lines starting with `mas` from `dotfiles/Brewfile`.

## Installation

Just `git clone` and run this from within the repository.

```bash
bash ./install.sh
```
