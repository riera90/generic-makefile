
# DIRECTORIES
BASE_DIR=./main
OUTPUT_DIR=./output
LIB_DIR=./temp
OBJ_DIR=./temp
#------------------------------
# FILENAMES (without extension)
OUTPUT_NAME=executable
MAIN_NAME=main
FN_FILES_NAMES=foo var
LIB_NAME=lib_name
HEADERS_LOCATION=
# where the headers are located inside of the BASE_DIR folder [opcional if all the files are in BASE_DIR]
#------------------------------
# COMPILERS
COMPILER=g++
#------------------------------
# EXTENSIONS
CODE_EXTENSION=cc
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
# the previous configuration compiles the following tree
# ./
#  ├main/
#  │ ├main.cc
#  │ ├foo.cc
#  │ └var.cc
#  ├output/
#  │ └executable.out
#  └temp/
#    ├lib_name.a
#    ├foo.o
#    └var.o
# Unitest:
#
#
#
#############################################################
#GTEST_DIR
#############################################################
GTEST=NO
#[YES/NO]
# Please tweak the following variable definitions as needed by your
# project, except GTEST_HEADERS, which you can use in your own targets
# but shouldn't modify.

# Points to the root of Google Test, relative to where this file is.
# Remember to tweak this if you move this file.
GTEST_DIR = /googletest*

# Where to find user code.
# USER_DIR = ../samples

# Flags passed to the preprocessor.
# Set Google Test's header directory as a system directory, such that
# the compiler doesn't generate warnings in Google Test headers.
CPPFLAGS += -isystem $(GTEST_DIR)/include

# Flags passed to the C++ compiler.
CXXFLAGS += -g -Wall -Wextra -pthread

# All tests produced by this Makefile.  Remember to add new tests you
# created to the list.
TESTS = foo_unittest var_unittest

