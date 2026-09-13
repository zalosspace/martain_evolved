#!/bin/sh

histfile="$HOME/.cache/cliphist"
placeholder="<NEWLINE>"
last=""

highlight(){
  clip=$(xclip -o -selection clipboard 2>/dev/null)
}

write() {
  # make histfile if not there
  [ -f "$histfile" ] || touch "$histfile"
  # exit if no clip found
  [ -z "$clip" ] && return 0
  # replace newline to placeholder <NEWLINE> 
  multiline=$(echo "$clip" | sed ':a;N;$!ba;s/\n/'"$placeholder"'/g')
  # avoid duplicate clip
  grep -Fxq "$multiline" "$histfile" || echo "$multiline" >> "$histfile"
}

get() {
  # get the recent cliphist first using tac
  selection=$(tac "$histfile" | rofi -dmenu -p "Clipboard history:")
  [ -n "$selection" ] && printf '%s' "$selection" | sed "s/$placeholder/\n/g" |
    xclip -i -selection clipboard
}

case "$1" in 
  # add) highlight && write ;;
  out) output && write ;;
  get) get ;;
esac

while true; do
  highlight

  if [ "$clip" != "$last" ]; then
    last="$clip"
    write
  fi

  sleep 0.5
done
