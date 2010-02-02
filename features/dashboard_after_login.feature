#language: es
Característica: Dashboard al identificarse

	Para ver algo interesante cuando me identifico
	Como un usuario
	Quiero ser enviado al dashboard cuando me identifico
  
  @current
  Escenario: Enviar al Dashboard al identificarse
       Dado I am a confirmed user "bob" with password "secret"
     Cuando I go to the login page
          Y I fill in "usuario" with "bob"
          Y I fill in "contraseña" with "secret"
          Y I check "Recordarme"
          Y I press "Entrar"
   Entonces I should be on the dashboard page