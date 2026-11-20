#!/bin/sh
# Hyprlock grabs its own screenshot background; just avoid starting a second instance.
pidof hyprlock >/dev/null || exec hyprlock
