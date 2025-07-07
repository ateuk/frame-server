#!/bin/bash

# Set RTC clock
/usr/sbin/hwclock -w

# Wait for frame to be updated or any user to log in through SSH.
sleep 120

# Exit if an SSH user is connected.
# `who` lists logged-in users, and SSH sessions typically use a `pts`.
if who | grep -q pts; then
    echo "Active SSH session detected. Aborting halt/reboot."
    exit 0
fi

# Get the current hour in 24-hour format (00-23)
# %H gives the hour with a leading zero if needed (e.g., 06 for 6 AM)
current_hour=$(date +%H)

# Wakeup later
if (( current_hour >= 7 && current_hour < 20 )); then
  # If it's daytime (7 AM - 8 PM)
  echo 'Waking up in 6 hours'
  echo `date '+%s' -d '+6 hours'` > /sys/class/rtc/rtc0/wakealarm
else
  # If it's nighttime (8 PM - 7 AM)
  echo 'Waking up at 7am'
  echo `date '+%s' -d 'tomorrow 07:00:00'` > /sys/class/rtc/rtc0/wakealarm
fi

sleep 5
/sbin/shutdown now
