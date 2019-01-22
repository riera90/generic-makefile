# generic-makefile v3

![](https://github.com/riera90/generic-makefile/blob/master/make-files/logo.png)


For a better experience, please use the  [generic-CLI](https://github.com/riera90/generic-CLI), a easy to use generic-technology manager.


# Description

The Makefile that can be configured in under 30 seconds and adapts to almost all your C and C++ projects!  
Intended for C and C++ under GNU/Linux.


**This Makefile supports:**

- Fully autonomous configuration except basic directories.
- automatic dynamic linking.
- Automatic directories generation.
- Transparent googletest integration.
- gdb

# Why?

So you don't have to make yours or configure another one for more than 30 seconds.

# Implementation

## Method 1: the developer's recommendation.

### use the [generic-CLI](https://github.com/riera90/generic-CLI).

- Clone the repository

		git clone https://github.com/riera90/generic-CLI.git

- install the generic-CLI with the installation script

		cd generic-CLI
		./install.sh

- install the generic-makefile in your project directory!

		cd <project directory>
		generic-cli -c makefile

one line instalation command (for the first time only) then use the generic-cli utility

	git clone https://github.com/riera90/generic-CLI.git && cd generic-CLI && sudo chmod +x ./install.sh && ./install.sh && generic-cli -c gmf

## Method 2: the 'hard' way

- Clone the repository in your project directory

		git clone https://github.com/riera90/generic-makefile.git

- Remove the .git of this repository
- Remove the .gitignore, all the example folders if you want

		rm -rf .git .gitignore example gtests

- Move the license and readme to the make-files folder (the license is required to remain in the project)

		mv ./*.md ./make-files/

- Move all the all the remaining content of the generic-makefile directory to your project directory

		mv ./* ./../

- Configure the variables in the Makefile file
- optional step: if you want googletest, clone it into the make-files directory and remove the .git

		cd make-files
		git clone https://github.com/google/googletest.git
		cd googletest
		rm -rf .git

- apply the new configuration to the make-files/Makefile

		make config

- hit make and enjoy!

		make





# Usage

## Commands

- **make config** applies the new configuration to make-files/Makefile
- **make** It builds the project and executes the binary (by default).
- **make run** executes the binary.
- **make googletest** It builds and executes (by default) the tests for the project.
- **make clean** cleanup of the project temporal files.
- **make gdb** fresh gdb compilation and execution (by default).

## variables

| variable        | definition    | restrictions  |
| --------------- |---------------| --------------|
| SRC_DIR         | Source directory | Is a directory |
| GTEST_DIR       | googletest directory as in | Is a directory |
| OUTPUT_DIR      | Directory where the binary will reside | Is a directory |
| EXTRA_LIB_DIR   | Directory for extra external libraries | Is a directory |
| TMP_DIR         | Temporal directory for objects and libraries | Is a directory |
| SRC_CODE_EXT    | Extension for the source code | Is an extension |
| SRC_HEADERS_EXT | Extension for the source headers | Is an extension |
| MAIN_FILE       | The file where the main resides, there is no need for the full path, just the filename and the extension is enough | Is an existing filename |
| EXCLUDED_FILES  | excluded files from the project as a regular expression, various expressions are allowed, and must be separated by spaces | |
| BIN_NAME        | The name the binary will receive | |
| BIN_ARGUMENTS   | The arguments the binary will be executed with (if executed with the Makefile) | |
| CXX             | The compiler | [gcc/g++] |
| CXXFLAGS        | The compilation flags | '-' or  '--' is needed |
| EXECUTE_AFTER_COMPILATION | Option for executing of the binary file after the compilation | [YES/NO] |
| ALLOW_FOR_GDB | Activates the GNU debugger | [YES/NO] |

# Licence

Licensed under the [BSD-3 licence](https://github.com/riera90/generic-makefile/blob/master/LICENSE.md)


# Want to colaborate?

Read [CONTRIBUTING.md](https://github.com/riera90/generic-makefile/blob/master/CONTRIBUTING.md)!

# FAQ!

### Q: I have just cloned a repository with the generic-makefile, but the googletest is not working, what do I do?
R: just use the [generic-CLI](https://github.com/riera90/generic-CLI) utility, in the project directory, type the command

	generic-cli -c make

When ask if you want googletest, say yes.
