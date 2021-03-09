#!/usr/bin/env bash
set -euo pipefail

xrandr --output DP-2-2 --mode 1920x1080 --pos 0x0 --output DP-2-1 --mode 1920x1080 --pos 1920x0 --output eDP-1 --mode 1920x1080 --pos 3840x0
