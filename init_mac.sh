#!/usr/bin/exec bash
#
# Usage: bash -c "$( curl -fsSL https://raw.github.com/hokariyutaka/dotfiles/main/init_mac.sh )"
#

# exec option
set -eu

# 
WORKDIR="Work"
REPOGITORY="dotfiles"
WORKPATH="$HOME/$WORKDIR"
REPOGITORYPATH="$WORKPATH/$REPOGITORY"
GITHUB_URL="https://github.com/hokariyutaka/"

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

# install homebrew (with Command Line Tools for Xcode)
brew -v 1>/dev/null || {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# check Work Directory
if [ ! -d $WORKPATH ] ; then
  mkdir -p $WORKPATH
fi

# get GitHub Repogitory
if [ ! -d $REPOGITORYPATH ] ; then
  cd $WORKPATH
  git clone "$GITHUB_URL$REPOGITORY.git"
fi

# brew bundle
cd "$REPOGITORYPATH/homebrew"
brew bundle
