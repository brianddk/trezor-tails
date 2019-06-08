#!/bin/bash
rm -f /etc/cron.d/localhost

iptables -I OUTPUT -p tcp --dport 21325 -j ACCEPT -s localhost -d localhost
iptables -I INPUT -p tcp --dport 21325 -j ACCEPT -s localhost -d localhost

echo 'user_pref("network.proxy.no_proxies_on", "127.0.0.1");' >> ~amnesia/.tor-browser/profile.default/prefs.js

export DISPLAY=:1
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
runuser -c 'notify-send "IPTables" "Enabled port 127.0.0.1:21325 for Trezor Bridge.  Restart your browser if open."' amnesia
