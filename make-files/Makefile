# this Makefile was generated automaticly by generic-makefile

.PHONY : target
target : banner run
	
	
.PHONY : run
run : ./output/bin.out
	@echo "\tExecuting binary.\n"
	@time "./output/bin.out" hi!
	
	
./output/bin.out :   ./tmp/libproject.a
	@echo "\tCompiling binary."
	@mkdir -p ./output
	@g++  -Wpedantic  -o ./output/bin.out ./tmp/libproject.a 


./tmp/libproject.a :  
	@echo "\tBuilding project library."
	@ar -rsc ./tmp/libproject.a  


.PHONY : googletest
googletest : banner  

./tmp/libgtest.a : ./tmp/gtest_main.o ./tmp/gtest_all.o
	@echo "\tCompiling googletest library."
	@ar -rc ./tmp/libgtest.a ./tmp/gtest-all.o ./tmp/gtest_main.o


./tmp/gtest_main.o : ./make-files/googletest/googletest/src/gtest_main.cc
	@echo "\tPrecompiling googletest object for ./make-files/googletest/googletest/src/gtest_main.cc."
	@mkdir -p ./tmp
	@g++ -isystem ./make-files/googletest/googletest/include -I ./make-files/googletest/googletest -pthread -c ./make-files/googletest/googletest/src/gtest_main.cc -o ./tmp/gtest_main.o

./tmp/gtest_all.o : ./make-files/googletest/googletest/src/gtest-all.cc
	@echo "\tPrecompiling googletest object for ./make-files/googletest/googletest/src/gtest-all.cc"
	@mkdir -p ./tmp
	@g++ -isystem ./make-files/googletest/googletest/include -I ./make-files/googletest/googletest -pthread -c ./make-files/googletest/googletest/src/gtest-all.cc -o ./tmp/gtest-all.o


.PHONY : banner
banner :
	@cat ./make-files/fancy_banner_short.txt


.PHONY : help
help:
	@cat ./make-files/banner.txt
	@cat ./make-files/help.txt


.PHONY : clean
clean:
	@echo "\tRemoving temporal files"
	@rm -rf ./tmp
	@echo "\tRemoving binary files"
	@rm ./output/*.out

#    __
# __( o)>
# \ <_ ) r90
