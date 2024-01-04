#!/bin/sh

##
## install mise for x86_64
##
(
  eval "$(/usr/local/bin/brew shellenv)"
  arch -x86_64 brew install mise
)


##
## install default versions
##
mise install


##
## python
##
mise install python@2.7
mise install python@3.7


##
## node.js
##
(
  eval "$(/usr/local/bin/brew shellenv)"
  mise shell python@2.7
  arch -x86_64 mise install nodejs@10
)
(
  eval "$(/usr/local/bin/brew shellenv)"
  mise shell python@3.7
  arch -x86_64 mise install nodejs@14
)
mise install nodejs@16


##
## ruby
##
(
  eval "$(/usr/local/bin/brew shellenv)"
  mise install ruby@2.3
)
(
  export RUBY_CFLAGS='-DUSE_FFI_CLOSURE_ALLOC -Wno-error=implicit-function-declaration'
  mise install ruby@2.4
)


##
## go
##
mise install golang@1.16


##
## perl
##
mise install perl@5.16.3


##
## java
##
mise install java@corretto-8
mise install java@temurin-11


##
## maven
##
mise install maven@3.8.8


##
## sbt
##
mise install sbt@1.6


##
## serverless
##
mise install serverless@2
