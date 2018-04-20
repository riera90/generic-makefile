#!/bin/bash
make clean
rm example output -rf
rm .git -rf
git clone Googletest
mv ./googletest ./../googletest -f
mv ./Makefile ./../Makefile -f
mv ./make-files ./../make-files -f
rm ./install.sh -f
# create uninstall
