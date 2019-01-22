#!/bin/bash




debugMakeVariables(){
	echo "SRC_DIR         ->" $SRC_DIR
	echo "GTEST_DIR       ->" $GTEST_DIR
	echo "OUTPUT_DIR      ->" $OUTPUT_DIR
	echo "EXTRA_LIB_DIR   ->" $EXTRA_LIB_DIR
	echo "SRC_CODE_EXT    ->" $SRC_CODE_EXT
	echo "SRC_HEADERS_EXT ->" $SRC_HEADERS_EXT
	echo "MAIN_FILE       ->" $MAIN_FILE
	echo "EXCLUDED_FILES  ->" $EXCLUDED_FILES
	echo -e "\n"
}




debugVariables(){
	echo "MAIN:"
	echo -e "\t"$MAIN
	
	echo "HEADERS:"
	for header in $HEADERS
	do
		echo -e "\t"$header
	done
	
	echo "CODE:"
	for code in $CODE
	do
		echo -e "\t"$code
	done
	
	echo "GTESTS:"
	for gtest in $GTESTS
	do
		echo -e "\t"$gtest
	done
	
	echo "EXTRA_LIBS:"
	for lib in $EXTRA_LIBS
	do
		echo -e "\t"$lib
	done
	
	echo "FLAGS_DIN:"
	printf "\t"
	for flag in $FLAGS_DIN
	do
		echo $flag | tr "\n" " "
	done
	printf "\n"
	
	echo "TMP_FOLDERS:"
	printf "\t"
	for dir in $TMP_FOLDERS
	do
		echo $dir | tr "\n" " "
	done
	echo -e "\n"
	
	
}



# loads the variables from the configuration Makefile
loadVariables(){
	SRC_DIR=$(cat ./Makefile | sed -rn 's#^SRC_DIR.*:=\ *(.*)$#\1#p')
	
	GTEST_DIR=$(cat ./Makefile | sed -rn 's#^GTEST_DIR.*:=\ *(.*)$#\1#p')
	
	OUTPUT_DIR=$(cat ./Makefile | sed -rn 's#^OUTPUT_DIR.*:=\ *(.*)$#\1#p')
	
	EXTRA_LIB_DIR=$(cat ./Makefile | sed -rn 's#^EXTRA_LIB_DIR.*:=\ *(.*)$#\1#p')
	
	TMP_DIR=$(cat ./Makefile | sed -rn 's#^TMP_DIR.*:=\ *(.*)$#\1#p')
	
	SRC_CODE_EXT=$(cat ./Makefile | sed -rn 's#^SRC_CODE_EXT.*:=\ *(.*)$#\1#p')
	
	SRC_HEADERS_EXT=$(cat ./Makefile | sed -rn 's#^SRC_HEADERS_EXT.*:=\ *(.*)$#\1#p')
	
	MAIN_FILE=$(cat ./Makefile | sed -rn 's#^MAIN_FILE.*:=\ *(.*)$#\1#p')
	
	EXCLUDED_FILES=$(cat ./Makefile | sed -rn 's#^EXCLUDED_FILES.*:=\ *(.*)$#\1#p')
	
	BIN_NAME=$(cat ./Makefile | sed -rn 's#^BIN_NAME.*:=\ *(.*)$#\1#p')
	
	BIN_ARGUMENTS=$(cat ./Makefile | sed -rn 's#^BIN_ARGUMENTS.*:=\ *(.*)$#\1#p')
	
	CXX=$(cat ./Makefile | sed -rn 's#^CXX\ *:=\ *(.*)$#\1#p')
	
	CXXFLAGS=$(cat ./Makefile | sed -rn 's#^CXXFLAGS.*:=\ *(.*)$#\1#p')
	
	EXECUTE_AFTER_COMPILATION=$(cat ./Makefile | sed -rn 's#^EXECUTE_AFTER_COMPILATION.*:=\ *(.*)$#\1#p')
	
	ALLOW_FOR_GNU_DEBUGGER=$(cat ./Makefile | sed -rn 's#^ALLOW_FOR_GNU_DEBUGGER.*:=\ *(.*)$#\1#p')
	
	GTEST_REPOSITORY="./make-files/googletest/googletest"
	
	GTEST_LIBRARY=$TMP_DIR/libgtest.a
}



