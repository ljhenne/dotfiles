#!/usr/bin/python
from os import listdir, path, symlink

currdir = path.dirname(__file__) 
dotfiles = path.join(currdir, 'dotfiles')

files = [f for f in listdir(dotfiles) if path.isfile(path.join(dotfiles, f))]
homedir = path.expanduser("~")

for file in files:
    symlink(path.join(dotfiles, file), path.join(homedir, file)) 

