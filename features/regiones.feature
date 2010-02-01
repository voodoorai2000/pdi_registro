#language: es
Característica: Editar Region

	Para saber donde nos conocen
	Como un administrador
	Quiero que los usuarios puedan decir en que region viven


  Antecedentes: 
    Dado una region "Comunidad Valenciana"
  
  Escenario: Seleccionar Region al activar la cuenta    
       Dado que me he registrado con éxito
          Y que he recibido el email de activacion
          Y que sigo el link "activa tu cuenta" en el email
   Entonces vere el formulario de activacion
        
    Cuando selecciono 'Comunidad Valenciana' como Región
         Y relleno el resto de campos del formulario de activacion
         Y hago click en "Enviar"
  Entonces estaré asociado a la región "Comunidad Valenciana"  
     
    Cuando voy a la pagina de mi perfil
  Entonces veré que mi region es "Comunidad Valenciana"
    
         
  Escenario: Seleccionar Region desde mi perfil    
          Y que estoy logado
  
  	 Cuando visito la pagina de editar mi perfil
  	      Y selecciono 'Comunidad Valenciana' como Región
  	      Y hago click en "Actualizar Cuenta"  	  
   Entonces estaré asociado a la región "Comunidad Valenciana"
      
     Cuando voy a la pagina de mi perfil
   Entonces veré que mi region es "Comunidad Valenciana"
