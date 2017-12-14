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
	# [SIMPLE/COMPLETE]
		# todo complete does not works
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

# MAKEFILE VARIABLES
FN_OBJ = $(addsuffix .o,$(FN_FILES_NAMES))
FN_CODE = $(addsuffix .$(CODE_EXTENSION),$(FN_FILES_NAMES))

# BINARY EXECUTION
ifeq ($(EXECUTE_AFTER_COMPILATION), YES)
execute : $(OUTPUT_DIR)$(OUTPUT_NAME)
ifeq ($(EXECUTION_DATA), SIMPLE)
	time "$(OUTPUT_DIR)$(OUTPUT_NAME).out"
endif
ifeq ($(EXECUTION_DATA), COMPLETE)
	@echo execute WIP, try EXECUTION_DATA as simple
	# time "$(OUTPUT_DIR)$(OUTPUT_NAME).$(OUTPUT_EXTENSION)"
endif
ifeq ($(EXECUTION_DATA_RECOVERY), NO)
	$(OUTPUT_DIR)$(OUTPUT_NAME).out
endif
endif

# BINARY COMPILATION (gcc -o a.out main.cc lib.a)
$(OUTPUT_DIR)$(OUTPUT_NAME) : $(BASE_DIR)$(MAIN_NAME).$(CODE_EXTENSION) $(LIB_DIR)$(LIB_NAME).a
	$(COMPILER) -o $(OUTPUT_DIR)$(OUTPUT_NAME).out $(BASE_DIR)$(MAIN_NAME).$(CODE_EXTENSION) $(LIB_DIR)$(LIB_NAME).a

# .o COMPILATION
$(FN_OBJ) : $(FN_CODE)

#.a COMPILATION
$(LIB_DIR)$(LIB_NAME).a: $(addsuffix .o,$(FN_FILES_NAMES))
	ar -rs $(LIB_DIR)$(LIB_NAME).a $^

# CLEAN
clean:
	rm -f *.out *.o *.a
