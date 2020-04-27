#!/bin/bash
# [rights]  Copyright brianddk 2020 https://github.com/brianddk
# [license] Apache 2.0 License https://www.apache.org/licenses/LICENSE-2.0
# [repo]    https://github.com/brianddk/trezor-tails/
# [tipjar]  BTC: 3AAzK4Xbu8PTM8AD3fDnmjdNkXkmu6PS7R or https://git.io/fh6b0

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
