#!/bin/bash
export PATH="/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin:/root/bin"
persist="/live/persistence/TailsData_unlocked"
rm -f /etc/cron.d/swapon

if [ ! -f $persist/swapfile ]
then
  dd if=/dev/zero of=$persist/swapfile bs=1024 count=$((1024*1024))
  chmod 0600 $persist/swapfile
  mkswap $persist/swapfile
fi

swapon.distrib --verbose $persist/swapfile

export DISPLAY=:1
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
runuser -c 'notify-send "Swap" "Swapfile enabled to optimize performance"' amnesia
