#!/bin/bash

# we will source this file

err_report() {
  touch $locksdir/.error
  msg="errexit on line $(caller)"
  echo "$msg" >&2
  zenity --error --text="$msg"
  exit 1
}

wait_for_signal() {
  while [ ! -f $1 ]
    do sleep 1000
    [[ -f $locksdir/.error ]] && exit 2
  done
}

start_sudo_thread() { 
  echo "rc: $?"
  sleep 1
  echo "rc: $?"
  echo "in sudo_thread_start"
  echo "rc: $?"
  sudo_thread &
}

user_first_stage() {
  trap ERR
  rm -rf $locksdir 2> /dev/null
  trap err_report ERR
  pushd /tmp

  # Get our repo
  git clone https://github.com/brianddk/$repo.git
  chmod +x $assets/bootstrap.sh
  cd $assets
  mkdir $locksdir

  # Populate dotfiles
  mkdir -p $persist/dotfiles/.config/{dconf,chromium/Default}
  touch "$persist/dotfiles/.config/chromium/First Run"
  cp "Local State" $persist/dotfiles/.config/chromium/
  cp Preferences $persist/dotfiles/.config/chromium/Default
  cp bash_profile $persist/dotfiles/.config/.bash_profile
  cat delta-bashrc >> ~amnesia/.bashrc
  mv ~amnesia/.bashrc $persist/dotfiles/.config/.bashrc

  # Load gnome-proxy
  dconf load / < user.ini
  mv ~amnesia/.config/dconf/user $persist/dotfiles/.config/dconf
}

sudo_thread() {
  trap ERR
  rm -rf $locksdir 2> /dev/null
  trap err_report ERR

  # sudo_second_stage
  msg="Installing TEMPORARY packages, you can choose NOT to persist these packages"
  zenity --question --text="$msg" &
  
  # Install packages needed for python / pip
  apt-get install python3-dev python3-pip cython3 libusb-1.0-0-dev libudev-dev build-essential python3-wheel
  
  msg="Done installing TEMPORARY packages, choose NOT to persist these packages"
  zenity --question --text="$msg" &

  # sudo_signal_done
  touch $locksdir/.second_stage_done
  
  # sudo_waitfor_user
  wait_for_signal $locksdir/.third_stage_done || exit 4

  # sudo_fourth_stage
  mv ~amnesia/.local $persist/local
  cat $assets/delta-persistance.conf >> $persist/persistance.conf

  # sudo_signal_done
}

user_thread() {
  trap err_report ERR
  # user_waitfor_sudo
  wait_for_signal $locksdir/.second_stage_done || exit 5

  # user_third_stage
  pip3 install --user --upgrade setuptools
  pip3 install --user --upgrade trezor[ethereum,hidapi]
  
  # user_signal_done
  touch $locksdir/.third_stage_done
}

user_final_state() {
  trap err_report ERR
  [[ -f $locksdir/.error ]] && exit 6
  # user_waitfor_sudo
  # End times post root
  mkdir -p $persist/local/share/applications
  cp $assets/electrumApp.desktop $persist/local/share/applications
}

main() {
  user_first_stage || exit 7

  trap ERR
  msg="I need root, please return to terminal and enter password"
  zenity --question --text="$msg" || exit 8
  echo "rc: $?"
  sudo $assets/bootstrap.sh start_sudo_thread
  echo "rc: $?"
  trap err_report ERR
  user_thread &
  user_final_state || exit 9
}

trap err_report ERR
persist="/live/persistence/TailsData_unlocked"
repo="trezor-tails"
locksdir="/tmp/$repo/locks"
assets=/tmp/$repo/assets

# Torify our shell
export http_proxy=socks5://127.0.0.1:9050
export https_proxy=socks5://127.0.0.1:9050

if [ $# -eq 0 ]
then
  main
else
  $1
fi
