# Makefile algoritms: you should not touch here... rly... don't... please... ok, go ahead, but I have warned you.




#############################################################
################### GLOBAL_CONFUGIRATION ####################
#############################################################

# MAKEFILE VARIABLES ASSIGNATION

# full path to the main file
MAIN:= $(shell find $(SRC_DIR) -name '$(MAIN_FILE)' -type f)

# full path to all headers files
HEADERS:= $(shell find $(SRC_DIR) -name '*.$(SRC_HEADERS_EXT)' -type f)

# full path to all code files
CODE:= $(shell find $(SRC_DIR) -name '*.$(SRC_CODE_EXT)' -type f)
# filter out the main file from the code
CODE:= $(filter-out $(MAIN), $(CODE))

# full path to where the objects are or will be created
# modificated from the code variable
OBJECTS:= $(subst .$(SRC_CODE_EXT),.o,$(CODE))
OBJECTS:= $(subst $(SRC_DIR),$(TMP_DIR),$(OBJECTS))

# full path to google tests unittests for the code
GTESTS:= $(shell find $(GTEST_DIR) -type f)

# full path to googletest reposotory
GTEST_REPOSITORY:= ./make-files/googletest/googletest

# temporal directories array
TMP_FOLDERS:=  $(shell find $(SRC_DIR) -type d)
# filters out the src directory
TMP_FOLDERS:=  $(filter-out $(SRC_DIR),$(TMP_FOLDERS))
# changes the src dir to tmp dir
TMP_FOLDERS:=  $(subst $(SRC_DIR),$(TMP_DIR),$(TMP_FOLDERS))

# full path to the project library
PROJECT_LIBRARY:= $(TMP_DIR)/libproject.a

# full path to the googletest library
GTEST_LIBRARY:= $(TMP_DIR)/libgtest.a

# array of paths to all libraries
ifneq ($(EXTRA_LIB_DIR),) # checks if it's defined
LIBRARIES:= $(shell find $(EXTRA_LIB_DIR) -type f)
endif
LIBRARIES+= $(PROJECT_LIBRARY)

# path to the binary file
BINARY:= $(OUTPUT_DIR)/$(BIN_NAME)

# array of paths to googletest binaries
GTESTS_BINARIES:= $(subst $(GTEST_DIR),$(OUTPUT_DIR),$(GTESTS))
GTESTS_BINARIES:= $(subst $(SRC_CODE_EXT),out,$(GTESTS_BINARIES))

# dinamic linking flags
FLAGS_DIN:= $(shell find $(SRC_DIR) -type d)
FLAGS_DIN:= $(addprefix -I ,$(FLAGS_DIN))

# chechs for gdb option
ifeq ($(ALLOW_FOR_GNU_DEBUGGER),YES)
CXXFLAGS+= -g
endif

#############################################################
# BINARY EXECUTION
ifeq ($(EXECUTE_AFTER_COMPILATION), YES)
.PHONY: execute
execute : $(BINARY)
	@echo "\tExecuting binary.\n"
	@# executes the binary with time
	@time "$(BINARY)"
endif


ifeq ($(CODE),) # chechs if there is only a main

#############################################################
# BINARY COMPILATION (with only main)
$(BINARY) : $(MAIN)
	@echo "\tCompiling binary."
	@$(CXX) $(MAIN) -o $(BINARY) $(CXXFLAGS) $(FLAGS_DIN)

else

#############################################################
# BINARY COMPILATION
$(BINARY) : $(LIBRARIES)
	@echo "\tCompiling binary."
	@$(CXX) $(MAIN) -o $(BINARY) $(LIBRARIES) $(CXXFLAGS) $(FLAGS_DIN)

#############################################################
# LIBRARY COMPILATION
$(PROJECT_LIBRARY) : $(OBJECTS)
	@echo "\tBuilding library."
	@ar -rsc $@ $^

#############################################################
# OBJECTS COMPILATION
$(OBJECTS) : $(CODE) $(HEADERS) folder_creation
	@echo "\tPrecompiling objects."
	@# the regex is to change from code path to object path and compiles the object
	@for code_file in $(CODE); do \
		obj_file="$(TMP_DIR)/$$(echo $$code_file | sed -E -n 's/^\.\/[a-zA-Z\ \.\-\_]*\/(.*).$(SRC_CODE_EXT)/\1.o/p')"; \
		$(CXX) -c $$code_file $(FLAGS_DIN) -o $$obj_file; \
	done


endif

