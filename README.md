# Trezor on Tails

I would ***HIGHLY*** recommend that you backup your Tails instance before running this script.  I've seen some of the portions of the script corrupt the persistent volume if the right thing goes wrong at the right time.  Be warned!!!

To apply the Trezor libraries to a Tails (v4.5) instance, do the following:

1. Create a Tails (v4.5) instance with persistence and Admin (root) enabled.
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
- [ ] Add Wasabi Wallet deb module
- [ ] See if the proc hack can be symlinked
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

<!-- footer -->

<details>
<summary>Expand for donation addresses</summary>
&nbsp;

This project and work is not sponsored, so other priorities take precedence.  If this is something you really enjoyed, or wish to place a bounty on a specific request, donations are welcome.  But if you just want to give a thumbs up without putting any money down, consider one of the donation addresses listed in the [testnet / valueless](https://github.com/brianddk/trezor-tails/wiki/Support#Testnet--Valueless-Coins) section or simply use one of my [referral links](https://github.com/brianddk/trezor-tails/wiki/Support#Brave--BAT--Referrals) below.

### Mainnet / Production Coins

If you don't see a coin you would like to contribute, simply [open an issue](../../issues/new/choose) requesting I add it and I will

  <table>
    <tr><td>BTC Lightning Network </td><td><a href="https://tippin.me/@dkbriand">https://tippin.me/@dkbriand</a></td></tr>
    <tr><td>BTC bech32 Segwit </td><td><a href="https://btc1.trezor.io/address/bc1qwc2203uym96u0nmq04pcgqfs9ldqz9l3mz8fpj">bc1qwc2203uym96u0nmq04pcgqfs9ldqz9l3mz8fpj</a></td></tr>
    <tr><td>BTC P2SH Segwit </td><td><a href="https://btc1.trezor.io/address/3AAzK4Xbu8PTM8AD3fDnmjdNkXkmu6PS7R">3AAzK4Xbu8PTM8AD3fDnmjdNkXkmu6PS7R</a></td></tr>
    <tr><td>BCH cashaddr </td><td><a href="https://bch1.trezor.io/address/bitcoincash:qqz77k4rqar3uppj8k28de06narwkqaamcf624p8zl">qqz77k4rqar3uppj8k28de06narwkqaamcf624p8zl</a></td></tr>
    <tr><td>LTC bech32 Segwit </td><td><a href="https://ltc1.trezor.io/address/ltc1q5uucgx9f8n70nq7jmjy03rpg84cm4tm70z5rz6">ltc1q5uucgx9f8n70nq7jmjy03rpg84cm4tm70z5rz6</a></td></tr>
    <tr><td>LTC P2SH Segwit</td><td><a href="https://ltc1.trezor.io/address/MKcAge42cX6WZnnPfFGJAxReUYZUbsi6t3">MKcAge42cX6WZnnPfFGJAxReUYZUbsi6t3</a></td></tr>
    <tr><td>Etherum or any ERC20 token </td><td><a href="https://etherscan.io/address/0xBc72A79357Ff7A59265725ECB1A9bFa59330DB4b">0xBc72A79357Ff7A59265725ECB1A9bFa59330DB4b</a></td></tr>
  </table>

### Brave / BAT / Referrals

If your browsing with the [Brave browser](https://brave.com/bri541) you can tip BAT directly from your browser.  Just click the red triangle BAT icon in the URL bar while on this page to send me a tip.  You could also use my referrals for a [Trezor](https://shop.trezor.io/?offer_id=10&aff_id=4623) wallet, a [CryptoSteel](https://shop.trezor.io/product/cryptosteel?offer_id=23&aff_id=4623) backup, or a [Coinbase](https://www.coinbase.com/join/51d3b6d15292df353a000008), [Binance](https://www.binance.com/?ref=11716666), or [CashApp](https://cash.app/app/VGDKRBT) account.  If you join Coinbase, please use Pro, and read the TOS.  Assuming your ok with all that, you could try to sign-up to earn [XLM](https://coinbase.com/earn/xlm/invite/hc8jwk96), [EOS](https://coinbase.com/earn/eos/invite/6mtrf1w4), or [OXT](https://coinbase.com/earn/oxt/invite/4txq1d3n) though I think many of those grant faucets may now be dry.   Please let me know if any actually work.

### Testnet / Valueless Coins

These are all coins of no value that I simply collect as one may collect bottle caps.  You can acquire them free from any faucet you like.  If you don't see a coin you would like to contribute, simply [open an issue](../../issues/new/choose) requesting I add it and I will

  <table>
    <tr><td>BTC testnet P2PKH </td><td><a href="https://tbtc1.trezor.io/address/mpaMBuoJ7ZiiJhmRZVvDT3JPncZV7XTeyy">mpaMBuoJ7ZiiJhmRZVvDT3JPncZV7XTeyy</a></td></tr>
    <tr><td>BTC testnet P2SH segwit </td><td><a href="https://tbtc1.trezor.io/address/2N1bhQ2Cp8QKt88ds9udWE1TGX89cebNMRW">2N1bhQ2Cp8QKt88ds9udWE1TGX89cebNMRW</a></td></tr>
    <tr><td>BTC testnet P2SH bech32 segwit </td><td><a href="https://tbtc1.trezor.io/address/tb1qr3lzhp555lzxecjrae2vsl7mtnherxnau5tfe5">tb1qr3lzhp555lzxecjrae2vsl7mtnherxnau5tfe5</a></td></tr>
    <tr><td>BCH testnet cashaddr </td><td><a href="https://explorer.bitcoin.com/tbch/address/bchtest:qp346ld04gnll2n3u2zr2uvy8slrpkagvvy7rdrmev">bchtest:qp346ld04gnll2n3u2zr2uvy8slrpkagvvy7rdrmev</a></td></tr>
    <tr><td>LTC testnet P2PKH </td><td><a href="https://testnet.litecore.io/address/mpaMBuoJ7ZiiJhmRZVvDT3JPncZV7XTeyy">mpaMBuoJ7ZiiJhmRZVvDT3JPncZV7XTeyy</a></td></tr>
    <tr><td>LTC testnet P2SH segwit </td><td><a href="https://testnet.litecore.io/address/QUxTX3549WNyGKPun1fXJhthfWbSSKWxaL">QUxTX3549WNyGKPun1fXJhthfWbSSKWxaL</a></td></tr>
    <tr><td>ETH Robsten </td><td><a href="https://ropsten.etherscan.io/address/0xF7A1009746850D1581AB8b4A87bf5810775925fe">0xF7A1009746850D1581AB8b4A87bf5810775925fe</a></td></tr>
    <tr><td>ETH Rinkeby or RIN-ERC20 </td><td><a href="https://rinkeby.etherscan.io/address/0x042b19E19e857dB8B28939bA0F94920aca83d2f9">0x042b19E19e857dB8B28939bA0F94920aca83d2f9</a></td></tr>
  </table>

<!-- end_footer -->
