#language: es
Característica: Ranking

	Para saber en que zonas se nos conoce más
	Como un administrador
	Quiero ver un ranking the registros por comunidad autonoma
	
  Antecedentes:
      Dado las regiones "Islas Baleares y Comunidad Valenciana"

  Escenario: Ranking
     Dado que la region "Islas Baleares" tiene 10 usuarios
        Y que la region "Comunidad Valenciana" tiene 5 usuarios
 
    Cuando voy a "/ranking"
  Entonces vere las regiones "Islas Baleares, Comunidad Valenciana" en ese orden
         Y vere que "Islas Baleares" tiene 10 usuarios registrados
         Y vere que "Comunidad Valenciana" tiene 5 usuarios registrados
    
  Escenario: Ojito manolo Ranking con usuarios sin provincia
        Dado que me he registrado con éxito
           Y que he recibido el email de activacion
           Y que sigo el link "activa tu cuenta" en el email
        Pero no hago nada mas
      Cuando voy a "/ranking"
    Entonces veré el texto "Ranking" 