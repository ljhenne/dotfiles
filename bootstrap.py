#!/usr/bin/python
import os
import shutil

currdir = os.path.dirname(os.path.abspath(__file__)) 
dotfiles = os.path.join(currdir, 'dotfiles')

files = []
dirs = []
for path in os.listdir(dotfiles):
    if os.path.isfile(os.path.join(dotfiles, path)):
        files.append(path)
    else:
        dirs.append(path)

homedir = os.path.expanduser("~")

for file in files:
    dst = os.path.join(homedir, file)
    if os.path.exists(dst) or os.path.islink(dst):
        os.remove(dst)
    os.symlink(os.path.join(dotfiles, file), dst) 

for dir in dirs:
    dst = os.path.join(homedir, dir)
    print('attempting to copy to {}'.format(dst))
    if os.path.exists(dst):
        shutil.rmtree(dst)
    elif os.path.islink(dst):
        os.remove(dst)
    os.symlink(os.path.join(dotfiles, dir), dst)