#############################################################
# FOLDER_CREATION
.PHONY: folder_creation
folder_creation :
	@# prints the small banner
	@cat ./make-files/fancy_banner_short.txt
	@echo "\tCreating temporal directories."
	@# makes the directory tree
	@mkdir -p $(TMP_FOLDERS)
	@mkdir -p $(OUTPUT_DIR)


#############################################################
##################### GOOGLETEST ############################
#############################################################

#############################################################
# GOOGLETEST TESTS EXECUTION
.PHONY: googletest
googletest : $(GTESTS_BINARIES) $(GTEST_LIBRARY) $(PROJECT_LIBRARY)
	@echo "\tRunning googletests."
	@#
	@for test_code in $(GTESTS) ; do \
		binary_file="$(OUTPUT_DIR)/$$(echo $$test_code | sed -E -n 's/^\.\/[a-zA-Z\ \.\-\_]*\/(.*).$(SRC_CODE_EXT)/\1.out/p')"; \
		binary_file_name="$$(echo $$test_code | sed -E -n 's/.*\/([a-zA-Z\ \.\-\_0-9]*)/\1/p')"; \
		echo "\n\tRunning $$binary_file_name" ; \
		$$binary_file ; \
	done

#############################################################
# GOOGLETEST TESTS COMPILATION
$(GTESTS_BINARIES) : $(GTEST_LIBRARY) $(PROJECT_LIBRARY) $(GTESTS)
	@echo "\tCompiling googletests."
	@for test_code in $(GTESTS) ; do \
		binary_file="$(OUTPUT_DIR)/$$(echo $$test_code | sed -E -n 's/^\.\/[a-zA-Z\ \.\-\_]*\/(.*).$(SRC_CODE_EXT)/\1.out/p')"; \
		binary_file_name="$$(echo $$test_code | sed -E -n 's/.*\/([a-zA-Z\ \.\-\_0-9]*)/\1/p')"; \
		echo "\tBuilding $$binary_file_name" ; \
		g++ -isystem $(GTEST_REPOSITORY)/include -pthread $(FLAGS_DIN) $(CXXFLAGS) $$test_code $(PROJECT_LIBRARY) $(GTEST_LIBRARY) -o $$binary_file ; \
done

#############################################################
# GOOGLETEST LIBRARY COMPILATION
$(GTEST_LIBRARY) : gtest_object_creation
	@echo "\tCompiling googletest library."
	@ar -rc $(GTEST_LIBRARY) $(TMP_DIR)/gtest-all.o $(TMP_DIR)/gtest_main.o

#############################################################
# GOOGLETEST OBJECTS PRECOMPILATION
.PHONY: gtest_object_creation
gtest_object_creation : folder_creation
	@echo "\tPrecompiling googletest objects."
	@g++ -isystem $(GTEST_REPOSITORY)/include -I $(GTEST_REPOSITORY) -pthread -c $(GTEST_REPOSITORY)/src/gtest-all.cc -o $(TMP_DIR)/gtest-all.o
	@g++ -isystem $(GTEST_REPOSITORY)/include -I $(GTEST_REPOSITORY) -pthread -c $(GTEST_REPOSITORY)/src/gtest_main.cc -o $(TMP_DIR)/gtest_main.o


#############################################################
####################### GNU_DEBUGGER ########################
#############################################################
ifeq ($(ALLOW_FOR_GNU_DEBUGGER),YES)
.PHONY: gdb
gdb : clean $(BINARY)
	@echo "\tLaunching gdb.\n"
	@# executes the binary with time
	@gdb $(BINARY)
endif

#############################################################
######## DEBUG_SECTION (intended for developers) ############
#############################################################

.PHONY: test_variables
test_variables:
	@echo "\t.          -> $(shell pwd)"
	@echo "\tmain       -> $(MAIN)"
	@echo "\theaders    -> $(HEADERS)"
	@echo "\tcode       -> $(CODE)"
	@echo "\ttmp folders-> $(TMP_FOLDERS)"
	@echo "\tobjects    -> $(OBJECTS)"
	@echo "\tlibraries  -> $(LIBRARIES)"
	@echo "\tflags_din  -> $(FLAGS_DIN)"
	@echo "\tgtests     -> $(GTESTS)"
	@echo "\tgtest bin  -> $(GTESTS_BINARIES)"
	@echo "\tmain bin   -> $(BINARY)"

#############################################################
###################### HELP_SECTION #########################
#############################################################
# prints the banner and help files

.PHONY: help
help:
	@cat ./make-files/banner.txt
	@cat ./make-files/help.txt

.PHONY: clean
clean:
	@echo "\tRemoving temporal files"
	@rm -rf $(TMP_DIR)
	@echo "\tRemoving binary files"
	@rm $(OUTPUT_DIR)/*.out
