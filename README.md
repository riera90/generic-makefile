For a better experience, please use the  [generic-CLI](https://github.com/riera90/generic-CLI), a easy to use generic-technology manager.

![](https://github.com/riera90/generic-makefile/blob/master/make-files/logo.png)

# Description

The Makefile that can be configured in under 30 seconds and adapts to almost all your C and C++ projects!  
Intended for C and C++ under GNU/Linux.


**This Makefile supports:**

- Fully autonomous configuration except basic directories.
- automatic dynamic linking.
- Automatic directories generation.
- Transparent googletest integration (todo).
- gdb

# Why?

So you don't have to make yours or configure another one for more than 30 seconds.

# Implementation

## Method 1: the developer's recommendation.

### use the [generic-CLI](https://github.com/riera90/generic-CLI).

## Method 2: the 'hard' way

- Clone the repository in your project directory

		git clone https://github.com/riera90/generic-makefile.git
		
- Remove the .git of this repository
- Remove the .gitignore, all the example folders if you want

		rm -rf .git .gitignore example gtests

- Move the licence and readme to the make-files folder (the license is required to remain in the project)

		mv ./*.md ./make-files/

- Move all the all the remaining content of the generic-makefile directory to your project directory

		mv ./* ./../

- Configure the variables in the Makefile file
- optional step: if you want googletest, clone it into the make-files directory and remove the .git

		cd make-files
		git clone https://github.com/google/googletest.git
		cd googletest
		rm -rf .git

- hit make and enjoy!

		make




# Usage

## comands

- **make** builds the project.
- **make googletest** builds and execute the tests for the project.
- **make clean** cleanup of the project temporal files.
- **make gdb** fresh gdb compilation.

## variables

TODO

# Licence

Licensed under the [BSD-3 licence](https://github.com/riera90/generic-makefile/blob/master/LICENSE.md)


# Whant to colaborate?

Read [CONTRIBUTING.md](https://github.com/riera90/generic-makefile/blob/master/CONTRIBUTING.md)!
