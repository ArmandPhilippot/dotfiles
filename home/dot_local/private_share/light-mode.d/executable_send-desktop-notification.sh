#!/usr/bin/env bash

# Trigger a popup dialog to inform the user about darkman's activity
# See https://wiki.archlinux.org/title/Desktop_notifications#Usage_in_programming

notify-send --app-name="darkman" --urgency=low --icon=weather-clear "Switching to light mode"
