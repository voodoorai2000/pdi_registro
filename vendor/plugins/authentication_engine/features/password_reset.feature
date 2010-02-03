Feature: Password Reset
  As a user who forgot my password
  I want to reset my password
  So that I can continue using the site

  Scenario: Display a reset password form
    Given I am an anonymous user
    When I go to the login page
    Then I should see "Olvidé mi contraseña"
    When I follow "Olvidé mi contraseña"
    Then I should see a reset password form

  Scenario: Send a reset instructions email if given a valid email
    Given I am a confirmed user with email "bob@example.com"
    When I go to the reset password page
    And I fill in "Su Direccion De Email" with "bob@example.com"
    And I press "Resetear mi contraseña"
    Then "bob@example.com" should receive an email
    When I open the email
    And I should see "resetear mi contrase&ntilde;a" in the email body
  
  Scenario: Do not send a reset instructions email if given an invalid email
    Given I am a confirmed user with email "bob@example.com"
    When I go to the reset password page
    And I fill in "Su Direccion De Email" with "unknown@example.com"
    And I press "Resetear mi contraseña"
    Then "bob@example.com" should receive no emails
    And "unknown@example.com" should receive no emails
    And I should see "No se ha encontrado ningún usuario con esa dirección de email"
  
  Scenario: Display change password form with valid token
    Given I am a user who opened my reset password email
    When I follow "resetear mi contrase&ntilde;a" in the email
    Then I should see a password modification form
  
  Scenario: Not display change password form with invalid token
    Given I am a user who opened my reset password email
    When I go to the change password form with bad token
    Then I should not see a password modification form
  
  Scenario: Update password and log in user with valid input
    Given I am a user who opened my reset password email
    When I follow "resetear mi contrase&ntilde;a" in the email
    Then I should see a password modification form
    When I fill in "Nueva contraseña" with "new secret"
    And I fill in "Confirmacíon nueva contraseña" with "new secret"
    And I press "Actualiza mi contraseña y logeame"
    And I should see "Contraseña actualizada correctamente"
    Then I should see my account page
    When I follow "Cerrar Sesión"
    Then I should be logged out
  
  Scenario Outline: Don't update password and log in user with invalid input
    Given I am a user who opened my reset password email
    When I follow "resetear mi contrase&ntilde;a" in the email
    Then I should see a password modification form
    When I fill in "Nueva contraseña" with "<password>"
    And I fill in "Confirmacíon nueva contraseña" with "<confirmation>"
    And I press "Actualiza mi contraseña y logeame"
    Then I should see a password modification form
    And I should not see my account page
    And I should have <count> errors
    And I should see "<error_message>"
    And I should not see "Password successfully updated"
  
    Examples:
      | password   | confirmation | count | error_message                                                      |
      |            |              | 2     | Contraseña es demasiado corta (4 caracteres mínimo).               |
      |            | new secret   | 2     | Contraseña es demasiado corta (4 caracteres mínimo).               |
      | new secret |              | 2     | Confirmación contraseña es demasiado corta (4 caracteres mínimo).  |
      | new secret | secret       | 1     | Contraseña no coincide con la confirmación.                        |
