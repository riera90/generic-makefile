# this Makefile was generated automaticly by generic-makefile

.PHONY : run
run : ./output/bin.out
	@echo "\tExecuting binary.\n"
	@time "./output/bin.out" hi!


./output/bin.out : banner ./output ./src/main.cpp  ./tmp/libproject.a
	@echo "\tCompiling binary."
	g++ ./src/main.cpp -Wpedantic -g -I ./src -I ./src/classes  -o ./output/bin.out ./tmp/libproject.a 


./tmp/libproject.a : ./tmp/classes/Greeter.o  ./tmp
	@echo "\tBuilding project library."
	ar -rsc ./tmp/libproject.a ./tmp/classes/Greeter.o 


./tmp/classes/Greeter.o : ./src/classes/Greeter.cpp ./src/classes/Greeter.hpp ./tmp/classes
	@echo "\tPrecompiling object for ./src/classes/Greeter.cpp."
	g++ -c ./src/classes/Greeter.cpp -I ./src -I ./src/classes  -o ./tmp/classes/Greeter.o;


./tmp : 
	@mkdir -p ./tmp


./tmp/classes : 
	@mkdir -p ./tmp/classes


./output : 
	@mkdir -p ./output 


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
