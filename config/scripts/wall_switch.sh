#!/bin/sh

find "$HOME/Pictures/Wallpapers" -type f | 
  rofi -dmenu "Wallpapers" |
  xargs -r awww img --transition-type center --transition-fps 144 
