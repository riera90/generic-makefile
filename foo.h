#ifndef PERSONA_H
#define PERSONA_H
#include <string>
/*
 * TAD Persona
 * DESCRIPCIÓN El TAD Persona representa la información y datos de una persona
 * OPERACIONES 
 */
class Persona{
	private:
		std::string DNI_, Nombre_, apellidos_, direccion_, localidad_, provincia_, pais_;
	public:
		/*
		 *	PROC Persona(string dni,string nombre,string apellidos,
		 * string direccion,string localidad,string provincia,string pais)
		 *	DEV ()
		 *	REQUIERE Se necesita introducir el primer parámetro, los demás son opcionales
		 *	MODIFICA Siempre se modifica DNI_
		 *	EFECTOS Al crear un objeto, este contiene los datos introducidos por
		 * parámetros
		 */
		Persona(std::string dni, std::string nombre="", std::string apellidos="", std::string direccion="", std::string localidad="", std::string provincia="", std::string pais="");
		/*
		 *	PROC getApellidosyNombre() DEV (string apellidosnombre)
		 *	REQUIERE True
		 *	MODIFICA 0
		 *	EFECTOS Devuelve la concatenación de las cadenas apellidos y nombre de la
		 *			  siguiente forma: apellidos, nombre
		 */
		std::string getApellidosyNombre();
		/*
		 *	PROC getNombre() DEV (string Nombre_)
		 *	REQUIERE True
		 *	MODIFICA 0
		 *	EFECTOS Devuelve la cadena Nombre_
		 */
		std::string getNombre(){
			return Nombre_;
		}
		/*
		 *	PROC setNombre(string nombre) DEV ()
		 *	REQUIERE True
		 *	MODIFICA Nombre_
		 *	EFECTOS El dato privado nombre_ recibe el valor de la string nombre
		 */
		void setNombre(std::string nombre){
			Nombre_=nombre;
		}
		/*
		 *	PROC getDNI() DEV (string DNI_)
		 *	REQUIERE True
		 *	MODIFICA 0
		 *	EFECTOS Devuelve la cadena DNI_
		 */
		std::string getDNI(){
			return DNI_;
		}
		/*
		 *	PROC setDNI(string dni) DEV ()
		 *	REQUIERE True
		 *	MODIFICA DNI_
		 *	EFECTOS El dato privado DNI_ recibe el valor del parámetro
		 */	
		void setDNI(std::string dni){
			DNI_=dni;
		}
		/*
		 *	PROC getApellidos() DEV (string apellidos_)
		 *	REQUIERE True
		 *	MODIFICA Nombre_
		 *	EFECTOS Devuelve la cadena apellidos_
		 */	
		std::string getApellidos(){
			return apellidos_;
		}
		/*
		 *	PROC setApellidos(string apellidos) DEV ()
		 *	REQUIERE True
		 *	MODIFICA apellidos_
		 *	EFECTOS El dato privado apellidos_ recibe el valor del parámetro
		 */	
		void setApellidos(std::string apellidos){
			apellidos_=apellidos;
		}
		/*
		 *	PROC getDireccion() DEV (string direccion_)
		 *	REQUIERE True
		 *	MODIFICA 0
		 *	EFECTOS Devuelve la cadena direccion_
		 */
		std::string getDireccion(){
			return direccion_;
		}
		/*
		 *	PROC setDireccion(string direccion) DEV ()
		 *	REQUIERE True
		 *	MODIFICA direccion_
		 *	EFECTOS El dato privado direccion_ recibe el valor del parámetro
		 */
		void setDireccion(std::string direccion){
			direccion_=direccion;
		}
		/*
		 *	PROC getLocalidad() DEV (string localidad_)
		 *	REQUIERE True
		 *	MODIFICA 0
		 *	EFECTOS Devuelve la cadena localidad_
		 */
		std::string getLocalidad(){
			return localidad_;
		}
		/*
		 *	PROC setLocalidad(string localidad) DEV ()
		 *	REQUIERE True
		 *	MODIFICA localidad_
		 *	EFECTOS El dato privado localidad_ recibe el valor del parámetro
		 */	
		void setLocalidad(std::string localidad){
			localidad_=localidad;
		}
		/*
		 *	PROC getProvincia() DEV (string provincia_)
		 *	REQUIERE True
		 *	MODIFICA 0
		 *	EFECTOS Devuelve la cadena provincia_
		 */
		std::string getProvincia(){
			return provincia_;
		}
		/*
		 *	PROC setProvincia(string provincia) DEV ()
		 *	REQUIERE True
		 *	MODIFICA provincia_
		 *	EFECTOS El dato privado provincia_ recibe el valor del parámetro
		 */
		void setProvincia(std::string provincia){
			provincia_=provincia;
		}
		/*
		 *	PROC getPais() DEV (string pais_)
		 *	REQUIERE True
		 *	MODIFICA 0
		 *	EFECTOS Devuelve la cadena pais_
		 */
		std::string getPais(){
			return pais_;
		}
		/*
		 *	PROC setPais(string pais) DEV ()
		 *	REQUIERE True
		 *	MODIFICA pais_
		 *	EFECTOS El dato privado pais_ recibe el valor del parámetro
		 */
		void setPais(std::string pais){
			pais_=pais;
		}
};
#endif
