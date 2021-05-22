setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

for file in ~/.dotfiles/*; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
