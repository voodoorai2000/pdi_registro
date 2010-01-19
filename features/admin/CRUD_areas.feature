#language: es
@current
Característica: Crear, Editar, Mostrar, Borrar Areas

	Para que la gente se apunte a areas de colaboracoin necesarias
	Como un administrador
	Quiero definir las areas de colaboracion necesarias

  Antecedentes:
       Dado "Hector" un usuario administrador

  Escenario: Crear, Editar, Mostrar, Borrar Areas
          Y que estoy logado como "Hector"
     Cuando hago click en el link "Panel De Administración"   
          Y hago click en el link "Areas"
          Y hago click en el link "Nueva area"
          Y relleno nombre con "Software"
   			  Y hago click en "Crear"
   			  
   Entonces veré el texto "Software"
   
   	 Cuando hago click en el link "Editar"
   	      Y relleno nombre con "Marketing"
   	   	  Y hago click en "Guardar"
   
   Entonces veré el texto "Marketing"
   
   	 Cuando hago click en el link "Atras"
          Y hago click en el link "Borrar"
   Entonces no veré el texto "Marketing"
