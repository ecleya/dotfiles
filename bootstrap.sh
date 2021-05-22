#!/usr/bin/env zsh

if [ ! -n "$1" ]
then
    source ./scripts/init
    source ./scripts/brew
    source ./scripts/app_store
    source ./scripts/brew_cask
fi
source ./scripts/preferences
source ./scripts/customizes

cp -r ./home/ ~

# Done
echo "Done. Note that some of these changes require a logout/restart to take effect."
