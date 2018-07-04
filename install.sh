#!/bin/bash
make clean
rm example example_output -rf
rm .git -rf
git clone git@github.com:google/googletest.git
mv ./googletest ./../googletest -f
rm ./../googletest/.git -rf
mv ./Makefile ./../Makefile -f
mv ./make-files ./../make-files -f
rm ./install.sh -f
# create uninstall
