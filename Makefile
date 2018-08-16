# DIRECTORIES
# src directory
SRC_DIR:=./example
GTEST_DIR=./gtests
OUTPUT_DIR:=./output
# aditional project libs directory
EXTRA_LIB_DIR:=./extra_libs
# temporal files directory
TMP_DIR:=./tmp

SRC_CODE_EXT		:=cpp
SRC_HEADERS_EXT	:=hpp
MAIN_FILE				:=main.cpp
EXCLUDED_FILES	:=


# binary file name
BIN_NAME:=bin.out

# compiler
CXX:=g++
# compilation flags
CXXFLAGS:=-Wpedantic

# [YES/NO]
EXECUTE_AFTER_COMPILATION=YES
ALLOW_FOR_GNU_DEBUGGER=NO

include ./make-files/Makefile
