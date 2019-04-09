#!/bin/zsh

anyenv update

## node
anyenv install -f nodenv
source ~/.zshrc

prefix="10"
latest=`nodenv install -l | grep -E "^\s*${prefix}[0-9.]*$" | sort -V -r | head -n 1 | tr -d ' '`
echo "install node ${latest}"
nodenv uninstall -f ${latest}
nodenv install ${latest}
nodenv global ${latest}

npm install -g npm
npm install -g yarn
npm install -g @vue/cli
npm install -g @vue/cli-init
npm install -g firebase-tools
npm install -g serverless
npm install -g awsp
npm install -g yo generator-web-extension
nodenv rehash


## ruby
anyenv install -f rbenv
source ~/.zshrc

prefix=""
latest=`rbenv install -l | grep -E "^\s*${prefix}[0-9.]*$" | sort -V -r | head -n 1 | tr -d ' '`
echo "install ruby ${latest}"
rbenv uninstall -f ${latest}
rbenv install ${latest}
rbenv global ${latest}

rbenv exec gem install bundler
rbenv rehash


## go
anyenv install -f goenv
source ~/.zshrc

prefix=""
latest=`goenv install -l | grep -E "^\s*${prefix}[0-9.]*$" | sort -V -r | head -n 1 | tr -d ' '`
echo "install go ${latest}"
goenv uninstall -f ${latest}
goenv install ${latest}
goenv global ${latest}

go get -u github.com/golang/dep/cmd/dep
goenv rehash


## perl
anyenv install -f plenv
source ~/.zshrc

prefix="5.26"
latest=`plenv install -l | grep -E "^\s*${prefix}[0-9.]*$" | sort -V -r | head -n 1 | tr -d ' '`
echo "install perl ${latest}"
plenv uninstall -f ${latest}
plenv install ${latest}
plenv global ${latest}
plenv install-cpanm

plenv rehash

