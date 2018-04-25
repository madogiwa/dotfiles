
## Homebrew
if [[ "$OSTYPE" =~ darwin ]]; then
    if [ ! -e /usr/local/bin/brew ]; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    brew bundle --file=Brewfile
fi

## rcm
rcup

