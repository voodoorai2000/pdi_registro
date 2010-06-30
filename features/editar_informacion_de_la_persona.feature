#language: es
Característica: Editar Perfil

	Para poder hacer mejores campañas
	Como el departamente de marketing
	Quiero que los usuarios rellenen varios campos

  Antecedentes: 
    Dado dos regiones "Comunidad Valenciana y Islas Baleares"
  
  Escenario: Rellenar mi informacion al crear la cuenta
       Dado que voy a la pagina principal
          
     Cuando relleno "usuario" con "bob"
          Y relleno "email" con "pedrix@example.com"
          Y relleno "escriba su contraseña" con "secret"
          Y relleno "confirmación contraseña" con "secret"
          
          Y relleno "nombre" con "Pedro"
          Y relleno "Apellidos" con 'Perez Duarte'
          Y relleno "Fecha de nacimiento" con '24/04/1982'   
          Y selecciono 'Masculino' como Sexo
          Y selecciono 'Comunidad Valenciana' como Región
          Y hago click en "Enviar"    
          Y activo mi cuenta
          Y me autentifico          
          Y voy a la pagina de mi perfil

  Entonces veré que mi nombre es "Pedro"
         Y veré que mis apellidos son "Perez Duarte"
         Y veré que mi fecha de nacimiento es "24/04/1982"
         Y veré que mi sexo es "Masculino"
         Y veré que mi region es "Comunidad Valenciana"
    
    
  Escenario: Editar mi informacion desde mi perfil
          Y que estoy logado
  
  	 Cuando visito la pagina de editar mi perfil
  	      Y relleno "Apellidos" con 'Perez Duarte'
          Y relleno "Fecha de nacimiento" con '24/04/1982'
          Y selecciono 'Masculino' como Sexo
          Y selecciono 'Islas Baleares' como Región
  	      Y hago click en "Actualizar Cuenta"  	  
      
     Cuando voy a la pagina de mi perfil
   Entonces veré que mis apellidos son "Perez Duarte"
          Y veré que mi fecha de nacimiento es "24/04/1982"
          Y veré que mi sexo es "Masculino"
          Y veré que mi region es "Islas Baleares"
          