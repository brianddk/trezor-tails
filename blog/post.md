<!--

Raw Notes

----
* Torrent image file
* https://tails.boum.org/tails-signing.key
* gpg2 --import tails-signing.key
* gpg2 --verify *.sig *.img
* vboxmanage convertfromraw tails-amd64-3.14.img tails-amd64-3.14.vdi --format vdi
* virtualbox
* File->Virtual Media Manager
* Add -> tails*.vdi
* Properties -> Size 8GB -> Apply
* Machine -> New -> Mac OS X x64 -> 2GB Memory
* Settings -> General -> Advanced -> Shared Clip -> bidirectional
* Settings -> Motherboard -> Chipset -> PIX3
* USB -> USB3.0
* Start and spam ESC
* Edit *.cfg and do hack
* Continue boot
* After Tor Ready, Configure Persistant Storage
* Save All; Wait to complete
* Shutdown ; Startup ; encrypt pass; Admin Pass
* Run Script
----

---

user_pref("privacy.firstparty.isolate", false);
user_pref("privacy.firstparty.isolate.restrict_opener_access", false);
user_pref("security.fileuri.strict_origin_policy", false);
user_pref("network.proxy.no_proxies_on", "127.0.0.1");

choco 0.10.14
virtualbox 6.0.8
gpg4win 3.1.7
tails.iso 3.14

1. choco upgrade -y chocolatey --version 0.10.14
2. cycle shell
3. choco upgrade -y virtualbox --version 6.0.8
4. choco upgrade -y gpg4win --version 3.1.7
4. leave shell
6. download https://tails.boum.org/tails-signing.key
5. download tails-amd64-3.14.iso and sig
7. gpg --verify tails-amd64-3.14.iso.sig tails-amd64-3.14.iso
6. https://beta-wallet.trezor.io/data/firmware/{}/releases.json
7. redd.it/abpyoy

8. Make a generic Debian64 VM, 2 proc, 2 GB mem
9. Add a USB controller
10. Add an 8 GB USB disk to the USB controller
11. Boot VM
12. Add admin account (maybe)
13. Run tails installer
14. Safe powerdown VM
15. Create a mac x64 machine
16. Set USB to 3.0
17. Set chipset to PIX3
18. Add USB controller in sotrage
19. Connect 8GB VDI to USB controller
20. Set media s removable
21. Boot VM
22. Edit out live-media=removable at boot
23. Boot into VM
24. Launch "Configure Persistence Storage"
25. Select all options
26. Click shutdown 
27. Start VM and spam ESC to get into EFI
27. Boot Manager, internal shell
redd.it/abpyoy
redd.it/b12ikx

sudo install -d -m 755 /live/persistence/TailsData_unlocked/apt-sources.list.d
sudo tee -a /live/persistence/TailsData_unlocked/persistence.conf <<< "/etc/apt/sources.list.d  source=apt-sources.list.d,link"
shutdown; startup
https://unix.stackexchange.com/a/340482/227042

https://blog.thestever.net/2019/02/26/upgrading-electrum-on-tails-to-3-3-4/

https://superuser.com/questions/1301583/how-can-i-extract-files-from-an-appimage/1389548#1389548

https://askubuntu.com/questions/984205/how-to-save-gnome-settings-in-a-file

https://superuser.com/questions/149032/where-is-the-chrome-settings-file

https://superuser.com/questions/664454/why-doesnt-my-cron-d-per-minute-job-run

https://unix.stackexchange.com/questions/231803/notify-send-doesnt-work-from-script-but-works-from-terminal#comment396117_231807

https://superuser.com/a/1389548/970984

/live/persistence/TailsData_unlocked/dotfiles/.config/dconf/user
/live/persistence/TailsData_unlocked/dotfiles/.config/chromium/Default/Preferences
/live/persistence/TailsData_unlocked/dotfiles/.config/chromium/First Run
/live/persistence/TailsData_unlocked/dotfiles/.config/chromium/Local State

https://raw.githubusercontent.com/trezor/trezor-common/master/udev/51-trezor.rules
export http_proxy=socks5://127.0.0.1:9050 && export https_proxy=socks5://127.0.0.1:9050
sudo apt-get install python3-dev python3-pip cython3 libusb-1.0-0-dev libudev-dev build-essential python3-wheel
## ^^ transient ^^
pip3 install --user --upgrade setuptools
pip3 install --user --upgrade trezor[ethereum,hidapi]
printf "trust\n5\ny\nquit\n" | gpg --command-fd 0 --edit-key "thomasv@electrum.org"
ALT-F2 "restart"

#!/bin/bash --login
export DISPLAY=:1
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
/usr/bin/notify-send "Title" "Message"
/bin/touch /tmp/notify.txt

https://imgur.com/a/NGRJQRZ


-- Default
/home/amnesia/Persistent	source=Persistent
/home/amnesia/.mozilla/firefox/bookmarks	source=bookmarks
/etc/NetworkManager/system-connections	source=nm-system-connections
/var/cache/apt/archives	source=apt/cache
/var/lib/apt/lists	source=apt/lists
/etc/cups	source=cups-configuration
/home/amnesia/.thunderbird	source=thunderbird
/home/amnesia/.gnupg	source=gnupg
/home/amnesia/.electrum	source=electrum
/home/amnesia/.purple	source=pidgin
/home/amnesia/.ssh	source=openssh-client
/home/amnesia	source=dotfiles,link

-- Modified
/home/amnesia/Persistent	source=Persistent
/home/amnesia/.mozilla/firefox/bookmarks	source=bookmarks
/etc/NetworkManager/system-connections	source=nm-system-connections
/var/cache/apt/archives	source=apt/cache
/var/lib/apt/lists	source=apt/lists
/etc/cups	source=cups-configuration
/home/amnesia/.thunderbird	source=thunderbird
/home/amnesia/.gnupg	source=gnupg
/home/amnesia/.electrum	source=electrum
/home/amnesia/.purple	source=pidgin
/home/amnesia/.ssh	source=openssh-client
/home/amnesia	source=dotfiles,link
/home/amnesia/.local	source=local
/root/.local	source=local
/etc/udev/rules.d/	source=udev,link

--Delta
/home/amnesia/.local	source=local
/root/.local	source=local
/etc/udev/rules.d/	source=udev,link
/usr/local/bin/	source=local/bin,link


-->
