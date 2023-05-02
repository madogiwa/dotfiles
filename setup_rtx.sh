#!/bin/sh

##
## install default versions
##
rtx install


##
## python
##

rtx install python@2.7
rtx install python@3.7


##
## node.js
##

(
  rtx shell python@2.7
  arch -x86_64 rtx install nodejs@10
)
rtx shell python system

rtx install nodejs@12
rtx install nodejs@14
rtx install nodejs@16


##
## ruby
##

rtx install ruby@2.3


##
## go
##

rtx install golang@1.15
rtx install golang@1.16
rtx install golang@1.17
rtx install golang@1.18
rtx install golang@1.19


##
## perl
##

rtx install perl@5.16.3

