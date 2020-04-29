## Brave-Browser

Todo

- [ ] Take `user_namespace` hack out of module
- [ ] Consider baselining all work off Brave

## TrezorCTL
## TrezorLib



## Chromium-Browser
## Magnum

Requires modules `{brave}`

## Crypto-Wallet

***Blocked by Cloudflare***

Todo

- [ ] Move to WIP
- [ ] Try with system proxy on Tor
- [ ] Try with other Brave channels
- [ ] Try with Chrome

## Electron-Cash
## Electrum

Required if `{python_trezor}` is installed

## MyEtherWallet

Requires modules `{brave, bridge}`

## MyCrypto

Requires modules `{brave, bridge}`

## Trezor-Beta-Wallet

## Trezor-Bridge

Todo

- [ ] Take TTB enablement out and move to a new `{ttb_bridge}` module

## Trezor-Password-Manger

Requires modules `{brave}`

Todo

- [ ] Determine if there is any work to persist extensions

## Trezor-Web-Wallet

Optional ways to use it:
* Through Tor Browser `{bridge, ttp_bridge}`
* Through Brave Browser `{brave}`

Todo

- [ ] Consider requiring this to run under Brave