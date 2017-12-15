Generic makefile intended for C and C++ under GNU.


Just edit the variables and run it!

variables are:

	Directories:
		*BASE_DIR: Where the main and functions reside
		*OUTPUT_DIR: Where the binary will be created
		*LIB_DIR: Where the library will be created
		*OBJ_DIR: Where all the objects will be created

	Filenames: (without the extension)
		*OUTPUT_NAME: the binary name
		*MAIN_NAME: the main name
		*FN_FILES_NAMES: the non main code names
		*LIB_NAME: the library name that will be created

	Compiler:
		*COMPILER: gcc/g++

	Extensions:
		*EXTENSIONS: the code extension (not the headers)

	Options:
		*EXECUTE_AFTER_COMPILATION:
				if enable the binary will be executed after compilation
		*EXECUTION_DATA:
				if enabled data of the execution will be shown.
				It can be vervose or very vervose.
				If very vervose is selected a file will be created (not working)
