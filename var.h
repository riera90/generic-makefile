#ifndef CRUPIER_H
#define CRUPIER_H
#include "foo.h"
/*
 * TAD Crupier
 * DESCRIPCIÓN El TAD Crupier representa los datos de un crupier
 * OPERACIONES 
 */

class Crupier : public Persona{
	private:
		std::string codigo_;
	public:
		/*
		 *	PROC Crupier(string dni,string codigo,string nombre,string apellidos,
		 * string direccion,string localidad,string provincia,string pais):
		 *	Persona(dni,nombre,apellidos,direccion,localidad,provincia,pais)
		 *	DEV ()
		 *	REQUIERE Se necesita introducir el primer y segundo parámetro, los demás son 
		 *	opcionales
		 *	MODIFICA Siempre se modifica DNI_ y codigo_
		 *	EFECTOS Al crear un objeto, como es de una clase heredara, pasa los datos
		 * necesarios a la clase de la que hereda
		 */
		Crupier(std::string dni, std::string codigo, std::string nombre="", std::string apellidos="", std::string direccion="", std::string localidad="", std::string provincia="", std::string pais="") : Persona(dni, nombre, apellidos, direccion, localidad, provincia, pais){
			codigo_=codigo;
		}
		/*
		 *	PROC getCodigo() DEV (string codigo_)
		 *	REQUIERE True
		 *	MODIFICA 0
		 *	EFECTOS Devuelve la cadena codigo_
		 */
		std::string getCodigo(){
			return codigo_;
		}
		/*
		 *	PROC setCodigo(string codigo) DEV ()
		 *	REQUIERE True
		 *	MODIFICA codigo_
		 *	EFECTOS El dato privado codigo_ recibe el valor del parámetro
		 */
		void setCodigo(std::string codigo){
			codigo_=codigo;
		}
};		
#endif
