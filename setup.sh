#!/bin/zsh

## install xcode tools
xcode-select --install
if [ $? -eq 0 ]; then
    read \?"Waiting xcode-select install... press [Enter] to continue."
fi

## use Xcode bundled Command Line Tools
echo "switch Command Line Tools to /Application/Xcode.app"
sudo xcodebuild -license accept
sudo xcode-select --switch /Applications/Xcode.app

## install Homebrew
if [ "$(uname -m)" = "x86_64" ]; then
    if [ ! -e "/usr/local/bin/brew" ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    eval "$(/usr/local/bin/brew shellenv)"
else
    if [ ! -e "/opt/homebrew/bin/brew" ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    eval "$(/opt/homebrew/bin/brew shellenv)"
fi


brew bundle --file=Brewfile.mas
brew bundle --file=Brewfile

## fix compinit insecure directories
chmod 755 /usr/local/share/zsh
chmod 755 /usr/local/share/zsh/site-functions

## install tpm(tmux package manager)
rm -rf ~/.tmux/plugins/tpm && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

## install zinit
if [[ ! -d ~/.zinit ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
fi

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

