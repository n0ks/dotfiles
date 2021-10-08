#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `setup.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

echo "Hello $(whoami)! Let's get you set up."

echo "installing homebrew"
# install homebrew https://brew.sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew update

echo "mkdir -p ${HOME}/code"
mkdir -p "${HOME}/code"
echo "cloning repos"
git clone https://github.com/n0ks/dotfiles.git "${HOME}/dotfiles"
git clone https://github.com/alacritty/alacritty.git "${HOME}/code"
git clone https://github.com/neovim/neovim.git "${HOME}/code"

xcode-select --install

echo "making system modifications:"

###############################################################################
# 📱 Dock
###############################################################################

defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0.05
defaults write com.apple.dock autohide-time-modifier -float 0.25
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock show-process-indicators -bool true
# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false
# Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "scale"

# Set the icon size of Dock items to 24 pixels
defaults write com.apple.dock tilesize -int 24

###############################################################################
# 🎛 Mission Control
###############################################################################

defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

killall Dock

###############################################################################
# ⌨️ Keyboard
###############################################################################

defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Disable press-and-hold for keys in favour of key repeat
defaults write -g ApplePressAndHoldEnabled -bool true

# Disable automatic modifications of entered text
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# 💻 Trackpad
###############################################################################

# Tracking Speed: from 0 to 3
defaults write -g com.apple.trackpad.scaling -float 3

# Enable tap to click for the current user and the login screen. (Don't have to press down on the trackpad -- just tap it.)
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1
defaults write -g com.apple.mouse.tapBehavior -int 1

# Trackpad: map two fingers tap to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write -g com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write -g com.apple.trackpad.enableSecondaryClick -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -int 1


###############################################################################
# 💻 Reduce motion & transparency
###############################################################################

defaults write com.apple.Accessibility DifferentiateWithoutColor -int 1
defaults write com.apple.Accessibility ReduceMotionEnabled -int 1
defaults write com.apple.universalaccess reduceMotion -int 1
defaults write com.apple.universalaccess reduceTransparency -int 1
defaults write com.apple.Accessibility ReduceMotionEnabled -int 1

###############################################################################
# 📂 Finder
###############################################################################

defaults write com.apple.finder DisableAllAnimations -bool true
defaults write -g AppleShowAllExtensions -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FinderSpawnTab -bool false
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder QLEnableTextSelection -bool TRUE

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
killall Finder

###############################################################################
# 📊 Activity Monitor
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# 🎚️ Others
###############################################################################

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
# Disable the crash reporter
defaults write com.apple.CrashReporter DialogType -string "none"

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4
