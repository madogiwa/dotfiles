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

    brew bundle --file=Brewfile
fi

## install tpm(tmux package manager)
rm -rf ~/.tmux/plugins/tpm && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

## install fisherman
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fish -c fisher

## add fish into /etc/shells
eval grep fish /etc/shells
if [ $? -ne 0 ]; then
    sudo sh -c 'echo `which fish` >> /etc/shells'
fi

## install zplug
rm -rf ~/.zplug && curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

## install anyenv
if [ -d ~/.anyenv ]; then
    echo "~/.anyenv already exists, skip install"
else
    git clone https://github.com/riywo/anyenv ~/.anyenv
    mkdir -p ~/.anyenv/plugins
    git clone https://github.com/znz/anyenv-update.git ~/.anyenv/plugins/anyenv-update
fi

## ssh folder
mkdir -p ~/.ssh
chmod 700 ~/.ssh

## docker-compose files
mkdir -p ~/var/docker/portainer && curl -sL -o ~/var/docker/portainer/docker-compose.yml https://portainer.io/download/docker-compose.yml

## rcm & tpm
echo ""
echo "========================================================================"
echo "rcup -d ~/src/github.com/madogiwa/dotfiles"
echo "tmux"
echo "tmux run-shell ~/.tmux/plugins/tpm/bindings/install_plugins"
echo "========================================================================"
echo ""

