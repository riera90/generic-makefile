# this Makefile was generated automaticly by generic-makefile

.PHONY : target
target : banner run
	
	
.PHONY : run
run : ./output/bin.out
	@echo "\tExecuting binary.\n"
	@time "./output/bin.out" hi!
	
	
./output/bin.out : ./src/main.cpp  ./tmp/libproject.a
	@echo "\tCompiling binary."
	@mkdir -p ./output
	@g++ ./src/main.cpp -Wpedantic -I ./src -I ./src/classes  -o ./output/bin.out ./tmp/libproject.a 


./tmp/libproject.a : ./tmp/classes/Greeter.o 
	@echo "\tBuilding project library."
	@ar -rsc ./tmp/libproject.a ./tmp/classes/Greeter.o 


./tmp/classes/Greeter.o : ./src/classes/Greeter.cpp ./src/classes/Greeter.hpp
	@echo "\tPrecompiling object for ./src/classes/Greeter.cpp."
	@mkdir -p ./tmp/classes
	@g++ -c ./src/classes/Greeter.cpp -I ./src -I ./src/classes  -o ./tmp/classes/Greeter.o;


.PHONY : googletest
googletest : banner ./output/unittest.out 
	@echo "\n\tRunning ./output/unittest.out"
	./output/unittest.out

./gtests/unittest.cpp : ./tmp/libgtest.a ./tmp/libproject.a ./gtests/unittest.cpp
	@mkdir -p ./output
	@echo "\tBuilding googletest ./gtests/unittest.cpp."
	@g++ -isystem ./make-files/googletest/googletest/include -pthread -I ./src -I ./src/classes  -Wpedantic ./gtests/unittest.cpp ./tmp/libproject.a ./tmp/libgtest.a -o ./gtests/unittest.cpp


./tmp/libgtest.a : ./tmp/gtest_main.o ./tmp/gtest-all.o
	@echo "\tCompiling googletest library."
	@ar -rc ./tmp/libgtest.a ./tmp/gtest-all.o ./tmp/gtest_main.o


./tmp/gtest_main.o : ./make-files/googletest/googletest/src/gtest_main.cc
	@echo "\tPrecompiling googletest object for ./make-files/googletest/googletest/src/gtest_main.cc."
	@mkdir -p ./tmp
	@g++ -isystem ./make-files/googletest/googletest/include -I ./make-files/googletest/googletest -pthread -c ./make-files/googletest/googletest/src/gtest_main.cc -o ./tmp/gtest_main.o

./tmp/gtest-all.o : ./make-files/googletest/googletest/src/gtest-all.cc
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
