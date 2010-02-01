#language: es
Característica: Ranking (Dashboard)

	Para poder ver informacion util en mi dashboard
	Como un usuario
	Quiero ver un ranking de las top 5 ciudades simpatizantes con el PDI
  

  Escenario: Ranking to 5
        Dado las regiones "Madrid, Barcelona, Las Palmas, Andalucia, Islas Baleares, A Coruña"
           Y que la region "A Coruña" tiene 2 usuarios
           Y que la region "Madrid" tiene 11 usuarios
           Y que la region "Las Palmas" tiene 5 usuarios
           Y que la region "Islas Baleares" tiene 7 usuarios
           Y que la region "Barcelona" tiene 6 usuarios
           Y que la region "Andalucia" tiene 4 usuarios
           Y que estoy logado

      Cuando voy a "/dashboard"
      
    Entonces vere "Top 5 del Ranking"
           Y vere "Ya somos 36"
    Entonces vere las regiones "Madrid, Islas Baleares, Barcelona, Las Palmas y Andalucia" en ese orden
           Y no vere la region "A Coruña"
           Y vere que "Madrid" tiene 11 usuarios registrados
           Y vere que "Islas Baleares" tiene 7 usuarios registrados
           Y vere que "Barcelona" tiene 6 usuarios registrados
           Y vere que "Las Palmas" tiene 5 usuarios registrados
           Y vere que "Andalucia" tiene 4 usuarios registrados
           
           
           