#include "Greeter.hpp"

Greeter::Greeter(){
	greeting_="hello world!";
}
void Greeter::greet(){
	std::cout << greeting_ << '\n';
}
