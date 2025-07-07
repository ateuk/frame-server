#~/posters!/bin/bash

# Set RTC clock
/usr/sbin/hwclock -w

# Wait for frame to be updated
sleep 180

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
