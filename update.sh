#!/usr/bin/env bash
source ./scripts/brew
source ./scripts/install-apps
source ./scripts/preferences

rsync -avh --no-perms ./dotfiles/ ~;

source ~/.bash_profile;
