# DIRECTORIES
# src directory
SRC_DIR         :=./src
GTEST_DIR       :=./gtests
OUTPUT_DIR      :=./output
# aditional project libs directory
EXTRA_LIB_DIR   :=
# temporal files directory
TMP_DIR         :=./tmp
SRC_CODE_EXT    :=cpp
SRC_HEADERS_EXT :=hpp
MAIN_FILE       :=main.cpp
# excluded files from the project
EXCLUDED_FILES  :=


# binary file name
BIN_NAME:=bin.out
# binary arguments (if executed by the makefile).
BIN_ARGUMENTS:= hi!
# compiler
CXX:=g++
# compilation flags
CXXFLAGS:=-Wpedantic

# [YES/NO]
EXECUTE_AFTER_COMPILATION:=YES
ALLOW_FOR_GNU_DEBUGGER:=NO
# automatic linking from all files under the app directory
AUTOMATIC_LINKING:=YES


include ./make-files/Makefile

.PHONY: config
config:
	@echo "\tConfiguring makefile"
	@./make-files/config.sh

.PHONY: reset
reset:
	@echo "\tReseting makefile configuration"
	@./make-files/config.sh reset



#    __
# __( o)>
# \ <_ ) r90