#ifndef _GREETER_HPP_
#define _GREETER_HPP_

#include <string>
#include <iostream>

class Greeter{
	private:
		std::string greeting_;
	public:
		Greeter();
		void greet();
};

#endif
