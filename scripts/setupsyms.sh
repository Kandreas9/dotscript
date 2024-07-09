#!/bin/bash

mkdir ~/.config

#Remove previous files or symlinks
rm -ri ~/.config/zsh
rm -ri ~/.config/nvim

#Add symlinks
ln -s "${PWD%/*}"/zsh ~/.config/zsh
ln -s "${PWD%/*}"/nvim ~/.config/nvim

if ! grep -q "source ~/.config/zsh/.zshrc" ~/.zshrc
then
#Add zshrc to .zshrc by sourcing it
echo "source ~/.config/zsh/.zshrc" >> ~/.zshrc
fi

echo "===Script finished==="
