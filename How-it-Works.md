## Compromises

In order to get this to work, some of the privacy and security of Tails was dialed back a bit.  You should be aware of these modifications before using this too extensively

#### IPTables

Normally Tails will block traffic directed at the virtualized NIC called `localhost` (127.0.0.1).  This is intentional and it is meant to guard against certain attacks that can happen through the `localhost` adapter.  These changes were required for the `bridge` module that is used by Trezor.

#### User.js

In order to allow the Tor Browser to talk to the Trezor bridge, `localhost` had to be excluded from routing through the proxy.  This is normally the default setting, but Tails enforces all traffic through the proxy to ensure no privacy is leaked.  Furthermore, since the Trezor Bridge does not support SSL, mixed content had to be enabled.  This is the reason why the Trezor Web-Wallet shows the broken lock in the URL.  Both of these changes are also in the `bridge` module.

#### Unprivileged User Namespace

The `brave_browser` module required enabling `unprivileged_user_namespaces` at runtime.  Honestly this may no longer be required, but the code for its use has not been recently reviewed. 

