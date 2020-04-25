#!/bin/bash
export PATH="/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin:/root/bin"

log="/tmp/iptables.log"
grep "Bootstrap" "/var/log/tor/log" >> "$log"
if grep "Bootstrapped 100% (done): Done" "/var/log/tor/log"
then
  iptables -I OUTPUT -p tcp --dport 21325 -j ACCEPT -s localhost -d localhost
  iptables -I INPUT -p tcp --dport 21325 -j ACCEPT -s localhost -d localhost
  echo 'user_pref("network.proxy.no_proxies_on", "127.0.0.1");' >> ~amnesia/.tor-browser/profile.default/prefs.js
  echo 'user_pref("security.mixed_content.block_active_content", false);' >> ~amnesia/.tor-browser/profile.default/prefs.js

  export DISPLAY=:1
  export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
  runuser -c 'notify-send "IPTables enabled @ 127.0.0.1:21325" "Trezor Bridge ready. Restart your browser if open."' amnesia

  rm -f /etc/cron.d/localhost
else
  echo "------[$(date)]: Waiting on tor... Retrying------" >> "$log"
fi