# All Google Test headers.  Usually you shouldn't change this
# definition.
GTEST_HEADERS = $(GTEST_DIR)/include/gtest/*.h \
                $(GTEST_DIR)/include/gtest/internal/*.h

# House-keeping build targets.


#############################################################
# Makefile

TEMP:=$(BASE_DIR)
BASE_DIR:=$(addsuffix /,$(TEMP))

TEMP:=$(OUTPUT_DIR)
OUTPUT_DIR:=$(addsuffix /,$(TEMP))

TEMP:=$(LIB_DIR)
LIB_DIR:=$(addsuffix /,$(TEMP))

TEMP:=$(OBJ_DIR)
OBJ_DIR:=$(addsuffix /,$(TEMP))

# MAKEFILE VARIABLES ASSIGNATION
TEMP := $(addsuffix .$(CODE_EXTENSION),$(FN_FILES_NAMES))
CODE_FILES_W_ROUTE := $(addprefix $(BASE_DIR),$(TEMP))

TEMP := $(addsuffix .o,$(FN_FILES_NAMES))
temp:=$(shell echo "$(temp)" | grep -Eo [a-z\.\_\-]*$)
TEMP:= $(addprefix $(OBJ_DIR),$(TEMP))
OBJ_FILES_W_ROUTE:=

FLAGS :=$(addprefix -,$(COMPILATION_FLAGS))
FLAGS += $(addprefix -I $(BASE_DIR),$(HEADERS_LOCATION))



# BINARY EXECUTION
ifeq ($(EXECUTE_AFTER_COMPILATION), YES)
execute : $(OUTPUT_DIR)$(OUTPUT_NAME)
ifeq ($(EXECUTION_DATA), SIMPLE)
	time "$(OUTPUT_DIR)$(OUTPUT_NAME).out"
endif
ifeq ($(EXECUTION_DATA), COMPLETE)
	@echo WIP, try EXECUTION_DATA as simple
endif
ifeq ($(EXECUTION_DATA_RECOVERY), NO)
	$(OUTPUT_DIR)$(OUTPUT_NAME).out
endif
endif

# BINARY COMPILATION (gcc -o a.out main.cc lib.a -flags)
$(OUTPUT_DIR)$(OUTPUT_NAME) : $(BASE_DIR)$(MAIN_NAME).$(CODE_EXTENSION) $(LIB_DIR)$(LIB_NAME).a
	$(COMPILER) -o $(OUTPUT_DIR)$(OUTPUT_NAME).out $(BASE_DIR)$(MAIN_NAME).$(CODE_EXTENSION) $(LIB_DIR)$(LIB_NAME).a $(FLAGS)

# .o COMPILATION (gcc -c var.cc foo.cc)
$(OBJ_FILES_W_ROUTE) : $(CODE_FILES_W_ROUTE)

	cd $(OBJ_DIR)
	$(COMPILER) -c $^
	mv ./*.o $(OBJ_DIR)


#.a COMPILATION (ar -rs .lib.a var.o foo.o)
$(LIB_DIR)$(LIB_NAME).a : $(OBJ_FILES_W_ROUTE)
	ar -rs $@ $^

# CLEAN
clean:
	rm -f $(OUTPUT_DIR)*.out $(OBJ_DIR)*.o $(LIB_DIR)*.a
googletest : $(TESTS)

ifeq ($GTEST,YES)

clean_googletest :
	rm -f $(TESTS) gtest.a gtest_main.a *.o

# Builds gtest.a and gtest_main.a.

# Usually you shouldn't tweak such internal variables, indicated by a
# trailing _.
GTEST_SRCS_ = $(GTEST_DIR)/src/*.cc $(GTEST_DIR)/src/*.h $(GTEST_HEADERS)

# For simplicity and to avoid depending on Google Test's
# implementation details, the dependencies specified below are
# conservative and not optimized.  This is fine as Google Test
# compiles fast and for ordinary users its source rarely changes.
gtest-all.o : $(GTEST_SRCS_)
	$(CXX) $(CPPFLAGS) -I$(GTEST_DIR) $(CXXFLAGS) -c \
            $(GTEST_DIR)/src/gtest-all.cc

gtest_main.o : $(GTEST_SRCS_)
	$(CXX) $(CPPFLAGS) -I$(GTEST_DIR) $(CXXFLAGS) -c \
            $(GTEST_DIR)/src/gtest_main.cc

gtest.a : gtest-all.o
	$(AR) $(ARFLAGS) $@ $^

gtest_main.a : gtest-all.o gtest_main.o
	$(AR) $(ARFLAGS) $@ $^

# Builds a sample test.  A test should link with either gtest.a or
# gtest_main.a, depending on whether it defines its own main()
# function.

foo.o : foo.cc foo.h $(GTEST_HEADERS)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c foo.cc

foo_unittest.o : foo_unittest.cc \
                     foo.h $(GTEST_HEADERS)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c foo_unittest.cc -o foo_unittest.o

var.o : var.cc var.h $(GTEST_HEADERS)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c var.cc

var_unittest.o : var_unittest.cc \
                     var.h $(GTEST_HEADERS)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c var_unittest.cc -o var_unittest.o

foo_unittest : foo.o foo_unittest.o gtest_main.a
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -lpthread $^ -o $@

var_unittest : var.o var_unittest.o foo.o gtest_main.a
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -lpthread $^ -o $@
endif

help:
	#                            _                        _         __ _ _
	#                           (_)                      | |       / _(_) |
	#  __ _  ___ _ __   ___ _ __ _  ___   _ __ ___   __ _| | _____| |_ _| | ___
	# / _` |/ _ \ '_ \ / _ \ '__| |/ __| | '_ ` _ \ / _` | |/ / _ \  _| | |/ _ \.
	#| (_| |  __/ | | |  __/ |  | | (__  | | | | | | (_| |   <  __/ | | | |  __/
	# \__, |\___|_| |_|\___|_|  |_|\___| |_| |_| |_|\__,_|_|\_\___|_| |_|_|\___|
	#  __/ |
	# |___/                                             by Danitico and Riera90.
	#
	## Implementation
	# 	git clone git@github.com:riera90/generic-makefile.git
	# 	cd greneric-makefile
	# 	mv * <working directory>
	# 	cd <working directory>
	#
	# Configure the variables.
	# 	make
	#
	# And enjoy the binaries!
	#
	# For a more extense manual prease, refer to README.md
	#
