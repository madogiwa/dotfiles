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

npm install -g yarn
yarn global add @vue/cli
yarn global add @vue/cli-init
yarn global add serverless
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


## python
anyenv install -f pyenv
source ~/.zshrc

rm -rf ~/.anyenv/envs/pyenv/plugins/pyenv-virtualenv
git clone git://github.com/pyenv/pyenv-virtualenv.git ~/.anyenv/envs/pyenv/plugins/pyenv-virtualenv
echo "install miniconda3-latest"
pyenv uninstall -f miniconda3-latest
pyenv install miniconda3-latest
pyenv global system miniconda3-latest

prefix=""
latest=`pyenv install -l | grep -E "^\s*${prefix}[0-9.]*$" | sort -V -r | head -n 1 | tr -d ' '`
venv="jupyter"
echo "install python ${latest} based on miniconda3-latest"
pyenv uninstall -f miniconda3-latest/envs/${venv}
conda create -n ${venv} python=${latest} conda

pyenv activate miniconda3-latest/envs/${venv}
conda install -y jupyter
conda install -y pandas
conda install -y matplotlib
conda install -y scikit-learn
conda install -y gensim
pyenv rehash


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

