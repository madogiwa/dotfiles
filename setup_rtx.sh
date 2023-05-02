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


##
## perl
##
rtx install perl@5.16.3


##
## java
##
rtx install java@temurin-8
rtx install java@temurin-11


##
## maven
##
rtx install maven@3.8


##
## sbt
##
rtx install sbt@1.4
rtx install sbt@1.6


##
## serverless
##
rtx install serverless@2
