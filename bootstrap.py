#!/usr/bin/python
from os import listdir, path, remove, symlink

currdir = path.dirname(__file__) 
dotfiles = path.join(currdir, 'dotfiles')

files = [f for f in listdir(dotfiles) if path.isfile(path.join(dotfiles, f))]
homedir = path.expanduser("~")

for file in files:
    dst = path.join(homedir, file)
    if path.exists(dst) or path.islink(dst):
        remove(dst)
    symlink(path.join(dotfiles, file), dst) 

