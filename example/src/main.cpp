#include <iostream>
#include "Greeter.hpp"

int main(int argc, const char** argv) {
	Greeter greeter;
	greeter.greet();
	std::cout << "\n";
	for (int argumentIndex = 1; argumentIndex < argc; argumentIndex++)
	{
		printf("argument %i is %s\n", argumentIndex, argv[argumentIndex] );
	}
	return 0;
}
