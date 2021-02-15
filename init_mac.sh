#!/usr/bin/exec bash
#
# Usage: bash <( curl -sSL https://raw.githubusercontent.com/hokariyutaka/dotfiles/main/init_mac.sh )
#

# exec option
# set -eux

# get administrator password
sudo -v

# change hostname
echo ""
echo "Would you like to set your computer name?  (y/n)"
read -r response
if [[ $response =~ ([yY]) ]] ; then
  echo "What name would you like?"
  read HOST_NAME
  sudo scutil --set ComputerName $HOST_NAME
  sudo scutil --set LocalHostName $HOST_NAME
  sudo scutil --set HostName $HOST_NAME
fi

# disable shadow when screencapture
defaults write com.apple.screencapture disable-shadow -boolean true

# change screencapture location
SCREENSHOT_TARGET=~/Pictures/ScreenShots
if [ ! -d $SCREENSHOT_TARGET ]; then
  mkdir -p $SCREENSHOT_TARGET
fi
defaults write com.apple.screencapture location $SCREENSHOT_TARGET
