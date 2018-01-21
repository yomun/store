#!/usr/bin/env bash

killall fcitx
killall sogou-qimpanel

rm -rf ~/.config/SogouPY && rm -rf ~/.config/SogouPY.users && rm -rf ~/.config/sogou-qimpanel
fcitx
