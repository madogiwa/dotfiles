#!/bin/sh

##
## install SDKMAN
##

curl -s "https://get.sdkman.io?rcupdate=false" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

##
## java
##

sdk install java 8.0.332-tem
sdk install java 17.0.3-tem

##
## maven
##

sdk install maven 3.8.6

##
## sbt
##

sdk install sbt 1.4.9
sdk install sbt 1.6.2

