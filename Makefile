# DIRECTORIES
BASE_DIR=./main/
OUTPUT_DIR=./output/
LIB_DIR=./temp/
OBJ_DIR=./temp/
#------------------------------
# FILENAMES (without extension)
OUTPUT_NAME=executable
MAIN_NAME=main
FN_FILES_NAMES=foo var
LIB_NAME=lib_name
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
	# [SIMPLE/COMPLETE(generate a more vervose file)]
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
#############################################################
# Makefile

# MAKEFILE VARIABLES ASSIGNATION
TEMP := $(addsuffix .$(CODE_EXTENSION),$(FN_FILES_NAMES))
CODE_FILES_W_ROUTE := $(addprefix $(BASE_DIR),$(TEMP))

TEMP := $(addsuffix .o,$(FN_FILES_NAMES))
OBJ_FILES_W_ROUTE := $(addprefix $(OBJ_DIR),$(TEMP))

FLAGS :=$(addprefix -,$(COMPILATION_FLAGS))



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
	$(COMPILER) -c $^
	mv ./*.o $(OBJ_DIR)


#.a COMPILATION (ar -rs .lib.a var.o foo.o)
$(LIB_DIR)$(LIB_NAME).a: $(OBJ_FILES_W_ROUTE)
	ar -rs $@ $^

# CLEAN
clean:
	rm -f $(OUTPUT_DIR)*.out $(OBJ_DIR)*.o $(LIB_DIR)*.a


help:
	#                            _                        _         __ _ _
	#                           (_)                      | |       / _(_) |
	#  __ _  ___ _ __   ___ _ __ _  ___   _ __ ___   __ _| | _____| |_ _| | ___
	# / _` |/ _ \ '_ \ / _ \ '__| |/ __| | '_ ` _ \ / _` | |/ / _ \  _| | |/ _ \.
	#| (_| |  __/ | | |  __/ |  | | (__  | | | | | | (_| |   <  __/ | | | |  __/
	# \__, |\___|_| |_|\___|_|  |_|\___| |_| |_| |_|\__,_|_|\_\___|_| |_|_|\___|
	#  __/ |
	# |___/                                                           by riera90.
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
