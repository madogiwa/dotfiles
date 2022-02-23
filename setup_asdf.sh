#!/bin/sh

##
## node.js
##

asdf plugin add nodejs
asdf install nodejs latest:14
asdf install nodejs 16.13.0
asdf reshim nodejs

##
## ruby
##

asdf plugin add ruby
asdf install ruby latest:2.3
asdf install ruby 3.0.2
asdf reshim ruby

##
## python
##

asdf plugin add python
asdf install python latest:3.7
asdf install python latest:3.8
asdf install python 3.9.7
asdf reshim python

##
## go
##

asdf plugin add golang
asdf install golang latest:1.16
asdf install golang 1.17.7
asdf reshim golang

##
## perl
##

asdf plugin add perl
asdf install perl 5.32.1
asdf install perl 5.34.0
asdf reshim perl

