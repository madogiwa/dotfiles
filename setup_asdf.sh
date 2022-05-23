#!/bin/sh

##
## node.js
##

asdf plugin add nodejs
asdf install nodejs lts-fermium
asdf install nodejs $(cat tool-versions|grep nodejs|awk '{print $2}')
asdf reshim nodejs

##
## yarn
##

asdf plugin add yarn
asdf install yarn $(cat tool-versions|grep yarn|awk '{print $2}')

##
## ruby
##

asdf plugin add ruby
asdf install ruby latest:2.3
asdf install ruby $(cat tool-versions|grep ruby|awk '{print $2}')
asdf reshim ruby

##
## python
##

asdf plugin add python
asdf install python latest:3.7
asdf install python latest:3.8
asdf install python $(cat tool-versions|grep python|awk '{print $2}')
asdf reshim python

##
## go
##

asdf plugin add golang
asdf install golang latest:1.15
asdf install golang latest:1.16
asdf install golang latest:1.17
asdf install golang $(cat tool-versions|grep golang|awk '{print $2}')
asdf reshim golang

##
## perl
##

asdf plugin add perl
asdf install perl 5.16.3
asdf install perl $(cat tool-versions|grep perl|awk '{print $2}')
asdf reshim perl

##
## Java
##

asdf plugin add java
asdf install java latest:adoptopenjdk-8.0
asdf install java $(cat tool-versions|grep java|awk '{print $2}')

asdf plugin add maven
asdf install maven $(cat tool-versions|grep maven|awk '{print $2}')

asdf plugin add sbt
asdf install sbt 1.4.9
asdf install sbt $(cat tool-versions|grep sbt|awk '{print $2}')

