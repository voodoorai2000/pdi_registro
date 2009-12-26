# language: es
Característica: Gestión de Huertos
  Para [beneficio]
  Como [sujeto]
  Quiero [característica/comportamiento]
  
  Escenario: Añadir un/a nuevo/a Huerto
    Dado que visito la página de nuevo/a Huerto
    Cuando relleno nombre con "nombre 0"
         Y relleno área con "0"
         Y relleno longitud con "longitud 0"
         Y relleno latitud con "latitud 0"
         Y relleno usado con "true"
         Y pulso el botón "Crear"
    Entonces debería ver el texto "nombre 0"
           Y debería ver el texto "0"
           Y debería ver el texto "longitud 0"
           Y debería ver el texto "latitud 0"
           Y debería ver el texto "true"

  Escenario: Borrar Huerto
    Dado que tenemos los/las siguientes Huertos:
      |nombre|área|longitud|latitud|usado|
      |nombre 1|1|longitud 1|latitud 1|false|
      |nombre 2|2|longitud 2|latitud 2|true|
      |nombre 3|3|longitud 3|latitud 3|false|
      |nombre 4|4|longitud 4|latitud 4|true|
    Cuando borro el/la Huerto en la tercera posición
    Entonces debería ver una tabla con los siguientes contenidos:
      |nombre|área|longitud|latitud|usado|
      |nombre 1|1|longitud 1|latitud 1|false|
      |nombre 2|2|longitud 2|latitud 2|true|
      |nombre 4|4|longitud 4|latitud 4|true|
