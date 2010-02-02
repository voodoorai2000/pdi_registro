#language: es
Característica: Borrar usuarios

	Para poder borrar usuarios registrados...
	Como un administrador
	Quiero poder borrar usuarios

  Antecedentes:
       Dado "Hector" un usuario administrador
          Y un usuario "Juan"

  Escenario: Borrar usuarios
          Y que estoy logado como "Hector"
     Cuando hago click en el link "Panel De Administración"   
          Y hago click en el link "Usuarios"
          Y al lado del usuario "Juan" hago click en el link "borrar" 
   Entonces vere "Usuario borrado"
          Y el usuario "Juan" no estará en la base de datos