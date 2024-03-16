#!/bin/zsh

## install xcode tools
xcode-select --install
if [ $? -eq 0 ]; then
    read \?"Waiting xcode-select install... press [Enter] to continue."
fi

## Install Homebrew (x86_64)
if [[ ! -e "/usr/local/bin/brew" ]]; then
    arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

## install Homebrew (arm64)
if [[ ! -e "/usr/local/bin/brew" && "$(uname -m)" = "arm64" ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

fi

if [[ "$(uname -m)" = "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

## Install from Brewfile
brew bundle --file=Brewfile.mas
brew bundle --file=Brewfile

## Restore Command Line Tools path
sudo xcode-select -s /Library/Developer/CommandLineTools

## fix compinit insecure directories
chmod 755 /opt/homebrew/share
chmod 755 /opt/homebrew/share/zsh
chmod 755 /opt/homebrew/share/zsh/site-functions

## install tpm(tmux package manager)
rm -rf ~/.tmux/plugins/tpm && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

## ssh folder
mkdir -p ~/.ssh
chmod 700 ~/.ssh

## write defaults
### do not create .DS_Store in external storage
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

### enable text selection in QuickLook
defaults write com.apple.finder QLEnableTextSelection true

### set default format to PlainText in TextEdit
defaults write com.apple.TextEdit RichText -int 0

### show CrashReporter into notification center
defaults write com.apple.CrashReporter UseUNC 1

### show dotfiles in Finder
defaults write com.apple.finder AppleShowAllFiles TRUE


## rcm & tpm
echo ""
echo "========================================================================"
echo "rcup -d ~/src/github.com/madogiwa/dotfiles rcrc"
echo "rcup -d ~/src/github.com/madogiwa/dotfiles"
echo "ln -s ~/src/github.com/madogiwa/dotfiles/bin ~/bin"
echo "tmux"
echo "tmux run-shell ~/.tmux/plugins/tpm/bindings/install_plugins"
echo "========================================================================"
echo ""

