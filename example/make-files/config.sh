#!/bin/bash

# loads the variables from the Makefile configuration

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
	
	echo "FLAGS_DIN_PATHS:"
	for flag in $FLAGS_DIN_PATHS
	do
		echo -e "\t"$flag
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

	CXX=$(cat ./Makefile | sed -rn 's#^CXX.*:=\ *(.*)$#\1#p')

	CXXFLAGS=$(cat ./Makefile | sed -rn 's#^CXXFLAGS.*:=\ *(.*)$#\1#p')

	EXECUTE_AFTER_COMPILATION=$(cat ./Makefile | sed -rn 's#^EXECUTE_AFTER_COMPILATION.*:=\ *(.*)$#\1#p')

	ALLOW_FOR_GNU_DEBUGGER=$(cat ./Makefile | sed -rn 's#^ALLOW_FOR_GNU_DEBUGGER.*:=\ *(.*)$#\1#p')
}



# Process the variables into files and excludes the excluded files
processVariables(){
	MAIN=$(find $SRC_DIR -name "$MAIN_FILE" -type f)
	
	HEADERS=$(find $SRC_DIR -name "*.$SRC_HEADERS_EXT" -type f)
	
	CODE=$(find $SRC_DIR -name "*.$SRC_CODE_EXT" -type f)
	
	GTESTS=$(find $GTEST_DIR -name "*.$SRC_CODE_EXT" -type f)
	
	if [[ $EXTRA_LIB_DIR ]]; then
		EXTRA_LIBS=$(find $EXTRA_LIB_DIR -type f)
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
	fi
	
	# extra variables configuration
	
	FLAGS_DIN_PATHS=$(find $SRC_DIR -type d)
	
	LIBRARY=$TMP_DIR/libproject.a
}



# generates the main Makefile
generateMakefile(){
	rm ./make-files/Makefile
	touch ./make-files/Makefile
	
	
	
	echo "# this Makefile was generated automaticly by generic-makefile" >> ./make-files/Makefile
	
	
	# if execute after compilation is set, put the run at the start,
	# the  build, if not, first build then run
	if [[ $EXECUTE_AFTER_COMPILATION == "YES" ]]; then
echo -e "
.PHONY : run
run : $OUTPUT_DIR/$BIN_NAME
	time \"$OUTPUT_DIR/$BIN_NAME\" $BIN_ARGUMENTS

$OUTPUT_DIR/$BIN_NAME : banner $TMP_FOLDERS $MAIN $EXTRA_LIBS $LIBRARY

" >> ./make-files/Makefile
	fi
	
	
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