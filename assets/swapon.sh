#!/bin/bash
persist="/live/persistence/TailsData_unlocked"

/bin/rm -f /etc/cron.d/swapon
/bin/dd if=/dev/zero of=$persist/swapfile bs=1024 count=$((1024*1024))
/bin/chmod 0600 $persist/swapfile
/sbin/mkswap $persist/swapfile
/sbin/swapon.distrib --verbose $persist/swapfile

export DISPLAY=:1
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
/sbin/runuser -c '/usr/bin/notify-send "Swap" "Swapfile enabled to optimize performance"' amnesia
