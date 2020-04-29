## Wiki-Contributions

## Submitting-a-PR

## Testing

I do all my testing through VirtualBox VM.  The `template.ovf` VM (without drives) is in OVF format in the `vbox` directory.  Here's a quick rundown of how to get the VirtualBox v6.1.6 hosting Tails v4.5:

#### Creating the VM

I'll go through the basic steps using the `VBoxManage` commands since they are the same on Windows, Mac and Linux.  Your free to use the GUI if you like, you should be able to discern what is happening here

* Download `tails-amd64-4.5.img` `tails-amd64-4.5.img.sig` from the USB stick [download page](https://tails.boum.org/install/download/index.en.html).
* Download [tails-signing.key](https://tails.boum.org/tails-signing.key) from the tails [PGP page](https://tails.boum.org/doc/about/openpgp_keys/index.en.html)
* Import the key into GPG: `gpg2 --import tails-signing.key`
* Sign the key:
```
gpg2 --quick-lsign-key 0xa490d0f4d311a4153e2bb7cadbb802b258acd84f
```
* Verify the download:
```
gpg2 --verify tails-amd64-4.5.img.sig tails-amd64-4.5.img
```
* Convert the `.img` file:
```
VBoxManage convertfromraw tails-amd64-4.5.img tails-amd64-4.5.vdi
```
* Expand the `.vdi` file:
```
VBoxManage modifymedium disk trezor-tails.vdi --resize 16384
```
* Import the VM:
```
VBoxManage import template.ovf --vsys 0 --vmname trezor-tails
```
* Attach the storage (replace `\` with `^` for Windows):
```
VBoxManage storageattach trezor-tails  \
  --medium trezor-tails.vdi            \
  --storagectl USB                     \
  --port 0                             \
  --type hdd                           \
  --hotpluggable on
```

#### Modify Grub

1. Be prepared to hit esc at boot
2. Boot the VM, but hit esc at the GRUB text menu
3. Hit `c` to get to a grub command
4. Type `exit` to return to UEFI / ROM
5. Select `Boot Manager`
6. Select `EFI Internal Shell`
7. At the `Shell>` type `edit fs0:\efi\debian\grub.cfg`
8. On lines 39 and 48, remove the text `live-media=removable`
9. Press Ctrl-Q to save and exit
10. Power off / Reset the VM after the save operation

#### Enabling Persistent Storage

The following is applicable whether your running tails from a USB Key or VM.  The procedure is the same for both.

1. Boot into Tails as normal until you reach the desktop
2. Select `Applications`, `System Tools`, `Configure persistent volume`
3. Pick a strong password to encrypt your persistent storage
4. Don't forget your password... seriously...
5. Pick what to persist, I test with all features persistent
6. Wait for the wizard to prompt for a restart
7. Select the restart icon from the power icon on the top right menu

#### Booting with Admin access and Persistent Storage

In order to use the scripts in this repository you need to have a tails install that has mounted persistent storage and has set an Admin Password (root).

1. Boot your Tails to the "Welcome" screen
2. Under "Additional Settings" hit the "+" (plus)
3. Click on "Administration Password" to fill in a strong password
4. Fill in the (different) encryption password under "Persistent Storage"
5. Once Admin is set and Storage is unlocked, select "Start Tails"

#### Booting with obfs4 bridges

Many CDNs such as Cloudflare will block known Tor exit nodes.  To work around this you can hide the fact that your using Tor by routing the traffic through the `obfs4` network of anonymous bridges.

1. Request a bridge by going to either the [TorProject Bridge Page](https://bridges.torproject.org/), or their [onion mirror](http://z5tfsnikzulwicxs.onion/)
2. Under "Additional Settings" hit the "+" (plus)
3. Select "Network Connection" to adjust them
4. Select "Configure a Tor bridge" and click "Add"
5. Select "Start Tails" to proceed where you'll be prompted for the bridge
6. Select "Configure" in the "Connect to Tor" dialog
8. Select "Tor is censored"
9. Fill in the bridges you collected at the beginning of the procedure. 

#### Cloning the repo locally in Tails

As of this posting, this repo can be checked out locally in tails and modified and run from there.

* Boot into Tails with persistence and Admin enabled
* From "Applications" launch "Terminal"
* Enter the persistent directory: `cd Persistent`
* Checkout `scratch` branch:
```
git clone -b scratch https://github.com/brianddk/trezor-tails.git
```

#### Selecting a module and running locally

You will need to edit `bootstrap.sh` to determine what modules to install

1. Enter repo directory: `cd trezor-tails`
2. Modify `bootstrap.sh`: `gedit bootstrap.sh &`
3. Near line 20 you will see a list of modules
3. Modules proceeded by a `#` symbol are disabled, otherwise they will be applied
4. Edit the list so that you enable/disable the modules you want
5. Run bootstrap: `bash bootstrap.sh`
6. Monitor the install for errors, and provide Admin passwords when needed
