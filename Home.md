This is a project dedicated to getting the Trezor toolchain and wallets working on [[Tails|https://tails.boum.org/]].  The Tails OS updates much less frequently than either Trezor FW or SW, so this project intends to serve as a stopgap between when new security fixes are released for Trezor rev and when the Tails ISO revs.  The two are rarely ever totally in sync.

This project is not focused on usability, so a fair degree of technical expertise is expected.  For the novice everything can be done with one `wget` command, but to make any changes the repo needs to be cloned an a small bit of `bash` scripting is required.  Please feel free to offer suggestions to optimize its use though.

From a very high level, the project is broken up into ***modules***.  Each module consists for some scripts that it runs to get the work done.  To install a particular product, simple include the module it is a part of.  The overall structure is detailed more in the [[how it works]] page.

This project consists of two repository and a number of branches listed below

* `trezor-tails` repo - The repo holding all the code with minimal documentation
  * `master` branch - default branch, but not as current as others
  * `scratch` branch - very unstable work in progress, this will be rebased
  * `dev` branch - where completed features are put after minimal testing
  * `v0.11.2` branch - feature branch for the Trezor v0.11.2 release
  * `wiki` branch - a clone of the wiki repo's master branch to allow for wiki PRs
* `trezor-tails.wiki` repo - The documentation branch holding the wiki
   * `master` - The main (only) branch in the wiki repo, mirrored to the wiki branch above.

