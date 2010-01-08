#language: es
Característica: Editar Perfil

	Para poder hacer mejores campañas de marketing
	Como el departamente de marketing
	Quiero que los usuarios rellenen varios campos
  
  Escenario: Editar mi informacion al activar la cuenta
       Dado que me he registrado con éxito
          Y que he recibido el email de activacion
          Y que sigo el link "activate your account" en el email
   Entonces vere el formulario de activacion
   
    Cuando relleno "Last Name" con 'Perez Duarte'
         Y relleno "Age" con '28'
         Y selecciono 'Male' como Sexo
         Y relleno el resto de campos del formulario de activacion
         Y hago click en "Activate"    
         
    Cuando voy a la pagina de mi perfil
  Entonces veré que mis apellidos son "Perez Duarte"
         Y veré que mi edad es "28"
         Y veré que mi sexo es "Male"
    
    
    
  Escenario: Editar mi informacion desde mi perfil
          Y que estoy logado
  
  	 Cuando visito la pagina de editar mi perfil
  	      Y relleno "Last Name" con 'Perez Duarte'
          Y relleno "Age" con '28'
          Y selecciono 'Male' como Sexo
  	      Y hago click en "Update Account Information"  	  
      
     Cuando voy a la pagina de mi perfil
   Entonces veré que mis apellidos son "Perez Duarte"
          Y veré que mi edad es "28"
          Y veré que mi sexo es "Male"