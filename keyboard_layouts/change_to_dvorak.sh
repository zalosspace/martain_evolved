#!/bin/bash

setxkbmap -option caps:swapescape && setxkbmap -layout us -variant dvorak && xmodmap ~/.Xmodmap

xset r rate 140 40 &

