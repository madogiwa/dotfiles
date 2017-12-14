
## check current directory
if [ ! -e install.sh ]; then
    echo "install.sh not found."
    exit 1
fi

## dotfiles
dotfiles=(
  ".zshrc"
  ".zshenv"
  ".inputrc"
  ".screenrc"
  ".my.cnf"
  ".vimrc"
  ".gitconfig"
  ".gitignore_global"
  ".ssh/config"
  ".Brewfile"
)

## make dotfiles link
for file in "${dotfiles[@]}"; do
    ln -snf `pwd`/$file $HOME/$file
done

## Homebrew
if [[ "$OSTYPE" =~ darwin ]]; then
    if [ ! -e /usr/local/bin/brew ]; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    brew bundle --global
fi

