#!/bin/bash
# [rights]  Copyright brianddk 2019 https://github.com/brianddk
# [license] Apache 2.0 License https://www.apache.org/licenses/LICENSE-2.0
# [repo]    https://github.com/brianddk/trezor-tails/
# [tipjar]  LTC: LQjSwZLigtgqHA3rE14yeRNbNNY2r3tXcA or https://git.io/fh6b0

### A one-liner to run the script ###
# bash <(wget -O- https://raw.githubusercontent.com/brianddk/trezor-tails/dev/bootstrap.sh)

### To modify first ###
# install -m 0700 <(wget -O- https://raw.githubusercontent.com/brianddk/trezor-tails/master/bootstrap.sh) /tmp/bootstrap.sh
# gedit /tmp/bootstrap.sh
# /tmp/bootstrap.sh

# OPTIONS: Everything before /END can be modified to your preference.
# Add a `#` in column one to disable a feature
available="
05_swap
10_udev
15_bash
20_gnome
25_python_trezor
30_bridge
35_chromium
40_electrum_btc
"
# /END

enabled="$(grep -v "^#\|^$" <<< "$available" | sort)"
persist="/live/persistence/TailsData_unlocked"
repo="trezor-tails"
assets="/tmp/$repo/assets"
modules="/tmp/$repo/modules"

# Torify our shell
export http_proxy="socks5://127.0.0.1:9050"
export https_proxy="socks5://127.0.0.1:9050"
export no_proxy="localhost,127.0.0.1"

err_report() {
  msg="errexit on line $(caller)"
  echo "$msg" >&2
  zenity --error --text="$msg" 1> /dev/null 2>&1
  false
}

source_mods() {
  for i in $enabled
  do
    mod="$modules/$i"
    echo "#### sourcing $mod ####"
    source $mod
  done
}
user_first_stage() {
  # export msg="DBG: CLONING"; zenity --info --text="$msg" 1> /dev/null 2>&1

  for i in $enabled
  do
    s1func="${i:3}_s1"
    echo "#### calling $s1func ####"
    $s1func
  done

  rsync -a -v ./dotfile-stage/ $persist/dotfiles/
}

sudo_second_stage() {
  source_mods

  # export msg="DBG: INITIALIZING PYTHON"; zenity --info --text="$msg" 1> /dev/null 2>&1
  mkdir -p $persist/local/{lib,bin}
  chown -R amnesia:amnesia $persist/local

  apt_update="apt-get update"
  
  for i in $enabled
  do
    s2func="${i:3}_s2"
    echo "#### calling $s2func ####"
    $s2func
  done

  # set up persistence
  cat $assets/delta-persistence.conf >> $persist/persistence.conf
}

user_third_stage() {
  for i in $enabled
  do
    s3func="${i:3}_s3"
    echo "#### calling $s3func ####"
    $s3func
  done
}

main() {
  pushd /tmp
  if [ -d /tmp/$repo ]; then rm -rf /tmp/$repo; fi

  git clone -b dev https://github.com/brianddk/$repo.git
  install -m 0700 $0 /tmp/$repo/bootstrap.sh
  cd $assets
  
  source_mods
  
  user_first_stage

  export msg="I need root, please return to terminal and enter password"
  zenity --question --text="$msg" 1> /dev/null 2>&1
  sudo /tmp/$repo/bootstrap.sh sudo_second_stage

  user_third_stage
}

set -eE -o pipefail
trap err_report ERR
# play nice
renice 19 $$
if [ $# -eq 0 ]
then
  main
else
  $1
fi
