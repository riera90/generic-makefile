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
	@g++ ./src/main.cpp -Wpedantic -g -I ./src -I ./src/classes  -o ./output/bin.out ./tmp/libproject.a 


./tmp/libproject.a : ./tmp/classes/Greeter.o 
	@echo "\tBuilding project library."
	@ar -rsc ./tmp/libproject.a ./tmp/classes/Greeter.o 


./tmp/classes/Greeter.o : ./src/classes/Greeter.cpp ./src/classes/Greeter.hpp
	@echo "\tPrecompiling object for ./src/classes/Greeter.cpp."
	@mkdir -p ./tmp/classes
	@g++ -c ./src/classes/Greeter.cpp -I ./src -I ./src/classes  -o ./tmp/classes/Greeter.o;


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
