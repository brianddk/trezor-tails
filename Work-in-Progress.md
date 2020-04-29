## Tails 4.11

The current release of Tails as of this writing Tails v4.5.  The `devl` builds on their build server report as Tails v4.11.  I'll need to load 4.11 in a VM and put it through it's paces to determine if there are any security issues.  Anyone wishing to [[make a PR|Contributing#Submitting a PR]] for any changes that may ensure from 4.5 to 4.11 is welcome to submit.

## Bisq

Bisq (aka Bitsquare) is a decentralized exchange (DEX) protocol.  They release a client (bisq) which members of the exchange can run in order to join the DEX to issue and make trades.  Bisq is very focused on anonymity and privacy making them a good addition to any Tails toolset, but since their wallets are based on escrows, there doesn't seem to be a clear path for Trezor support.  In either case, it might still be fun to add it.

Work items to do to make Bisq work.

- [ ] Determine where Bisq keeps it's profile data and how complete that warehouse is
- [ ] Determine if Bisq uses any Cloudflare CDN endpoints that will confound Tor
- [ ] Determine if the Bisq `dep` is self contained for `buster` or if it pulls in other packages
- [ ] Determine if Bisq has native `onion` support that might simplify the workflow

#### References

* Initial Request: https://www.reddit.com/r/Bitcoin/comments/gajyer/_/fp03wjn/
* Offer to Add: TBD-Under Moderation at r/Bisq

## Electrum-LTC

Electrum LTC should be a carbon copy of both Electrum (BTC) and Electron-Cash (BCH).  Honestly I expect no hurdles rolling out this AppImage.

Todo:

- [x] Verify that the current release is available via AppImage.
- [ ] Copypasta the Electrum module

## Exodus

***BLOCKED***

Exodus is a great multi-coin wallet with Trezor support built in.  This would be a great alternate option for coverage on any coins not supported in the web-wallet or beta-wallet

Todo list and completed / blocking items:

Work items to do to make Exodus work.

- [x] Determine if the Exodus`dep` is self contained for `buster` or if it pulls in other packages
- [x] Determine if Exodus uses Cloudflare CDN that will confound Tor ***ANNOYANCE: Requires obfs4***
- [x] Try with `obfs4` bridge enabled to see if it can bypass Cloudflare
- [x] Exodus profile data and how complete that warehouse is ***~/.config/Exodus***
- [x] Test recovery workflow ***ANNOYANCE: recovery requires unpriv userns***
- [x] Test if `unprivileged_userns_clone` fixes recovery
- [ ] ~~Test if rescan succeeds on SLIP0014 restore~~ ***BLOCKED: obfs4 isn't enough***
- [ ] Determine if Exodus has native `onion` support that might simplify the workflow

#### References

* Initial test of interest: https://www.reddit.com/r/ExodusWallet/comments/g9hjpb/
* Response of "unlikely": https://www.reddit.com/r/ExodusWallet/comments/g9hjpb/_/fou77h3/
* Alert to security flaw: https://www.reddit.com/r/ExodusWallet/comments/gb0iwd/

## Electrum-FTC

***BLOCKED***

Todo: 

- [x] ~~Verify that the current release is available via AppImage~~ ***BLOCKER: no AppImage***
- [ ] Make either an CR or PR to the Electrum-FTC project requesting an AppImage.

## ElectrumSV

***BLOCKED***

Todo: 

- [x] ~~Verify that the current release is available via AppImage~~ ***BLOCKER: no AppImage***
- [ ] Make either an CR or PR to the ElectrumSV project requesting an AppImage.

## MyCrypto-AppImage

***BLOCKED***

MyCrypto Web-Wallet is currently working via Brave when connecting to tails through `obfs4`, so there is very little incentive to get this working as an AppImage.  Plus the AppImage is 70+ MB so it may be a torturous install over Tor

Todo:

- [x] Verify that the current release is available via AppImage.
- [x] ~~Determine if MyCrypto uses Cloudflare CDN that will confound Tor~~ ***BLOCKER: Cloudflare***
- [x] Try with `obfs4` bridge enabled to see if it can bypass Cloudflare ***It does not***
- [ ] Determine where MyCrypto keeps it's profile data and how complete that warehouse is
- [ ] Determine if MyCrypto has native `onion` support that might simplify the workflow

Fails on Trezor Connect with the following message:
```
Request to 'eth-enclave://get-chain-code/' failed with error: Error: No device connected
    at DeviceList.stealFirstDevice (/tmp/.mount_linux-bVt1gd/app/resources/app.asar/main.js:51960:39)
    at /tmp/.mount_linux-bVt1gd/app/resources/app.asar/main.js:51990:24
    at new Promise (<anonymous>)
    at DeviceList.acquireFirstDevice (/tmp/.mount_linux-bVt1gd/app/resources/app.asar/main.js:51989:20)
    at _callee5$ (/tmp/.mount_linux-bVt1gd/app/resources/app.asar/main.js:24115:31)
    at tryCatch (/tmp/.mount_linux-bVt1gd/app/resources/app.asar/main.js:13826:40)
    at Generator.invoke [as _invoke] (/tmp/.mount_linux-bVt1gd/app/resources/app.asar/main.js:14060:22)
    at Generator.prototype.(anonymous function) [as next] (/tmp/.mount_linux-bVt1gd/app/resources/app.asar/main.js:13878:21)
    at asyncGeneratorStep (/tmp/.mount_linux-bVt1gd/app/resources/app.asar/main.js:24067:103)
    at _next (/tmp/.mount_linux-bVt1gd/app/resources/app.asar/main.js:24069:194)
```