#!/usr/bin/env bash
source ./scripts/brew
source ./scripts/install-apps
source ./scripts/preferences

rsync --exclude ".git/" \
	--exclude ".DS_Store" \
	--exclude "bootstrap.sh" \
	--exclude "README.md" \
	--exclude "LICENSE" \
	-avh --no-perms ./dotfiles ~;

source ~/.bash_profile;
