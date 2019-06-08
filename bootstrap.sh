#!/bin/bash

# we will source this file

err_report() {
  rc=1
  if [ -z "$1" ]
  then
    rc=$1
  fi
  touch $locksdir/.error
  msg="errexit on line $(caller)"
  echo "$msg" >&2
  zenity --error --text="$msg" 1> /dev/null 2>&1
  exit $rc
}

wait_for_signal() {
  while [ ! -f $1 ]
    do sleep 5
    # shh echo "waiting on $1"
    [[ ! -f $locksdir/.error ]] || err_report 2
  done
}

start_sudo_thread() { 
  sleep 1
  sudo_thread &
}

user_first_stage() {
  rm -rf $locksdir 2> /dev/null
  pushd /tmp
  [[ ! -d /tmp/$repo ]] || rm -rf /tmp/$repo

  git clone https://github.com/brianddk/$repo.git
  chmod +x /tmp/$repo/bootstrap.sh
  cd $assets
  mkdir $locksdir
  mkdir ./dotfile-stage
  mkdir $assets/udev
  wget -P $assets/udev https://raw.githubusercontent.com/trezor/trezor-common/master/udev/51-trezor.rules

  # Populate dotfiles
  mkdir -p ./dotfile-stage/.config/{dconf,chromium/Default}
  touch "./dotfile-stage/.config/chromium/First Run"
  cp "Local State" ./dotfile-stage/.config/chromium/
  cp Preferences ./dotfile-stage/.config/chromium/Default
  cp bash_profile ./dotfile-stage/.bash_profile
  cat ~amnesia/.bashrc delta-bashrc > ./dotfile-stage/.bashrc

  # Load gnome-proxy
  dconf load / < user.ini
  mv ~amnesia/.config/dconf/user ./dotfile-stage/.config/dconf
  
  rsync -a -v ./dotfile-stage/ $persist/dotfiles/
}

sudo_thread() {
  rm -rf $locksdir 2> /dev/null
  mkdir $locksdir
  chown -R amnesia:amnesia $locksdir

  # sudo_second_stage
  msg="Installing TEMPORARY packages, you can choose 'Install only Once' option"
  zenity --info --text="$msg" 1> /dev/null 2>&1 &
  
  # Install packages needed for python / pip
  apt-get update
  apt-get install -y python3-dev python3-pip cython3 libusb-1.0-0-dev libudev-dev build-essential python3-wheel
  
  msg="Done installing TEMPORARY packages, choose 'Install only Once' option"
  zenity --info --text="$msg" 1> /dev/null 2>&1 &

  # sudo_signal_done
  touch $locksdir/.second_stage_done
  
  # sudo_waitfor_user
  wait_for_signal $locksdir/.third_stage_done || err_report 3

  # sudo_fourth_stage
  rsync -a ~amnesia/.local/ $persist/local
  rsync -rltD $assets/udev/ $persist
  cat $assets/delta-persistence.conf >> $persist/persistence.conf

  # sudo_signal_done
  touch $locksdir/.fourth_stage_done
  chown -R amnesia:amnesia $locksdir
}

user_thread() {
  # user_waitfor_sudo
  echo "wait_for_signal $locksdir/.second_stage_done "
  wait_for_signal $locksdir/.second_stage_done || err_report 4

  # user_third_stage
  pip3 install --user --upgrade setuptools
  pip3 install --user --upgrade trezor[ethereum,hidapi]
  
  mkdir -p $persist/local/share/applications
  chown -R amnesia:amnesia $persist/local
  # user_signal_done
  touch $locksdir/.third_stage_done
}

user_final_state() {
  [[ -f $locksdir/.error ]] && err_report 5
  # user_waitfor_sudo
  # user_waitfor_sudo
  wait_for_signal $locksdir/.fourth_stage_done || err_report 6
  # End times post root

  cp $assets/electrumApp.desktop $persist/local/share/applications
}

main() {
  user_first_stage || err_report 7

  msg="I need root, please return to terminal and enter password"
  zenity --question --text="$msg" 1> /dev/null 2>&1 || err_report 8
  sudo /tmp/$repo/bootstrap.sh start_sudo_thread
  /tmp/$repo/bootstrap.sh user_thread &
  user_final_state || err_report 9
}

trap err_report ERR
persist="/live/persistence/TailsData_unlocked"
repo="trezor-tails"
locksdir="/tmp/$repo/locks"
assets=/tmp/$repo/assets

# Torify our shell
export http_proxy=socks5://127.0.0.1:9050
export https_proxy=socks5://127.0.0.1:9050

# play nice
renice 19 $$
if [ $# -eq 0 ]
then
  main
else
  $1
fi