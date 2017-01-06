#!/usr/bin/env bash

source ./scripts/init
source ./scripts/brew
source ./scripts/brew_cask
source ./scripts/app_store
source ./scripts/preferences

cp ./dotfiles/.bash_profile ~/.bash_profile
cp ./dotfiles/.direnvrc ~/.direnvrc
cp -r ./dotfiles/.dotfiles ~/.dotfiles
