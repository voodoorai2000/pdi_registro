#language: es
Característica: Ranking

	Para saber en que zonas se nos conoce más
	Como un administrador
	Quiero ver un ranking the registros por comunidad autonoma
	
  Antecedentes:
      Dado las regiones "Islas Baleares y Comunidad Valenciana"

  @current
  Escenario: Ranking
     Dado que la region "Islas Baleares" tiene 10 usuarios
        Y que la region "Comunidad Valenciana" tiene 5 usuarios
 
    Cuando voy a "/ranking"
  Entonces vere las regiones "Islas Baleares, Comunidad Valenciana" en ese orden
         Y vere "Islas Baleares (10)"
         Y vere "Comunidad Valenciana (5)"
         