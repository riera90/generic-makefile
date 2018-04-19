<<<<<<< HEAD
![](https://github.com/riera90/generic-makefile/blob/master/make-files/logo.png)
=======
>>>>>>> 74faba30c1a43a9135cead92610a035bc0b86e8a
# Description

Generic makefile intended for C and C++ under GNU.

**This makefile supports:**

- Dynamic linking with headers.
- Googletest.
- Automatic generation of temporal folders.

# Why?

So you don't have to make yours.

# Usage

## comands

- **make** builds the project.
- **make googletest** builds and execute the tests for the project.
- **make clean** cleanup of the proyect temporal files.


## variables

**Directories:**

	BASE_DIR: Where the main and functions reside
	OUTPUT_DIR: Where the binary will be created
	LIB_DIR: Where the library will be created
	OBJ_DIR: Where all the objects will be created

**Filenames:** (without the extension)

	OUTPUT_NAME: the binary name
	MAIN_NAME: the main name
	FN_FILES_NAMES: the non main code names
	LIB_NAME: the library name that will be created
	HEADERS_LOCATION: where to search for the headers for dynamic linking (inside of BASE_DIR)
		What is dynamic linking? some magical thing that lets you get away
		with #include "foo.h" when foo.h is in a different directory (func/foo.h)

**Compiler:**

	COMPILER: gcc/g++

**Extensions:**

	EXTENSIONS: the code extension, normally c, cpp or c++ (not the header's extension)

**Options:**

	EXECUTE_AFTER_COMPILATION:
			if enable the binary will be executed after compilation
	EXECUTION_DATA:
			if enabled data of the execution will be shown.
			It can be verbose or very verbose.
			If very verbose is selected a file will be created (WIP)
	COMPILATION_FLAGS:
			The binary compilation flags without the "-"

**Googletest**

	GTEST: Currently this option does nothing..
	GTEST_DIR: Directory of the googletest repository
	TESTS: Tests of your own (without the extension)
	TESTS_DIR: where the previous tests are located

to execute the tests

	make googletest

# Implementation

In your project directory.

	git clone git@github.com:riera90/generic-makefile.git
	cd generic-makefile
	./install.sh
Configure the variables

	make
And enjoy the binaries!

# Licence

Licensed under the [BSD-3 licence](https://github.com/riera90/generic-makefile/blob/master/LICENSE.md)


# Whant to colaborate?

Read [CONTRIBUTING.md](https://github.com/riera90/generic-makefile/blob/master/CONTRIBUTING.md)!
