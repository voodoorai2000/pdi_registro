#language: es
Característica: Editar Region

	Para saber donde nos conocen
	Como un administrador
	Quiero que los usuarios puedan decir en que region viven

  @current
  Escenario: Seleccionar Region
       Dado una region "Comunidad Valenciana"
          Y que estoy logado como "Jose"
  
  	 Cuando visito la pagina de editar mi perfil
  	      Y selecciono 'Comunidad Valenciana' como Region
  	      Y hago click en "Update Account Information"  	  
   Entonces el usuario "Jose" estará asociado a la región "Comunidad Valenciana"
      
     Cuando voy a la pagina de mi perfil
   Entonces veré que mi region es "Comunidad Valenciana"
