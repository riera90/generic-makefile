include ./make-files/Makefile.algo
# DIRECTORIES
BASE_DIR=./example
OUTPUT_DIR=./example_output
LIB_DIR=./temp
OBJ_DIR=./temp
#------------------------------
# FILENAMES (without extension)
OUTPUT_NAME=executable
MAIN_NAME=main
FN_FILES_NAMES=clases/Greeter
LIB_NAME=greeter_lib
HEADERS_LOCATION=clases
# where the headers are located inside of the BASE_DIR folder (for dinamic linking)
#------------------------------
# COMPILERS
COMPILER=g++
#------------------------------
# EXTENSIONS
CODE_EXTENSION=cpp
#------------------------------
# OPTIONS
EXECUTE_AFTER_COMPILATION=YES
	# [YES/NO]
EXECUTION_DATA=SIMPLE
	# [SIMPLE/COMPLETE(generate a more verbose file)]
		# todo complete does not works
COMPILATION_FLAGS=Wpedantic
#the binary compilation flags without the "-"

#############################################################
# GTEST configuration
#############################################################

GTEST=YES
#[YES/NO](not working)
GTEST_DIR=googletest/googletest
	# Generated in the install script
	# Points to the root of Google Test, relative to where Makefile is.
	# Remember to tweak this if you move this file.
TESTS_DIR=
TESTS=

#############################################################
# the previous configuration compiles the following tree
# ./
#  ├example/
#  │ ├main.cc
#  | └clases
#  │   ├Greeter.hpp
#  │   └Greeter.cpp
#  ├example_output/
#  │ └executable.out
#  └temp/
#    ├lib_name.a
#    ├foo.o
#    └var.o
#
