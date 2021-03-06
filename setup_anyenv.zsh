#!/bin/zsh

anyenv install --init
anyenv update

## node
anyenv install -f nodenv
source ~/.zshrc
ln -s ~/.anyenv/envs/nodenv ~/.nodenv

prefix="14"
latest=`nodenv install -l | grep -E "^\s*${prefix}[0-9.]*$" | sort -V -r | head -n 1 | tr -d ' '`
echo "install node ${latest}"
nodenv uninstall -f ${latest}
nodenv install ${latest}
nodenv global ${latest}

npm install -g npm
npm install -g yarn
npm install -g typescript
npm install -g ts-node
npm install -g typesync
npm install -g @vue/cli
npm install -g @vue/cli-init
npm install -g @angular/cli
npm install -g @angular/cli
npm install -g firebase-tools
npm install -g expo-cli
npm install -g ionic
npm install -g cordova
npm install -g cordova-res
npm install -g serverless
npm install -g awsp
npm install -g yo generator-web-extension
nodenv rehash


## ruby
anyenv install -f rbenv
source ~/.zshrc
ln -s ~/.anyenv/envs/rbenv ~/.rbenv

prefix=""
latest=`rbenv install -l | grep -E "^\s*${prefix}[0-9.]*$" | sort -V -r | head -n 1 | tr -d ' '`
echo "install ruby ${latest}"
rbenv uninstall -f ${latest}
rbenv install ${latest}
rbenv global ${latest}

rbenv exec gem install bundler
rbenv rehash

rbenv exec gem install mdless
rbenv rehash


## go
anyenv install -f goenv
source ~/.zshrc
ln -s ~/.anyenv/envs/goenv ~/.goenv

prefix=""
latest=`goenv install -l | grep -E "^\s*${prefix}[0-9.]*$" | sort -V -r | head -n 1 | tr -d ' '`
echo "install go ${latest}"
goenv uninstall -f ${latest}
goenv install ${latest}
goenv global ${latest}
goenv rehash

go get -u github.com/spf13/cobra/cobra
go get -u github.com/99designs/gqlgen
go get -u github.com/marianogappa/chart


## perl
anyenv install -f plenv
source ~/.zshrc
ln -s ~/.anyenv/envs/plenv ~/.plenv

prefix="5.32"
latest=`plenv install -l | grep -E "^\s*${prefix}[0-9.]*$" | sort -V -r | head -n 1 | tr -d ' '`
echo "install perl ${latest}"
plenv uninstall -f ${latest}
plenv install ${latest}
plenv global ${latest}
plenv install-cpanm

plenv rehash


## python
anyenv install -f pyenv
source ~/.zshrc
ln -s ~/.anyenv/envs/pyenv ~/.pyenv

prefix="3"
latest=`pyenv install -l | grep -E "^\s*${prefix}[0-9.]*$" | sort -V -r | head -n 1 | tr -d ' '`
echo "install python ${latest}"
pyenv uninstall -f ${latest}
pyenv install ${latest}
pyenv global ${latest}

pyenv rehash

