#include "foo.h"
#include <string>
std::string Persona::getApellidosyNombre(){
	std::string nombrecompleto;
	
	nombrecompleto = apellidos_ + ',' + ' ';
	nombrecompleto += Nombre_;
	
	return nombrecompleto;
}
Persona::Persona(std::string dni, std::string nombre, std::string apellidos, std::string direccion, std::string localidad, std::string provincia, std::string pais)
{
	DNI_ = dni;
	Nombre_ = nombre;
	apellidos_ = apellidos; 
	direccion_ = direccion;
	localidad_ = localidad;
	provincia_ = provincia;
	pais_ = pais;
}
