#language: es
Característica: Borrar usuarios

	Para poder borrar usuarios registrados...
	Como un administrador
	Quiero poder borrar usuarios

  Antecedentes:
       Dado "Hector" un usuario administrador
          Y un usuario "Juan"

  @current
  Escenario: Borrar usuarios
          Y que estoy logado como "Hector"
     Cuando hago click en el link "Panel De Administración"   
          Y hago click en el link "Usuarios"
          Y hago click en el link "borrar" al lado de "Juan"
   Entonces vere "usuario borrado"
          Y el usuario "Juan" no estará en la base de datos