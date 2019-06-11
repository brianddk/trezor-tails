# Trezor on Tails

I would ***HIGHLY*** recommend that you backup your Tails instance before running this script.  I've seen some of the portions of the script corrupt the persistent volume if the right thing goes wrong at the right time.  Be warned!!!

To apply the Trezor libraries to a Tails (v3.14) instance, do the following:

1. Create a Tails (v3.14) instance with persistence and Admin (root) enabled.
2. Boot into the Tails instance, unlocking the persistent volume and enabling Admin.
3. Start a "normal" terminal session (not a root terminal) and issue the following command.
4. `bash <(wget -O- https://raw.githubusercontent.com/brianddk/trezor-tails/master/bootstrap.sh)`
5. Monitor the progress and provide the Admin password when asked.
6. Once the script completes without error, shutdown and restart the Tails instance.
7. On the final boot, simply unlock the persistant volume.  Admin is not required.
8. Wait for the message about "IPTables..." and "...software install successfully"
9. After recieving both messages launch the Tor Browser
10. Plug in your Trezor and browse to `https://trezor.io`
11. Proceed as you normally would

Still very much WIP, but seems functional enough for now.

Read the first 20 lines of [bootstrap.sh](https://github.com/brianddk/trezor-tails/blob/master/bootstrap.sh) to turn off optional components.

### To Do List

- [ ] - Modularize bash, chromium, bridge, etc
- [ ] - Add dwblog entry on creating VM
- [ ] - Add all 20 (ish) Electrum Trezor coin modules
- [ ] - Add MyCrypto AppImage module
- [ ] - Test MEW through TorBrowser
- [ ] - Add Python 3.6 venv by extracting Electrum AppImage (sketchy)
- [ ] - Abstract version info for all modules
- [ ] - Allow `master` as a version that pulls from `git`

Please [log issues here](https://github.com/brianddk/trezor-tails/issues/new) if you find any.

Please [issue feature requests here](https://github.com/brianddk/trezor-tails/issues/new) if you have any.
