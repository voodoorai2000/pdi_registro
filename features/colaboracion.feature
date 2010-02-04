#language: es
Característica: Colaboracion

	Para poder pedir ayuda en las distintas areas del partido
	Como el Partido de Internet
	Quiero que los usuarios seleccionen en que areas quieren colaborar
  
  Escenario: Areas de Colaboración
        Dado 2 areas de colaboracion "Software y Marketing"
        Dado que estoy logado
      Cuando visito "/colaborate"
           Y marco "Software"
  		     Y marco "Marketing"
  		     Y hago click en "Enviar" 
  		     
  	Entonces estaré asociado a las siguientes areas de colaboracion:
            	 | nombre    |
            	 | Software  |
            	 | Marketing |	  
            	 
      Cuando visito "/colaborate"
    Entonces el checkbox "Software" estará marcado
           Y el checkbox "Marketing" estará marcado
 