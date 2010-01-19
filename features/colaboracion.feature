#language: es
Característica: Colaboracion

	Para poder pedir ayuda en las distintas areas del partido
	Como el Partido de Internet
	Quiero que los usuarios seleccionen en que areas quieren colaborar
  
  Escenario: Seleccionar Areas de Colaboración
        Dado 2 areas de colaboracion "Software y Marketing"
        Dado que estoy logado
      Cuando visito la pagina de editar mi perfil
           Y marco "Software"
  		     Y marco "Marketing"
  		     Y hago click en "Actualizar Cuenta" 
  		     
  	Entonces estaré asociado a las siguientes areas de colaboracion:
            	 | nombre    |
            	 | Software  |
            	 | Marketing |	  