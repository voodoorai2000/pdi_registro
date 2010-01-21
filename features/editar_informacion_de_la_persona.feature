#language: es
Característica: Editar Perfil

	Para poder hacer mejores campañas
	Como el departamente de marketing
	Quiero que los usuarios rellenen varios campos
  
  Escenario: Editar mi informacion al activar la cuenta
       Dado que me he registrado con éxito
          Y que he recibido el email de activacion
          Y que sigo el link "activa tu cuenta" en el email
   Entonces vere el formulario de activacion
   
    Cuando relleno "Apellidos" con 'Perez Duarte'
         Y relleno "Edad" con '28'
         Y selecciono 'Masculino' como Sexo
         Y relleno el resto de campos del formulario de activacion
         Y hago click en "Activar"    
         
    Cuando voy a la pagina de mi perfil
  Entonces veré que mis apellidos son "Perez Duarte"
         Y veré que mi edad es "28"
         Y veré que mi sexo es "Masculino"
    
    
    
  Escenario: Editar mi informacion desde mi perfil
          Y que estoy logado
  
  	 Cuando visito la pagina de editar mi perfil
  	      Y relleno "Apellidos" con 'Perez Duarte'
          Y relleno "Edad" con '28'
          Y selecciono 'Masculino' como Sexo
  	      Y hago click en "Actualizar Cuenta"  	  
      
     Cuando voy a la pagina de mi perfil
   Entonces veré que mis apellidos son "Perez Duarte"
          Y veré que mi edad es "28"
          Y veré que mi sexo es "Masculino"
          