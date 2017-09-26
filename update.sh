#!/usr/bin/env bash
source ./scripts/brew
source ./scripts/brew-update
source ./scripts/install-apps
source ./scripts/preferences

ln -s ./dotfiles/.bash_profile ~/

source ~/.bash_profile;
