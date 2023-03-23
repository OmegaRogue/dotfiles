#!/bin/sh
xrandr --output DP-0 --off --output DP-1 --off --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2 --off --output DP-3 --mode 1920x1080 --pos 3840x0 --rotate normal --output DP-4 --off --output DP-5 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output USB-C-0 --off

#xrandr --setmonitor HDMI-0~2 960/266x1080/299+960+0 DP-1
#xrandr --setmonitor HDMI-0~1 960/265x1080/299+0+0 HDMI-0
#xrandr --output DP-3 --mode 1920x1080 --right-of DP-5 --output DP-5 --primary --mode 1920x1080 --right-of DP-1 --output HDMI-0 --mode 960x1080 --output DP-1 --mode 960x1080 --right-of HDMI-0
