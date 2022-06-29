#!/bin/bash

# this will run flameshot in scaling mode from cli
# env QT_AUTO_SCREEN_SCALE_FACTOR=1 flameshot gui

# this will add the fix to the users profile so it persist on reboots

echo "export QT_AUTO_SCREEN_SCALE_FACTOR=1" >> ~/.profile
