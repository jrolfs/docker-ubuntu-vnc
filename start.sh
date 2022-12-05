#!/usr/bin/env bash

/usr/bin/Xvfb :$1 -screen 0 1032x692x24 -ac +extension GLX +render -noreset &

sleep 1

x11vnc -xkb -noxrecord -noxfixes -noxdamage -display :$1 -forever -bg -rfbauth /home/ubuntu/.vnc/passwd -rfbport $((59000 + $1)) -clip 1024x684+8+8 &

sleep 1

DISPLAY=:$1 ./mini-vmac/mini-vmac-4x
