#!/bin/bash
/bin/rm -f /etc/cron.d/localhost

/sbin/iptables -I OUTPUT -p tcp --dport 21325 -j ACCEPT -s localhost -d localhost
/sbin/iptables -I INPUT -p tcp --dport 21325 -j ACCEPT -s localhost -d localhost

/bin/echo 'user_pref("network.proxy.no_proxies_on", "127.0.0.1");' >> ~amnesia/.tor-browser/profile.default/prefs.js

export DISPLAY=:1
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
/sbin/runuser -c '/usr/bin/notify-send "IPTables enabled @ 127.0.0.1:21325" "Trezor Bridge ready. Restart your browser if open."' amnesia
