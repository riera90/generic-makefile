# DIRECTORIES
BASE_DIR=./main
OUTPUT_DIR=./output
LIB_DIR=./temp
OBJ_DIR=./temp
#------------------------------
# FILENAMES (without extension)
OUTPUT_NAME=executable
MAIN_NAME=main
# MAIN_NAME=testProcincia
FN_FILES_NAMES=clases/foo clases/var
LIB_NAME=lib_name
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
#[YES/NO]
GTEST_DIR=googletest/googletest
	# Points to the root of Google Test, relative to where this file is.
	# Remember to tweak this if you move this file.
TESTS=foo_unittest
TESTS_DIR=./tests


#############################################################
# the previous configuration compiles the following tree
# ./
#  ├main/
#  │ ├main.cc
#  │ ├foo.cc
#  │ └var.cc
#  ├output/
#  │ └executable.out
#  ├temp/
#  │ ├lib_name.a
#  │ ├foo.o
#  │ └var.o
#  ├googletest/
#  │ └googletest/
#  └tests:
#	   └foo_unittest.cc
#
#############################################################
# Makefile: you should not touch nothing more...
#############################################################

#############################################################
# GLOBAL_CONFUGIRATION
#############################################################

# MAKEFILE VARIABLES ASSIGNATION

TEMP:=$(TESTS_DIR)
TESTS_DIR:=$(addsuffix /,$(TEMP))

TEMP:=$(BASE_DIR)
BASE_DIR:=$(addsuffix /,$(TEMP))

TEMP:=$(OUTPUT_DIR)
OUTPUT_DIR:=$(addsuffix /,$(TEMP))

TEMP:=$(LIB_DIR)
LIB_DIR:=$(addsuffix /,$(TEMP))

TEMP:=$(OBJ_DIR)
OBJ_DIR:=$(addsuffix /,$(TEMP))

TEMP := $(LIB_DIR)
LIB_FILES_W_ROUTE := $(addprefix $(LIB_DIR),$(TEMP))
TEMP := $(addsuffix .o,$(FN_FILES_NAMES))
LIB_FILES_W_ROUTE:= $(addprefix $(LIB_DIR),$(LIB_NAME))
LIB_FILES_W_ROUTE_EXT:= $(addprefix $(LIB_DIR),$(TEMP))

TEMP := $(addsuffix .$(CODE_EXTENSION),$(FN_FILES_NAMES))
CODE_FILES_W_ROUTE := $(addprefix $(BASE_DIR),$(TEMP))

TEMP := $(addsuffix .o,$(FN_FILES_NAMES))
OBJ_FILES_W_ROUTE:= $(addprefix $(OBJ_DIR),$(FN_FILES_NAMES))
OBJ_FILES_W_ROUTE_EXT:= $(addprefix $(OBJ_DIR),$(TEMP))

FLAGS :=$(addprefix -,$(COMPILATION_FLAGS))
FLAGS_DIN := $(addprefix -I $(BASE_DIR),$(HEADERS_LOCATION))


# BINARY EXECUTION
ifeq ($(EXECUTE_AFTER_COMPILATION), YES)
execute : $(OUTPUT_DIR)$(OUTPUT_NAME)
ifeq ($(EXECUTION_DATA), SIMPLE)
	@echo Executing
	@echo
	@time "$(OUTPUT_DIR)$(OUTPUT_NAME).out"
endif
ifeq ($(EXECUTION_DATA), COMPLETE)
	@echo Executing
	@echo
	@echo WIP, try EXECUTION_DATA as simple
endif
ifeq ($(EXECUTION_DATA_RECOVERY), NO)
	@echo Executing
	@echo
	@$(OUTPUT_DIR)$(OUTPUT_NAME).out
endif
endif

# BINARY COMPILATION (gcc -o a.out main.cc lib.a -flags)
$(OUTPUT_DIR)$(OUTPUT_NAME) : $(BASE_DIR)$(MAIN_NAME).$(CODE_EXTENSION) $(LIB_DIR)$(LIB_NAME).a
	@echo Building binaries
	@$(COMPILER) -o $(OUTPUT_DIR)$(OUTPUT_NAME).out $(BASE_DIR)$(MAIN_NAME).$(CODE_EXTENSION) $(LIB_DIR)$(LIB_NAME).a $(FLAGS) $(FLAGS_DIN)


# .o COMPILATION (gcc -c var.cc foo.cc)
#generates the .o's and moves them into their corresponding foldet in the OBJ_DIR
$(OBJ_FILES_W_ROUTE_EXT) : $(CODE_FILES_W_ROUTE)
	@./make-files/create_temp_folder.sh $(OBJ_FILES_W_ROUTE) $(LIB_FILES_W_ROUTE)
	@echo Building objects.
	@for file in $(FN_FILES_NAMES) ; do \
			$(COMPILER) -c $(BASE_DIR)$$file.$(CODE_EXTENSION) $(FLAGS_DIN); \
			mv ./*.o $(OBJ_DIR)$$file.o ; \
	done

#.a COMPILATION (ar -rs .lib.a var.o foo.o)
$(LIB_DIR)$(LIB_NAME).a : $(OBJ_FILES_W_ROUTE_EXT)
	@echo Building library.
	@ar -rs $@ $^

# CLEAN
clean:
	@echo cleaning.
	@rm -rf $(OUTPUT_DIR)**/*.out
	rm -rf $(OBJ_DIR) $(LIB_DIR)

create_temp:
	@./make-files/create_temp_folder.sh $(OBJ_FILES_W_ROUTE) $(LIB_FILES_W_ROUTE)


#############################################################
# GTEST WIP
#############################################################

googletest : $(LIB_DIR)libgtest.a $(LIB_DIR)$(LIB_NAME).a $(TESTS_W_ROUTE_EXT) gtest_build
	@for unittest in $(TESTS) ; do \
		echo ; \
		echo \	Running $$unittest; \
		echo ; \
		$(OUTPUT_DIR)$$unittest.out ; \
	done


gtest_build : $(LIB_DIR)libgtest.a $(LIB_DIR)$(LIB_NAME).a $(TESTS_W_ROUTE_EXT)
	@for unittest in $(TESTS) ; do \
		echo Building $$unittest ; \
		g++ -isystem $(GTEST_DIR)/include -pthread $(FLAGS_DIN) $(TESTS_DIR)$$unittest.$(CODE_EXTENSION) $(LIB_DIR)$(LIB_NAME).a $(LIB_DIR)libgtest.a -o $(OUTPUT_DIR)$$unittest.out ; \
done

$(LIB_DIR)libgtest.a:
	@./make-files/create_temp_folder.sh $(OBJ_FILES_W_ROUTE) $(LIB_FILES_W_ROUTE)
	g++ -isystem $(GTEST_DIR)/include -I $(GTEST_DIR) -pthread -c $(GTEST_DIR)/src/gtest-all.cc $(GTEST_DIR)/src/gtest_main.cc
	ar -rv libgtest.a gtest-all.o gtest_main.o
	mv gtest-all.o temp/gtest-all.o
	mv gtest_main.o temp/gtest_main.o
	mv libgtest.a $(LIB_DIR)libgtest.a

#############################################################
# HELP_SECTION
#############################################################

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
