#!/bin/sh

## install xcode tools
xcode-select --install
if [ $? -eq 0 ]; then
    read \?"Waiting xcode-select install... press [Enter] to continue."
fi

## install Homebrew
if [[ "$OSTYPE" =~ darwin ]]; then
    if [ ! -e /usr/local/bin/brew ]; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    brew bundle --file=Brewfile.mas
    brew bundle --file=Brewfile
fi

## fix compinit insecure directories
chmod 755 /usr/local/share/zsh
chmod 755 /usr/local/share/zsh/site-functions

## use Xcode bundled Command Line Tools
echo "switch Command Line Tools to /Application/Xcode.app"
sudo xcodebuild -license accept
sudo xcode-select --switch /Applications/Xcode.app

## install tpm(tmux package manager)
rm -rf ~/.tmux/plugins/tpm && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

## add zsh into /etc/shells
eval grep '/usr/local/bin/zsh' /etc/shells
if [ $? -ne 0 ]; then
    sudo sh -c 'echo /usr/local/bin/zsh >> /etc/shells'
fi

## install zplugin
if [[ ! -d ~/.zplugin ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
fi

## ssh folder
mkdir -p ~/.ssh
chmod 700 ~/.ssh

## rcm & tpm
echo ""
echo "========================================================================"
echo "rcup -d ~/src/github.com/madogiwa/dotfiles"
echo "tmux"
echo "tmux run-shell ~/.tmux/plugins/tpm/bindings/install_plugins"
echo "========================================================================"
echo ""

