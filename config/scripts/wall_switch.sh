#!/bin/sh

# find "$HOME/Pictures/Wallpapers" -type f | 
#   rofi -dmenu "Wallpapers" |
#   xargs -r awww img --transition-type center --transition-fps 144 

find ~/Pictures/Wallpapers -type f |
  while read -r img; do
    printf '%s\0icon\x1f%s\n' "$img" "$img"
  done |
    rofi -dmenu -config ~/.config/rofi/display_wall.rasi -show-icons -p "Wallpaper" |
    xargs -r awww img --transition-type center --transition-fps 144 
