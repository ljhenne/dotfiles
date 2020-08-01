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

## Installation

Just `git clone` and run this from within the repository.

```bash
bash ./install.sh
```
