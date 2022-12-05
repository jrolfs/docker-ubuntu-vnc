#!/usr/bin/env bash

x11vnc -xkb -noxrecord -noxfixes -noxdamage -display :101 -forever -bg -rfbauth /home/ubuntu/.vnc/passwd -rfbport 59002 -clip 1024x684+8+8
