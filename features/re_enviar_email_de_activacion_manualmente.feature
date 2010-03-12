#language: es

Característica: Re-enviar email de activacion manualmente

	Para los usuarios que no han visto/recibido el email de activacion
	Como un administrador
	Quiero que se envie el email de activacion a los usuarios que no han activado su cuenta pasado una semana

  Esquema del escenario: Re-enviar email de activacion
        Dado que estamos <momento en el tiempo>
           Y "Ana" una usuaria activada con email "ana@gmail.com"
           Y "Jose" un usuario registrado pero no activado con email "jose@gmail.com"
           
      Cuando volvemos al presente        
           Y ejecuto el metodo para renviar el email de activacion
    
    Entonces <accion1>
        Pero no se enviara ningun email a "ana@gmail.com"
        
    Ejemplos:
            | momento en el tiempo    | accion1                                              | 
            | a dia de hoy            | no se enviara ningun email a "jose@gmail.com"        | 
            | un dia en el pasado     | no se enviara ningun email a "jose@gmail.com"        | 
            | una semana en el pasado | se enviara el email de activacion a "jose@gmail.com" | 
