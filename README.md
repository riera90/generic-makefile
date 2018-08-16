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

- Clone the repository in your project directory

		git clone https://github.com/riera90/generic-makefile.git
- Remove the .git of this repository
- Remove the .gitignore, all the example folders if you want

		rm -rf .git .gitignore example gtests
- Configure the variables in the Makefile file
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
