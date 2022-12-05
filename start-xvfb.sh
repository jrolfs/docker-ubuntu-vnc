#!/usr/bin/env bash

/usr/bin/Xvfb :$1 -screen 0 1032x692x24 -ac +extension GLX +render -noreset &
