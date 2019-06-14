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

Read the first 30 lines of [bootstrap.sh](https://github.com/brianddk/trezor-tails/blob/master/bootstrap.sh) to turn off optional components.  The python modues will take a ***long*** time to install

### Working Features

* `wallet.trezor.io`
* `mycrypto.com`
* `myetherwallet.com`
* Trezor Python library
* Trezor Bridge software
* Electrum AppImage
* Electron Cash AppImage
* Brave Browser ( in `--no-sandbox` mode)
* Chromium Browser

### To Do List

- [x] Modularize bash, chromium, bridge, etc
- [x] - Add brave support to transition off chromium - ***still WIP***
- [ ] - Add dwblog entry on creating VM
- [x] Add Electron Cash
- [x] ~~Add MyCrypto AppImage module~~ - **Fails... unusable**
- [x] Add browser support for `mycrypto.com` - **Works with chromium**
- [x] ~~Test MEW through TorBrowser~~ - **Fails due to cloudflare CDN**
- [x] Test MEW in unsafe-browser - **Works, but not anon**
- [x] Abstract version info for all modules - **Need some creative sed, but it works**
- [ ] Allow `master` as a version that pulls from `git`
- [ ] Add profile support for brave
- [ ] Add profile support for chromium
- [ ] Add unsafe_browser_config module
- [ ] Add python36 module
- [ ] Test chromium module
- [ ] Gauge the impact of the proc hack for brave
- [ ] Refactor asset files to module_name
- [ ] Include version and filename for all modules
- [ ] Add master version for electrum and electron-cash
- [ ] Develop privoxy solution for mycrypto/master
- [ ] Guage proxy support in mycrypto
- [ ] Add Tier 1 Coin support ( LTC, NMC, FTC ...)
- [ ] Add Tier 2 Coin support ( ... KOTO )

Please [log issues here](https://github.com/brianddk/trezor-tails/issues/new) if you find any.

Please [issue feature requests here](https://github.com/brianddk/trezor-tails/issues/new) if you have any.