# Process the variables into files and excludes the excluded files
processVariables(){
	MAIN=$(find $SRC_DIR -name "$MAIN_FILE" -type f)
	
	HEADERS=$(find $SRC_DIR -name "*.$SRC_HEADERS_EXT" -type f)
	
	CODE=$(find $SRC_DIR -name "*.$SRC_CODE_EXT" -type f)
	
	GTESTS=$(find $GTEST_DIR -name "*.$SRC_CODE_EXT" -type f)
	
	# if there is an extra libs folder, find all in the folder
	if [[ $EXTRA_LIB_DIR ]]; then
		EXTRA_LIBS=$(find $EXTRA_LIB_DIR -type f | tr "\n" " ")
	else
		EXTRA_LIBS=""
	fi
	
	# delete the main from code
	unset AUX
	AUX=""
	for code in $CODE; do
		if [[ "$code" =~ "$MAIN" ]]; then
			# echo -e "excluded!!" $code
			continue
		else
			AUX+=$code" "
		fi
	done
	CODE=$AUX
	
	# dinamic linking flags
	FLAGS_DIN_PATHS=$(find $SRC_DIR -type d)
	
	# binary file 
	BINARY=$OUTPUT_DIR/$BIN_NAME
	
	# if there are excluded files, then delete the ones matching the regex
	if [[ $EXCLUDED_FILES ]]; then
		
		
		for excluded in $EXCLUDED_FILES; do
			unset AUX
			AUX=""
			for code in $CODE; do
				if [[ "$code" =~ "$excluded" ]]; then
					echo -e "excluded!!" $code
					continue
				else
					AUX+=$code" "
				fi
			done
			CODE=$AUX
		done
		
		for excluded in $EXCLUDED_FILES; do
			unset AUX
			AUX=""
			for header in $HEADERS; do
				if [[ "$header" =~ "$excluded" ]]; then
					echo -e "excluded!!" $header
					continue
				else
					AUX+=$header" "
				fi
			done
			HEADERS=$AUX
		done
		
		for excluded in $EXCLUDED_FILES; do
			unset AUX
			AUX=""
			for gtest in $GTESTS; do
				if [[ "$gtest" =~ "$excluded" ]]; then
					echo -e "excluded!!" $gtest
					continue
				else
					AUX+=$gtest" "
				fi
			done
			GTESTS=$AUX
		done
		
		for excluded in $EXCLUDED_FILES; do
			unset AUX
			AUX=""
			for flag in $FLAGS_DIN_PATHS; do
				if [[ "$flag" =~ "$excluded" ]]; then
					echo -e "excluded!!" $flag
					continue
				else
					AUX+=$flag" "
				fi
			done
			FLAGS_DIN_PATHS=$AUX
		done
	
	fi
	
	
	# extra variables configuration
	
	# add -I to the dinamic flags directory
	for flag in $FLAGS_DIN_PATHS; do
		FLAGS_DIN+="-I "$flag" "
	done
	
	
	# set the project library name
	LIBRARY=$TMP_DIR/libproject.a
	
	# if the gdb is set to yes, add the -g flag 
	if [[ $ALLOW_FOR_GNU_DEBUGGER == "YES" ]]; then
		CXXFLAGS+=" -g"
	fi
	
	# objects
	for code in $CODE; do
		# fist we change the src for tmp and then the code extension to .o
		OBJECTS+=$(echo -e $code | sed -re 's#^'$SRC_DIR'(.*)\.'$SRC_CODE_EXT'$#'$TMP_DIR'\1.o#' )" "
	done
	OBJECTS=$(echo $OBJECTS | tr "\n" " ")
	
	# tmp folders
	TMP_FOLDERS=$TMP_DIR" "$(find $SRC_DIR/* -type d | sed -re 's#^'$SRC_DIR'(.*)#'$TMP_DIR'\1#')
}



# generates the main Makefile
generateMakefile(){
	rm ./make-files/Makefile
	touch ./make-files/Makefile
	
	
	
	echo "# this Makefile was generated automaticly by generic-makefile" >> ./make-files/Makefile
	
	
	# if execute after compilation is set, put the run at the start,
	# the  build, if not, first build then run
	if [[ $EXECUTE_AFTER_COMPILATION == "YES" ]]; then
		echo "
.PHONY : target
target : banner run
	
	
.PHONY : run
run : $BINARY
	@echo \"\tExecuting binary.\n\"
	@time \"$BINARY\" $BIN_ARGUMENTS
	
	
$BINARY : $MAIN $EXTRA_LIBS $LIBRARY
	@echo \"\tCompiling binary.\"
	@mkdir -p $OUTPUT_DIR
	@$CXX $MAIN $CXXFLAGS $FLAGS_DIN -o $BINARY $LIBRARY $EXTRA_LIBS
" >> ./make-files/Makefile
	
	else
		echo "
.PHONY : target
target : banner $BINARY
	
	
$BINARY : $MAIN $EXTRA_LIBS $LIBRARY
	@echo \"\tCompiling binary.\"
	@mkdir -p $OUTPUT_DIR
	@$CXX $MAIN $CXXFLAGS $FLAGS_DIN -o $BINARY $LIBRARY $EXTRA_LIBS
	
	
.PHONY : run
run : $BINARY
	@echo \"\tExecuting binary.\n\"
	@time \"$BINARY\" $BIN_ARGUMENTS
" >> ./make-files/Makefile
	fi
	
	
	
	
	
	# library compilation
	echo "
$LIBRARY : $OBJECTS
	@echo \"\tBuilding project library.\"
	@ar -rsc $LIBRARY $OBJECTS
" >> ./make-files/Makefile
	
	
	
	
	
	# object compilation
	for code in $CODE; do
		# get the corresponding object name and path for the code
		object=$(echo -e $code | sed -re 's#^'$SRC_DIR'(.*)\.'$SRC_CODE_EXT'$#'$TMP_DIR'\1.o#' )
		# tries to guess the header into file
		file=$(echo -e $code | sed -re 's#^(.*)\.'$SRC_CODE_EXT'$#\1.'$SRC_HEADERS_EXT'#' )
		# if the header exist it will be asigned to header
		header=$(find $SRC_DIR -wholename "$file" -type f)
		folder=$(echo $object | sed -re 's#^(.*)/[^/]*\.o$#\1#')
		echo "
$object : $code $header
	@echo \"\tPrecompiling object for $code.\"
	@mkdir -p $folder
	@$CXX -c $code $FLAGS_DIN -o $object;
" >> ./make-files/Makefile
	done
	
	
	
	
	# gdb
	if [[ $ALLOW_FOR_GNU_DEBUGGER == "YES" ]]; then
		echo "
.PHONY: gdb
gdb : clean $BINARY
	@echo \"\tLaunching gdb.\n\"
	@gdb $BINARY
" >> ./make-files/Makefile
	fi
	
	
	
	
	
	##################################
	########### googletest ###########
	##################################
	
	# if the googletest folder exists
	if [[ $GTEST_DIR ]]; then
		
		
		# execution of not of the googletests
		gtestBinaries=$(echo -e $GTESTS | tr " " "\n" | sed -re 's#^'$GTEST_DIR'(.*)\.'$SRC_CODE_EXT'$#'$OUTPUT_DIR'\1.out#' | tr "\n" " ")
		# if execution is set, put googletest as run
		if [[ $EXECUTE_AFTER_COMPILATION == "YES" ]]; then
			echo "
.PHONY : googletest
googletest : banner $gtestBinaries" >> ./make-files/Makefile
		for binary in $gtestBinaries; do
			echo "	@echo \"\n\tRunning $binary\"" >> ./make-files/Makefile
			echo "	$binary" >> ./make-files/Makefile
		done

		# else set it as compile only
		else
			echo "
.PHONY : googletest banner
googletest : banner $gtestBinaries 
" >> ./make-files/Makefile
		fi
		
		
		
		
		# googletest binaries
		for gtest in $GTESTS; do
			echo $gtest
			binary=$(echo $gtest | sed -re 's#^'$GTEST_DIR'(.*)\.'$SRC_CODE_EXT'$#'$OUTPUT_DIR'\1.out#')
			echo "
$binary : $GTEST_LIBRARY $LIBRARY $gtest
	@mkdir -p $OUTPUT_DIR
	@echo \"\tBuilding googletest $gtest.\"
	@g++ -isystem $GTEST_REPOSITORY/include -pthread $FLAGS_DIN $CXXFLAGS $gtest $LIBRARY $GTEST_LIBRARY -o $binary
" >> ./make-files/Makefile
		done
		
		
		
		
		# googletest library compilation
		echo "
$GTEST_LIBRARY : $TMP_DIR/gtest_main.o $TMP_DIR/gtest-all.o
	@echo \"\tCompiling googletest library.\"
	@ar -rc $GTEST_LIBRARY $TMP_DIR/gtest-all.o $TMP_DIR/gtest_main.o
" >> ./make-files/Makefile
		
		
		
		
		
		# googletest object creation
		echo "
$TMP_DIR/gtest_main.o : $GTEST_REPOSITORY/src/gtest_main.cc
	@echo \"\tPrecompiling googletest object for $GTEST_REPOSITORY/src/gtest_main.cc.\"
	@mkdir -p $TMP_DIR
	@g++ -isystem $GTEST_REPOSITORY/include -I $GTEST_REPOSITORY -pthread -c $GTEST_REPOSITORY/src/gtest_main.cc -o $TMP_DIR/gtest_main.o

$TMP_DIR/gtest-all.o : $GTEST_REPOSITORY/src/gtest-all.cc
	@echo \"\tPrecompiling googletest object for $GTEST_REPOSITORY/src/gtest-all.cc\"
	@mkdir -p $TMP_DIR
	@g++ -isystem $GTEST_REPOSITORY/include -I $GTEST_REPOSITORY -pthread -c $GTEST_REPOSITORY/src/gtest-all.cc -o $TMP_DIR/gtest-all.o
" >> ./make-files/Makefile
		
	fi
	
	
	
	
	
	
	
	
	
	
	
	# banner
	echo "
.PHONY : banner
banner :
	@cat ./make-files/fancy_banner_short.txt
" >> ./make-files/Makefile
	
	
	
	
	# help
	echo "
.PHONY : help
help:
	@cat ./make-files/banner.txt
	@cat ./make-files/help.txt
" >> ./make-files/Makefile
	
	
	
	
	
	
	# clean
	echo "
.PHONY : clean
clean:
	@echo \"\tRemoving temporal files\"
	@rm -rf $TMP_DIR
	@echo \"\tRemoving binary files\"
	@rm $OUTPUT_DIR/*.out
" >> ./make-files/Makefile
	
	
	
	
	
	
	# the ducky
	echo -e "#    __\n# __( o)>\n# \ <_ ) r90" >> ./make-files/Makefile
	
}











loadVariables

debugMakeVariables

processVariables

debugVariables

generateMakefile



#    __
# __( o)>
# \ <_ ) r90