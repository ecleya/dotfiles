for file in ~/.{bash_prompt}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# from http://qiita.com/yungsang/items/09890a06d204bf398eea by yungsang

export HISTCONTROL="ignoredups"
peco-history() {
  local NUM=$(history | wc -l)
  local FIRST=$((-1*(NUM-1)))

  if [ $FIRST -eq 0 ] ; then
    # Remove the last entry, "peco-history"
    history -d $((HISTCMD-1))
    echo "No history" >&2
    return
  fi

  local CMD=$(fc -l $FIRST | sort -k 2 -k 1nr | uniq -f 1 | sort -nr | sed -E 's/^[0-9]+[[:blank:]]+//' | peco | head -n 1)

  if [ -n "$CMD" ] ; then
    # Replace the last entry, "peco-history", with $CMD
    history -s $CMD

    if type osascript > /dev/null 2>&1 ; then
      # Send UP keystroke to console
      (osascript -e 'tell application "System Events" to keystroke (ASCII character 30)' &)
    fi

    # Uncomment below to execute it here directly
    # echo $CMD >&2
    # eval $CMD
  else
    # Remove the last entry, "peco-history"
    history -d $((HISTCMD-1))
  fi
}
bind '"\C-r":"peco-history\n"'

export HISTFILESIZE=
export HISTSIZE=

export PATH="$HOME/.fastlane/bin:$PATH"
eval "$(direnv hook bash)"

alias python='python3'
alias pip='pip3'
alias short-break='nohup self_control.py short-break > /dev/null &'
alias long-break='nohup self_control.py long-break > /dev/null &'
alias entertainment='nohup self_control.py entertainment > /dev/null &'
