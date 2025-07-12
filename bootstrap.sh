#!/usr/bin/env zsh

source ./scripts/init
source ./scripts/brew
source ./scripts/app_store
source ./scripts/brew_cask
source ./scripts/preferences
source ./scripts/customizes

git clone https://github.com/ecleya/dotfiles.git ~/Projects/dotfiles

ln -s ~/Projects/dotfiles/home/.dotfiles/ ~/.dotfiles
ln -s ~/Projects/dotfiles/home/.gitconfig ~/.gitconfig
ln -s ~/Projects/dotfiles/home/.gitignore ~/.gitignore
ln -s ~/Projects/dotfiles/home/.zshrc ~/.zshrc

cp -R ~/Projects/dotfiles/home/Library/ ~/Library/

mkdir -p ~/Projects
ln -s ~/Projects/dotfiles/apps/vscode ~/Library/Application\ Support/Code/User

mkdir -p ~/.config
ln -s ~/Projects/dotfiles/apps/karabiner ~/.config/karabiner

# Done
echo "Done. Note that some of these changes require a logout/restart to take effect."
