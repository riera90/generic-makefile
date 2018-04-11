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
# Makefile

# MAKEFILE VARIABLES ASSIGNATION

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
