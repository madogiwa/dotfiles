#!/bin/sh

## install Homebrew
if [[ "$OSTYPE" =~ darwin ]]; then
    if [ ! -e /usr/local/bin/brew ]; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    brew bundle --file=Brewfile
fi

## execute rcm
rcup

## install tpm(tmux package manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

## install fisherman
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fisher

## add fish into /etc/shells
`grep fish /etc/shells`
if [ $? -ne 0 ]; then
    sudo sh -c 'echo `which fish` >> /etc/shells'
fi

## install anyenv
git clone https://github.com/riywo/anyenv ~/.anyenv

