##Commenting not necessary yet
#Feature: Requested Invitation
#  As a anonymous user
#  I want to invite my friends to join this site
#  So that we can have the same experience
#
#  Background:
#    Given "sharon" an admin user
#
#  Scenario: Display invitation form to anonymous user
#    Given "joanne" is an anonymous user
#    When I go to the homepage
#    Then I should see "Solicitar Invitación"
#    When I follow "Solicitar Invitación"
#    Then I should see the invitation request form
#  
#  Scenario: Allow an anonymous user to be invited
#    Given "joanne" is an anonymous user
#    When I go to the invitation request form
#    And I fill in "Su nombre completo" with "joanne"
#    And I fill in "Su email" with "joanne@example.com"
#    And I press "¡Solicitar!"
#    Then I should have a successful invitation
#  
#  Scenario Outline: Not allow an anonymous user to be invited with incomplete input
#    Given "joanne" is an anonymous user
#    When I go to the invitation request form
#    And I fill in "Su nombre completo" with "<name>"
#    And I fill in "Su email" with "<email>"
#    And I press "¡Solicitar!"
#    Then I should have an unsuccessful invitation
#    And I should have <count> errors
#    And I should see "<error_message>"
#
#    Examples: incomplete invitation inputs
#      | name   | email              | count | error_message                                    |
#      |        |                    | 4 | Su email no puede estar vacio.                       |
#      | joanne |                    | 3 | Su email es demasiado corto (6 caracteres mínimo).   |
#      |        | joanne@example.com | 1 | Su nombre completo no puede estar vacio.             |
#  
#  Scenario: Send an invitation request mail at a successful account creation
#    Given "joanne" an invitation requested user
#    And admin should receive an email
#    When admin open the email
#    Then admin should see "joanne requests to be an invitee" in the email
#  
#  Scenario: Allow administrator to confirm the requested invitation
#    Given "joanne" an invitation requested user
#    And I logged in as an administrator
#    When I go to the invitations list page
#    Then I should see "joanne@example.com" can be invited
#    When I invite "joanne@example.com"
#    Then I should see "Invitacion enviada"
#    And "joanne@example.com" should receive 1 email
#  
#  Scenario: Want to confirm account using mail invitation token
#    Given "joanne" an invitation notified but unconfirmed user
#    And I follow "registrarme por invitación" in the email
#    Then I should see the invitation signup form
#    And the "Nombre" field should contain "joanne"
#    And the "Email" field should contain "joanne@example.com"
#  
#  Scenario: Do not confirm an account with invalid mail invitation token
#    Given "joanne" an invitation notified but unconfirmed user
#    When I go to the invitation accept form with bad token
#    Then I should see the home page
#  
#  Scenario: Activate account using mail invitation token with password
#    Given "joanne" an invitation notified but unconfirmed user
#    When I follow "registrarme por invitación" in the email
#    And I should see the activation form
#    When I fill in "Nombre" with "joanne"
#    And I fill in "Email" with "joanne@example.com"
#    And I fill in "Usuario" with "joanne"
#    And I fill in "Escriba su contraseña" with "secret"
#    And I fill in "Confirmación contraseña" with "secret"
#    And I press "Enviar"
#    Then I should have a successful activation
#    And I should be logged in
#    When I follow "Cerrar Sesión"
#    Then I should be logged out
#  
#  Scenario Outline: Activate account using mail activation token with bad inputs
#    Given "joanne" an invitation notified but unconfirmed user
#    When I follow "registrarme por invitación" in the email
#    And I should see the activation form
#    When I fill in "Nombre" with "<name>"
#    And I fill in "Email" with "<email>"
#    And I fill in "Usuario" with "<login>"
#    And I fill in "Escriba su contraseña" with "<password>"
#    And I fill in "Confirmación contraseña" with "<confirmation>"
#    And I press "Enviar"
#    Then I should have an unsuccessful activation
#    And I should have <count> errors
#    And I should see "<error_message>"
#
#    Examples: Bad inputs
#      | name   | email              | login  | password | confirmation | count | error_message                                                      |
#      |        |                    |        |          | x            | 8     | Nombre no puede estar vacio.                                       |
#      |        |                    |        |          | x            | 8     | Email es demasiado corto (6 caracteres mínimo).                   |
#      |        | oops               |        |          | x            | 8     | Email debería ser una dirección de email.                          |
#      | joanne | joanne@example.com |        |          | x            | 5     | Usuario es demasiado corto (3 caracteres mínimo).                 |
#      | joanne | joanne@example.com | joanne |          | x            | 3     | Contraseña es demasiado corta (4 caracteres mínimo).              |
#      | joanne | joanne@example.com |        | secret   |              | 4     | Confirmación contraseña es demasiado corta (4 caracteres mínimo). |
#      | joanne | joanne@example.com |        |          | secret       | 4     | Usuario por favor utilizar solo letras, números, espacios y .-_@.  |
#      | joanne | joanne@example.com | joanne | secret   |              | 2     | Confirmación contraseña es demasiado corta (4 caracteres mínimo). |
#      | joanne | joanne@example.com | joanne |          | secret       | 2     | Contraseña es demasiado corta (4 caracteres mínimo).              |
#      | joanne | joanne@example.com |        | secret   | secret       | 2     | Usuario es demasiado corto (3 caracteres mínimo).                 |
#      | joanne | joanne@example.com | joanne |          | not a secret | 2     | Contraseña es demasiado corta (4 caracteres mínimo).              |
#      | joanne | joanne@example.com | joanne | secret   | not a secret | 1     | Contraseña no coincide con la confirmación                         |
#      | joanne | joanne@example.com |        | secret   | not a secret | 3     | Contraseña no coincide con la confirmación                         |
#      | joanne | joanne@example.com | joanne | secret   | not a secret | 1     | Contraseña no coincide con la confirmación                         |
#
#  Scenario: Send an activation confirmation mail when user confirms account
#    Given "joanne" an invitation notified but unconfirmed user
#    When I follow "registrarme por invitación" in the email
#    And I fill in "Usuario" with "joanne"
#    And I fill in "Escriba su contraseña" with "secret"
#    And I fill in "Confirmación contraseña" with "secret"
#    And I press "Enviar"
#    Then I should be logged in
#    And I should have 2 emails at all
#    When I open the most recent email
#    Then I should see "Activación Completa" in the email subject
#    When I follow "Cerrar Sesión"
#    Then I should be logged out
#  
#