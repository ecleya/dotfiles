for file in ~/.{bash_prompt}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

for file in ~/.dotfiles/*; do
  source $file
done
unset file;
