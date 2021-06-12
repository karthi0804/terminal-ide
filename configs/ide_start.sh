#!/bin/sh
tmux new-session -s 'ide' -d\; split-window -v\;
tmux send-keys -t ide:0.0 "nvim +NERDTreeToggle" Enter
tmux a -t ide

