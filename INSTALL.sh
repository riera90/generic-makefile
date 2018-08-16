#!/bin/sh
make clean
rm example example_output -rf
rm .git -rf
git clone git@github.com:google/googletest.git
rm ./../googletest/.git -rf
sudo mkdir /etc/generic-makefile
sudo mv ./googletest /etc/generic-makefile/googletest -f
sudo cp ./Makefile /etc/generic-makefile/Makefile.bak -f
sudo mv ./Makefile /etc/generic-makefile/Makefile -f
sudo mv ./make-files /etc/generic-makefile/make-files -f
rm ./install.sh -f
