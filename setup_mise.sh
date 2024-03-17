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
mise -y install


##
## python
##
mise -y install python@2.7
mise -y install python@3.7


##
## node.js
##
(
  eval "$(/usr/local/bin/brew shellenv)"
  mise shell python@2.7
  arch -x86_64 mise -y install nodejs@10
)
(
  eval "$(/usr/local/bin/brew shellenv)"
  mise shell python@3.7
  arch -x86_64 mise -y install nodejs@14
)
mise -y install nodejs@16


##
## ruby
##
(
  eval "$(/usr/local/bin/brew shellenv)"
  mise -y install ruby@2.3
)
(
  export RUBY_CFLAGS='-DUSE_FFI_CLOSURE_ALLOC -Wno-error=implicit-function-declaration'
  export MISE_RUBY_DEFAULT_PACKAGES_FILE=""
  mise -y install ruby@2.4

  mise shell ruby@2.4 && gem install bundler -v "2.3.26"
)


##
## go
##
mise -y install golang@1.16


##
## perl
##
mise -y install perl@5.16.3


##
## java
##
mise -y install java@corretto-8
mise -y install java@temurin-11


##
## maven
##
mise -y install maven@3.8.8


##
## sbt
##
mise -y install sbt@1.6


##
## serverless
##
mise -y install serverless@2
