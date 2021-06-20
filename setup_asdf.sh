#!/bin/sh

##
## node.js
##

asdf plugin add nodejs
asdf install nodejs latest:14
asdf reshim nodejs

##
## ruby
##

asdf plugin add ruby
asdf install ruby latest:2.3
asdf install ruby latest:3.0
asdf reshim ruby

##
## python
##

asdf plugin add python
asdf install python latest:3.8
asdf install python latest:3.7
asdf reshim python

##
## go
##

asdf plugin add golang
asdf install golang latest:1.16
asdf reshim golang

##
## perl
##

asdf plugin add perl
asdf install perl 5.16.2
asdf install perl 5.32.1
asdf reshim perl

